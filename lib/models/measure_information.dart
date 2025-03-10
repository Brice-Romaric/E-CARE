import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_care/models/model.dart';

class MeasureInformation extends Model {
  static final bool isRegisteredModel = (() {
    Model.registerModel<MeasureInformation>(ModelInfo(modelFields: [
      "user_id",
      "measure_id",
      "date",
      "value"
    ], callables: [
      MeasureInformation.new,
      MeasureInformation.fromFirebaseDocument,
      MeasureInformation.fromJson,
      MeasureInformation.fromRawJson
    ], relations: {
      "user": null,
      "measure": null
    }));
    return true;
  })();

  RelationData _userId;
  RelationData _measureId;
  DateTime _date;
  double _value;

  MeasureInformation({
    super.id,
    required dynamic userId,
    required dynamic measureId,
    DateTime? date,
    required double value,
  })  : _userId = RelationData.fromValue(userId),
        _measureId = RelationData.fromValue(measureId),
        _date = date ?? DateTime.now(),
        _value = value,
        super(isRegisteredModel: MeasureInformation.isRegisteredModel);

  RelationData get userId => _userId;

  set userId(dynamic value) {
    _userId.data = value;
  }

  RelationData get measureId => _measureId;

  set measureId(dynamic value) {
    _measureId.data = value;
  }

  DateTime get date => _date;

  set date(DateTime newDate) {
    if (_date != newDate) {
      _date = newDate;
      notifyListeners();
    }
  }

  double get value => _value;

  set value(double newValue) {
    if (_value != newValue) {
      _value = newValue;
      notifyListeners();
    }
  }

  @override
  MeasureInformation copyWith({
    String? id,
    String? userId,
    String? measureId,
    DateTime? date,
    double? value,
  }) =>
      MeasureInformation(
        id: id ?? this.id,
        userId: userId ?? _userId,
        measureId: measureId ?? _measureId,
        date: date ?? _date,
        value: value ?? _value,
      );

  /// Constructeur permettant de créer une instance de ce modèle
  /// à partir d'un document de type DocumentSnapshot de Firebase
  factory MeasureInformation.fromFirebaseDocument(DocumentSnapshot document) {
    return MeasureInformation.fromJson(
        document.data()! as Map<String, dynamic>);
  }

  /// Constructeur permettant de créer une instance de ce modèle
  /// à partir d'un document JSON au format texte
  factory MeasureInformation.fromRawJson(String str) =>
      MeasureInformation.fromJson(json.decode(str));

  /// Constructeur permettant de créer une instance de ce modèle
  /// à partir d'un objet JSON (Map<String, dynamic>)
  factory MeasureInformation.fromJson(Map<String, dynamic> json) {
    return MeasureInformation(
      id: json["id"],
      userId: json["user_id"],
      measureId: json["measure_id"],
      date: DateTime.parse(json["date"]),
      value: (json["value"] as num).toDouble(),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": _userId.id,
        "measure_id": _measureId.id,
        "date": _date.toIso8601String(),
        "value": _value,
      };
}
