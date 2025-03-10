import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_care/models/model.dart';

class MedicalCondition extends Model {
  static final bool isRegisteredModel = (() {
    Model.registerModel<MedicalCondition>(ModelInfo(modelFields: [
      "name"
    ], callables: [
      MedicalCondition.new,
      MedicalCondition.fromFirebaseDocument,
      MedicalCondition.fromJson,
      MedicalCondition.fromRawJson
    ], relations: {}));
    return true;
  })();

  String _name;

  MedicalCondition({
    super.id,
    required String name,
  })  : _name = name,
        super(isRegisteredModel: MedicalCondition.isRegisteredModel);

  String get name => _name;

  set name(String value) {
    if (_name != value) {
      _name = value;
      notifyListeners();
    }
  }

  @override
  MedicalCondition copyWith({
    String? id,
    String? name,
  }) =>
      MedicalCondition(
        id: id ?? this.id,
        name: name ?? _name,
      );

  /// Constructeur permettant de créer une instance de ce modèle
  /// à partir d'un document de type DocumentSnapshot de Firebase
  factory MedicalCondition.fromFirebaseDocument(DocumentSnapshot document) {
    return MedicalCondition.fromJson(document.data()! as Map<String, dynamic>);
  }

  /// Constructeur permettant de créer une instance de ce modèle
  /// à partir d'un document JSON au format texte
  factory MedicalCondition.fromRawJson(String str) =>
      MedicalCondition.fromJson(json.decode(str));

  /// Constructeur permettant de créer une instance de ce modèle
  /// à partir d'un objet JSON (Map<String, dynamic>)
  factory MedicalCondition.fromJson(Map<String, dynamic> json) {
    return MedicalCondition(
      id: json["id"],
      name: json["name"],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": _name,
  };
}

