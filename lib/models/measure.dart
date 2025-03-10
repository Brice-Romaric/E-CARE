import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_care/models/model.dart';

class Measure extends Model {
  static final bool isRegisteredModel = (() {
    Model.registerModel<Measure>(ModelInfo(modelFields: [
      "name",
      "unit",
      "type"
    ], callables: [
      Measure.new,
      Measure.fromFirebaseDocument,
      Measure.fromJson,
      Measure.fromRawJson
    ], relations: {}));
    return true;
  })();

  String _name;
  String _unit;
  String _type;

  Measure({
    super.id,
    required String name,
    required String unit,
    required String type,
  })  : _name = name,
        _unit = unit,
        _type = type,
        super(isRegisteredModel: Measure.isRegisteredModel);

  String get name => _name;

  set name(String value) {
    if (_name != value) {
      _name = value;
      notifyListeners();
    }
  }

  String get unit => _unit;

  set unit(String value) {
    if (_unit != value) {
      _unit = value;
      notifyListeners();
    }
  }

  String get type => _type;

  set type(String value) {
    if (_type != value) {
      _type = value;
      notifyListeners();
    }
  }

  @override
  Measure copyWith({
    String? id,
    String? name,
    String? unit,
    String? type,
  }) =>
      Measure(
        id: id ?? this.id,
        name: name ?? _name,
        unit: unit ?? _unit,
        type: type ?? _type,
      );

  /// Constructeur permettant de créer une instance de ce modèle
  /// à partir d'un document de type DocumentSnapshot de Firebase
  factory Measure.fromFirebaseDocument(DocumentSnapshot document) {
    return Measure.fromJson(document.data()! as Map<String, dynamic>);
  }

  /// Constructeur permettant de créer une instance de ce modèle
  /// à partir d'un document JSON au format texte
  factory Measure.fromRawJson(String str) => Measure.fromJson(json.decode(str));

  /// Constructeur permettant de créer une instance de ce modèle
  /// à partir d'un objet JSON (Map<String, dynamic>)
  factory Measure.fromJson(Map<String, dynamic> json) {
    return Measure(
      id: json["id"],
      name: json["name"],
      unit: json["unit"],
      type: json["type"],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": _name,
    "unit": _unit,
    "type": _type,
  };
}

