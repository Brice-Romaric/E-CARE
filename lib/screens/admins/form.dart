import 'package:e_care/providers/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_care/models/model.dart';
import 'package:e_care/repositories/repository.dart';
import 'package:provider/provider.dart';

extension FormStringExtension on String {
  String toCapitalCase() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String snakeToCapitalCase() {
    return split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}

abstract class FormScreen<T extends Model> extends StatefulWidget {
  final T? item;
  final String title;
  final Repository<T> repository;
  final Map<String, dynamic> fields = {};
  final Map<String, dynamic> extraFields = {};
  final List controllers = [];
  final bool? isMasculine;
  String? authenticationIdentifier;

  FormScreen(
      {super.key,
      this.item,
      required this.title,
      required this.repository,
      this.isMasculine,
      this.authenticationIdentifier});

  @override
  State<FormScreen<T>> createState() => _FormScreenState<T>();

  Widget buildFieldsContainer(BuildContext context);

  void onSave(String? name, dynamic value) {
    if (name != null) {
      if (name.startsWith("%")) {
        extraFields[name.replaceAll("%", "")] = value;
      } else {
        fields[name] = value;
      }
    }
  }

  void onSubmit(BuildContext context, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        ModelInfo modelInfo = Model.modelInfoOf<T>()!;
        Function fromJson = modelInfo.getCallable("fromJson");
        if (item == null) {
          // Ajout
          T i;
          if (authenticationIdentifier != null) {
            final currentUser = Provider.of<UserProvider>(
                context,
                listen: false).currentUser;
            final userCredential = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: extraFields[authenticationIdentifier] ??
                        fields[authenticationIdentifier]!,
                    password: extraFields["password"] ??
                        fields["password"]!);
            i = await repository
                .set({"id": userCredential.user!.uid, ...fields});
            await FirebaseAuth.instance.signOut();
            await currentUser!.login();
          } else {
            i = await repository.create(fromJson(fields));
          }
          for (var entry in fields.entries) {
            if (!modelInfo.fields.contains(entry.key)) {
              var tableName = ModelInfo.collectionNameToModelName(entry.key);
              if (entry.value is List) {
                var relationName = modelInfo.relations[tableName];
                if (relationName != null) {
                  await repository.addManyMany(i, relationName,
                      tableName: tableName, others: entry.value);
                } else {
                  await repository.addMany(i,
                      tableName: tableName, others: entry.value);
                }
              } else {
                await repository.setOne(i, entry.value, tableName: tableName);
              }
            }
          }
        } else {
          // Modification
          T i = await repository.update(fromJson({...fields, "id": item!.id}));
          for (var entry in fields.entries) {
            if (!modelInfo.fields.contains(entry.key)) {
              var tableName = ModelInfo.collectionNameToModelName(entry.key);
              if (entry.value is List) {
                var relationName = modelInfo.relations[tableName];
                if (relationName != null) {
                  await repository.removeManyMany(i, relationName,
                      tableName: tableName, all: true);
                  await repository.addManyMany(i, relationName,
                      tableName: tableName, others: entry.value);
                } else {
                  await repository.removeMany(i,
                      tableName: tableName, all: true);
                  await repository.addMany(i,
                      tableName: tableName, others: entry.value);
                }
              } else {
                await repository.setOne(i, entry.value, tableName: tableName);
              }
            }
          }
        }
        Navigator.pop(context, true);
      } catch (e) {
        print('Erreur Impossible de sauvegarder : ${e}');
      } finally {}
    }
  }
}

class _FormScreenState<T extends Model> extends State<FormScreen<T>> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var lowerTitle = widget.title.toLowerCase();
    var capitalTitle = widget.title.toCapitalCase();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "${capitalTitle}s",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Text(
                  "${widget.item != null ? 'Modifier' : 'Ajouter'} ${(widget.isMasculine ?? true) ? 'un' : 'une'} $lowerTitle",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                    key: _formKey, child: widget.buildFieldsContainer(context)),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () => widget.onSubmit(context, _formKey),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 5, bottom: 5),
                    child: Text(widget.item != null ? 'Modifier' : 'Ajouter'),
                  ),
                ),
              ],
            )));
  }
}
