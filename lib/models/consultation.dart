import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_care/models/model.dart';

class Consultation extends Model {
  static final bool isRegisteredModel = (() {
    Model.registerModel<Consultation>(ModelInfo(modelFields: [
      "notes",
      "date",
      "doctor_id",
      "patient_id"
    ], callables: [
      Consultation.new,
      Consultation.fromFirebaseDocument,
      Consultation.fromJson,
      Consultation.fromRawJson
    ], relations: {
      "user": null,
      "prescription": null
    }));
    return true;
  })();

  String _notes;
  DateTime _date;
  RelationData _doctorId;
  RelationData _patientId;

  Consultation({
    super.id,
    required String notes,
    required DateTime date,
    required dynamic doctorId,
    required dynamic patientId,
  })  : _notes = notes,
        _date = date,
        _doctorId = RelationData.fromValue(doctorId),
        _patientId = RelationData.fromValue(patientId),
        super(isRegisteredModel: Consultation.isRegisteredModel);

  // Getters et setters avec notification
  String get notes => _notes;

  set notes(String value) {
    if (_notes != value) {
      _notes = value;
      notifyListeners();
    }
  }

  DateTime get date => _date;

  set date(DateTime value) {
    if (_date != value) {
      _date = value;
      notifyListeners();
    }
  }

  RelationData get doctorId => _doctorId;

  set doctorId(dynamic value) {
    _doctorId.data = value;
  }

  RelationData get patientId => _patientId;

  set patientId(dynamic value) {
    _patientId.data = value;
  }

  @override
  Consultation copyWith({
    String? id,
    String? notes,
    DateTime? date,
    String? doctorId,
    String? patientId,
  }) =>
      Consultation(
        id: id ?? this.id,
        notes: notes ?? _notes,
        date: date ?? _date,
        doctorId: doctorId ?? _doctorId,
        patientId: patientId ?? _patientId,
      );

  /// Constructeur permettant de créer une instance à partir d'un document Firebase
  factory Consultation.fromFirebaseDocument(DocumentSnapshot document) {
    return Consultation.fromJson(document.data()! as Map<String, dynamic>);
  }

  /// Constructeur permettant de créer une instance à partir d'un JSON brut
  factory Consultation.fromRawJson(String str) =>
      Consultation.fromJson(json.decode(str));

  /// Constructeur permettant de créer une instance à partir d'un objet JSON
  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
      id: json["id"],
      notes: json["notes"],
      date: DateTime.parse(json["date"]),
      doctorId: json["doctor_id"],
      patientId: json["patient_id"],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "notes": _notes,
        "date": _date.toIso8601String(),
        "doctor_id": _doctorId.id,
        "patient_id": _patientId.id,
      };
}
