import 'package:e_care/models/hospital.dart';
import 'package:flutter/material.dart';
import 'package:e_care/models/model.dart';
import 'package:e_care/models/user.dart';
import 'package:e_care/repositories/user.dart';
import 'package:e_care/screens/admins/details.dart';
import 'package:e_care/screens/admins/form.dart';
import 'package:e_care/screens/admins/management.dart';
import 'package:e_care/widgets/field.dart';
import 'package:e_care/repositories/hospital.dart';
import 'package:e_care/widgets/async_builder.dart';

class HospitalAdminFormScreen extends FormScreen<User> {
  HospitalAdminFormScreen(
      {super.key,
      super.item,
      required super.title,
      required super.repository,
      super.isMasculine,
      super.authenticationIdentifier});

  @override
  Widget buildFieldsContainer(BuildContext context) {
    return AsyncBuilder<List<Hospital>>(
        future: HospitalRepository.instance.getAll(),
        builder: (_, data) {
          var all = data;
          return Column(
            children: [
              Field<String>(
                placeholder: "Nom",
                required: true,
                initialValue: item?['last_name'],
                name: "last_name",
                onSave: onSave,
              ),
              Field<String>(
                placeholder: "Prénom",
                required: true,
                initialValue: item?['first_name'],
                name: "first_name",
                onSave: onSave,
              ),
              Field<String>(
                placeholder: "Téléphone",
                required: true,
                initialValue: item?['phone'],
                name: "phone",
                onSave: onSave,
              ),
              Field<String>(
                placeholder: "Email",
                type: "email",
                required: true,
                initialValue: item?['email'],
                name: "email",
                onSave: onSave,
              ),
              if (item == null)
                Field<String>(
                  placeholder: "Mot de passe",
                  required: true,
                  type: "password",
                  name: "%password%",
                  // "%%" champs non destine a l'entite
                  onSave: onSave,
                ),
              Field<Gender>(
                type: "select",
                placeholder: "Genre",
                required: true,
                initialValue: item?['gender'],
                name: "gender",
                selectOptions: Gender.values,
                onSave: onSave,
              ),
              Field<Role>(
                type: "select",
                placeholder: "Rôle",
                required: true,
                hidden: true,
                initialValue: Role.hospitalAdmin,
                name: "role",
                selectOptions: Role.values,
                onSave: onSave,
              ),
              AsyncBuilder<Hospital?>(
                  future: item != null
                      ? UserRepository.instance.getOne<Hospital>(item)
                      : Future<Hospital?>.value(null),
                  builder: (_, data) {
                    return Field<Hospital>(
                      onSave: onSave,
                      selectMultiple: false,
                      initialValue: data,
                      type: "select",
                      placeholder: "Hôpital",
                      required: true,
                      name: "hospital_id",
                      selectOptions: all,
                      selectLabelField: "name",
                    );
                  }),
            ],
          );
        });
  }
}

class HospitalAdminDetailsScreen extends DetailsScreen<User> {
  const HospitalAdminDetailsScreen(
      {super.key, required super.title, required super.item});

  @override
  Widget buildFieldsContainer(BuildContext context) {
    return AsyncBuilder<Hospital?>(
        future: UserRepository.instance.getOne<Hospital>(item),
        builder: ((_, data) {
          return Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Nom : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(item.lastName)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Prénom : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(item.firstName)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Email : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(item.email)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Téléphone : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(item.phone)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Genre : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(item.gender.toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Hôpital : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(data?.name ?? "")
              ],
            ),
          ]);
        }));
  }
}

class HospitalAdminManagementScreen extends ManagementScreen<User> {
  HospitalAdminManagementScreen({super.key}) {
    title = "Administateurs d'hôpital";
    subtitle = "Administateur d'hôpital";
    cardTitleFields = ["first_name", "last_name"];
    cardSubtitleFields = ["email"];
    onSearchFields = Model.modelInfoOf<User>()?.fields ?? [];
    repository = UserRepository.instance;
    maxItems = 50;
    leading = Icons.person;
    image = null;
    customFilter = {"role": Role.hospitalAdmin.toString()};
    authenticationIdentifier = "email";
  }

  @override
  buildFormScreen(BuildContext context, String title, dynamic item) {
    return HospitalAdminFormScreen(
        title: title,
        repository: repository,
        item: item,
        isMasculine: isMasculine,
        authenticationIdentifier: authenticationIdentifier);
  }

  @override
  DetailsScreen<Model> buildDetailsScreen(
      BuildContext context, String title, item) {
    return HospitalAdminDetailsScreen(title: title, item: item);
  }
}
