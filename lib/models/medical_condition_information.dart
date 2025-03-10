import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_care/models/model.dart';

class MedicalConditionInformation extends Model {
  static final bool isRegisteredModel = (() {
    Model.registerModel<MedicalConditionInformation>(ModelInfo(modelFields: [
      "user_id",
      "medical_condition_id",
      "value",
      "description",
      "date",
      "valid"
    ], callables: [
      MedicalConditionInformation.new,
      MedicalConditionInformation.fromFirebaseDocument,
      MedicalConditionInformation.fromJson,
      MedicalConditionInformation.fromRawJson
    ], relations: {
      "user": null,
      "medical_condition": null
    }));
    return true;
  })();

  RelationData _userId;
  RelationData _medicalConditionId;
  String _value;
  String _description;
  DateTime _date;
  bool _valid;

  MedicalConditionInformation({
    super.id,
    required dynamic userId,
    required dynamic medicalConditionId,
    required String value,
    required String description,
    required DateTime? date,
    required bool valid,
  })  : _userId = RelationData.fromValue(userId),
        _medicalConditionId = RelationData.fromValue(medicalConditionId),
        _value = value,
        _description = description,
        _date = date ?? DateTime.now(),
        _valid = valid,
        super(isRegisteredModel: MedicalConditionInformation.isRegisteredModel);

  RelationData get userId => _userId;

  set userId(dynamic value) {
    _userId.data = value;
  }

  RelationData get medicalConditionId => _medicalConditionId;

  set medicalConditionId(dynamic value) {
    _medicalConditionId.data = value;
  }

  String get value => _value;

  set value(String newValue) {
    if (_value != newValue) {
      _value = newValue;
      notifyListeners();
    }
  }

  String get description => _description;

  set description(String newDescription) {
    if (_description != newDescription) {
      _description = newDescription;
      notifyListeners();
    }
  }

  DateTime get date => _date;

  set date(DateTime newDate) {
    if (_date != newDate) {
      _date = newDate;
      notifyListeners();
    }
  }

  bool get valid => _valid;

  set valid(bool newValid) {
    if (_valid != newValid) {
      _valid = newValid;
      notifyListeners();
    }
  }

  @override
  MedicalConditionInformation copyWith({
    String? id,
    dynamic userId,
    dynamic medicalConditionId,
    String? value,
    String? description,
    DateTime? date,
    bool? valid,
  }) =>
      MedicalConditionInformation(
        id: id ?? this.id,
        userId: userId ?? _userId,
        medicalConditionId: medicalConditionId ?? _medicalConditionId,
        value: value ?? _value,
        description: description ?? _description,
        date: date ?? _date,
        valid: valid ?? _valid,
      );

  /// Constructeur permettant de créer une instance de ce modèle
  /// à partir d'un document de type DocumentSnapshot de Firebase
  factory MedicalConditionInformation.fromFirebaseDocument(
      DocumentSnapshot document) {
    return MedicalConditionInformation.fromJson(
        document.data()! as Map<String, dynamic>);
  }

  /// Constructeur permettant de créer une instance de ce modèle
  /// à partir d'un document JSON au format texte
  factory MedicalConditionInformation.fromRawJson(String str) =>
      MedicalConditionInformation.fromJson(json.decode(str));

  /// Constructeur permettant de créer une instance de ce modèle
  /// à partir d'un objet JSON (Map<String, dynamic>)
  factory MedicalConditionInformation.fromJson(Map<String, dynamic> json) {
    return MedicalConditionInformation(
      id: json["id"],
      userId: json["user_id"],
      medicalConditionId: json["medical_condition_id"],
      value: json["value"],
      description: json["description"],
      date: DateTime.parse(json["date"]),
      valid: json["valid"] ?? false,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": _userId.id,
        "medical_condition_id": _medicalConditionId.id,
        "value": _value,
        "description": _description,
        "date": _date.toIso8601String(),
        "valid": _valid,
      };
}
