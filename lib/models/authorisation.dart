import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_care/models/model.dart';

class Authorisation extends Model {
  static final bool isRegisteredModel = (() {
    Model.registerModel<Authorisation>(ModelInfo(modelFields: [
      "applicant_id",
      "requested_id",
      "status",
      "date",
      "expire_at"
    ], callables: [
      Authorisation.new,
      Authorisation.fromFirebaseDocument,
      Authorisation.fromJson,
      Authorisation.fromRawJson
    ], relations: {
      "user": null
    }));
    return true;
  })();

  RelationData _applicantId;
  RelationData _requestedId;
  String _status;
  DateTime _date;
  DateTime _expireAt;

  Authorisation({
    super.id,
    required dynamic applicantId,
    required dynamic requestedId,
    required String status,
    required DateTime date,
    required DateTime expireAt,
  })  : _applicantId = RelationData.fromValue(applicantId),
        _requestedId = RelationData.fromValue(requestedId),
        _status = status,
        _date = date,
        _expireAt = expireAt,
        super(isRegisteredModel: Authorisation.isRegisteredModel);

  // Getters et setters avec notification
  RelationData get applicantId => _applicantId;

  set applicantId(dynamic value) {
    _applicantId.data = value;
  }

  RelationData get requestedId => _requestedId;

  set requestedId(dynamic value) {
    _requestedId.data = value;
  }

  String get status => _status;

  set status(String value) {
    if (_status != value) {
      _status = value;
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

  DateTime get expireAt => _expireAt;

  set expireAt(DateTime value) {
    if (_expireAt != value) {
      _expireAt = value;
      notifyListeners();
    }
  }

  @override
  Authorisation copyWith({
    String? id,
    String? applicantId,
    String? requestedId,
    String? status,
    DateTime? date,
    DateTime? expireAt,
  }) =>
      Authorisation(
        id: id ?? this.id,
        applicantId: applicantId ?? _applicantId,
        requestedId: requestedId ?? _requestedId,
        status: status ?? _status,
        date: date ?? _date,
        expireAt: expireAt ?? _expireAt,
      );

  /// Constructeur permettant de créer une instance à partir d'un document Firebase
  factory Authorisation.fromFirebaseDocument(DocumentSnapshot document) {
    return Authorisation.fromJson(document.data()! as Map<String, dynamic>);
  }

  /// Constructeur permettant de créer une instance à partir d'un JSON brut
  factory Authorisation.fromRawJson(String str) =>
      Authorisation.fromJson(json.decode(str));

  /// Constructeur permettant de créer une instance à partir d'un objet JSON
  factory Authorisation.fromJson(Map<String, dynamic> json) {
    return Authorisation(
      id: json["id"],
      applicantId: json["applicant_id"],
      requestedId: json["requested_id"],
      status: json["status"],
      date: DateTime.parse(json["date"]),
      expireAt: DateTime.parse(json["expire_at"]),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "applicant_id": _applicantId.id,
        "requested_id": _requestedId.id,
        "status": _status,
        "date": _date.toIso8601String(),
        "expire_at": _expireAt.toIso8601String(),
      };
}
