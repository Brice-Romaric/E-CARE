import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_care/models/model.dart';

class Hospital extends Model {
  static final bool isRegisteredModel = (() {
    Model.registerModel<Hospital>(ModelInfo(modelFields: [
      "name"
    ], callables: [
      Hospital.new,
      Hospital.fromFirebaseDocument,
      Hospital.fromJson,
      Hospital.fromRawJson
    ], relations: {
      "user": null
    }));
    return true;
  })();

  String _name;

  Hospital({
    super.id,
    required String name,
  })  : _name = name,
        super(isRegisteredModel: Hospital.isRegisteredModel);

  String get name => _name;

  set name(String value) {
    if (_name != value) {
      _name = value;
      notifyListeners();
    }
  }

  @override
  Hospital copyWith({
    String? id,
    String? name,
  }) =>
      Hospital(
        id: id ?? this.id,
        name: name ?? _name,
      );

  /// Constructeur permettant de créer une instance de ce modèle
  /// à partir d'un document de type DocumentSnapshot de Firebase
  factory Hospital.fromFirebaseDocument(DocumentSnapshot document) {
    return Hospital.fromJson(document.data()! as Map<String, dynamic>);
  }

  /// Constructeur permettant de créer une instance de ce modèle
  /// à partir d'un document JSON au format texte
  factory Hospital.fromRawJson(String str) =>
      Hospital.fromJson(json.decode(str));

  /// Constructeur permettant de créer une instance de ce modèle
  /// à partir d'un objet JSON (Map<String, dynamic>)
  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
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
