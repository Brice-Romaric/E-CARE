import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_care/models/model.dart';

class RDV extends Model {
  static final bool isRegisteredModel = (() {
    Model.registerModel<RDV>(ModelInfo(modelFields: [
      "user_id",
      "hospital_id",
      "object",
      "description",
      "date"
    ], callables: [
      RDV.new,
      RDV.fromFirebaseDocument,
      RDV.fromJson,
      RDV.fromRawJson
    ], relations: {
      "user": null,
      "hospital": null
    }));
    return true;
  })();

  RelationData _userId;
  RelationData _hospitalId;
  String _object;
  String _description;
  DateTime _date;

  RDV({
    super.id,
    required dynamic userId,
    required dynamic hospitalId,
    required String object,
    required String description,
    required DateTime date,
  })  : _userId = RelationData.fromValue(userId),
        _hospitalId = RelationData.fromValue(hospitalId),
        _object = object,
        _description = description,
        _date = date,
        super(isRegisteredModel: RDV.isRegisteredModel);

  RelationData get userId => _userId;

  set userId(dynamic value) {
    _userId.data = value;
  }

  RelationData get hospitalId => _hospitalId;

  set hospitalId(dynamic value) {
    _hospitalId.data = value;
  }

  String get object => _object;

  set object(String value) {
    if (_object != value) {
      _object = value;
      notifyListeners();
    }
  }

  String get description => _description;

  set description(String value) {
    if (_description != value) {
      _description = value;
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

  @override
  RDV copyWith({
    String? id,
    dynamic userId,
    dynamic hospitalId,
    String? object,
    String? description,
    DateTime? date,
  }) =>
      RDV(
        id: id ?? this.id,
        userId: userId ?? _userId,
        hospitalId: hospitalId ?? _hospitalId,
        object: object ?? _object,
        description: description ?? _description,
        date: date ?? _date,
      );

  /// Constructeur permettant de créer une instance de ce modèle
  /// à partir d'un document de type DocumentSnapshot de Firebase
  factory RDV.fromFirebaseDocument(DocumentSnapshot document) {
    return RDV.fromJson(document.data()! as Map<String, dynamic>);
  }

  /// Constructeur permettant de créer une instance de ce modèle
  /// à partir d'un document JSON au format texte
  factory RDV.fromRawJson(String str) => RDV.fromJson(json.decode(str));

  /// Constructeur permettant de créer une instance de ce modèle
  /// à partir d'un objet JSON (Map<String, dynamic>)
  factory RDV.fromJson(Map<String, dynamic> json) {
    return RDV(
      id: json["id"],
      userId: json["user_id"],
      hospitalId: json["hospital_id"],
      object: json["object"],
      description: json["description"],
      date: DateTime.parse(json["date"]),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": _userId.id,
        "hospital_id": _hospitalId.id,
        "object": _object,
        "description": _description,
        "date": _date.toIso8601String(),
      };
}
