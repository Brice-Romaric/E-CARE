import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_care/models/model.dart';

class Prescription extends Model {
  static final bool isRegisteredModel = (() {
    Model.registerModel<Prescription>(ModelInfo(modelFields: [
      "dosage",
      "valid",
      "medicament_id",
      "consultation_id"
    ], callables: [
      Prescription.new,
      Prescription.fromFirebaseDocument,
      Prescription.fromJson,
      Prescription.fromRawJson
    ], relations: {
      "medicament": null,
      "consultation": null
    }));
    return true;
  })();

  double _dosage;
  bool _valid;
  RelationData _medicamentId;
  RelationData _consultationId;

  Prescription({
    super.id,
    required double dosage,
    required bool valid,
    required dynamic medicamentId,
    required dynamic consultationId,
  })  : _dosage = dosage,
        _valid = valid,
        _medicamentId = RelationData.fromValue(medicamentId),
        _consultationId = RelationData.fromValue(consultationId),
        super(isRegisteredModel: Prescription.isRegisteredModel);

  // Getters et setters avec notification
  double get dosage => _dosage;

  set dosage(double value) {
    if (_dosage != value) {
      _dosage = value;
      notifyListeners();
    }
  }

  bool get valid => _valid;

  set valid(bool value) {
    if (_valid != value) {
      _valid = value;
      notifyListeners();
    }
  }

  RelationData get medicamentId => _medicamentId;

  set medicamentId(dynamic value) {
    _medicamentId.data = value;
  }

  RelationData get consultationId => _consultationId;

  set consultationId(dynamic value) {
    _consultationId.data = value;
  }

  @override
  Prescription copyWith({
    String? id,
    double? dosage,
    bool? valid,
    String? medicamentId,
    String? consultationId,
  }) =>
      Prescription(
        id: id ?? this.id,
        dosage: dosage ?? _dosage,
        valid: valid ?? _valid,
        medicamentId: medicamentId ?? _medicamentId,
        consultationId: consultationId ?? _consultationId,
      );

  /// Constructeur permettant de créer une instance à partir d'un document Firebase
  factory Prescription.fromFirebaseDocument(DocumentSnapshot document) {
    return Prescription.fromJson(document.data()! as Map<String, dynamic>);
  }

  /// Constructeur permettant de créer une instance à partir d'un JSON brut
  factory Prescription.fromRawJson(String str) =>
      Prescription.fromJson(json.decode(str));

  /// Constructeur permettant de créer une instance à partir d'un objet JSON
  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      id: json["id"],
      dosage: (json["dosage"] as num).toDouble(),
      valid: json["valid"] as bool,
      medicamentId: json["medicament_id"],
      consultationId: json["consultation_id"],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "dosage": _dosage,
        "valid": _valid,
        "medicament_id": _medicamentId.id,
        "consultation_id": _consultationId.id,
      };
}
