import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_care/models/model.dart';

class Medicament extends Model {
  static final bool isRegisteredModel = (() {
    Model.registerModel<Medicament>(ModelInfo(modelFields: [
      "codes",
      "name",
      "active_ingredient",
      "dosage",
      "dosage_unit",
      "form",
      "description",
      "retail_price",
      "hospital_price",
      "base_reimbursement_price",
      "brand_or_generic",
      "reimbursement_rate"
    ], callables: [
      Medicament.new,
      Medicament.fromFirebaseDocument,
      Medicament.fromJson,
      Medicament.fromRawJson
    ], relations: {
      "prescription": null
    }));
    return true;
  })();

  List<String> _codes;
  String _name;
  String _activeIngredient;
  String _dosage;
  String _dosageUnit;
  String _form;
  String? _description;
  double? _retailPrice;
  double? _hospitalPrice;
  double? _baseReimbursementPrice;
  String _brandOrGeneric;
  double _reimbursementRate;

  Medicament({
    super.id,
    required dynamic codes,
    required String name,
    required String activeIngredient,
    required String dosage,
    required String dosageUnit,
    required String form,
    String? description,
    required double? retailPrice,
    required double? hospitalPrice,
    required double? baseReimbursementPrice,
    required String brandOrGeneric,
    required double reimbursementRate,
  })  : _codes = codes is List
            ? codes.map((e) => e.toString()).toList()
            : [codes.toString()],
        _name = name,
        _activeIngredient = activeIngredient,
        _dosage = dosage,
        _dosageUnit = dosageUnit,
        _form = form,
        _description = description,
        _retailPrice = retailPrice,
        _hospitalPrice = hospitalPrice,
        _baseReimbursementPrice = baseReimbursementPrice,
        _brandOrGeneric = brandOrGeneric,
        _reimbursementRate = reimbursementRate,
        super(isRegisteredModel: Medicament.isRegisteredModel);

  // Getters et Setters avec notification
  List<String> get codes => _codes;

  set codes(List<String> value) {
    if (_codes != value) {
      _codes = value;
      notifyListeners();
    }
  }

  String get name => _name;

  set name(String value) {
    if (_name != value) {
      _name = value;
      notifyListeners();
    }
  }

  String get activeIngredient => _activeIngredient;

  set activeIngredient(String value) {
    if (_activeIngredient != value) {
      _activeIngredient = value;
      notifyListeners();
    }
  }

  String get dosage => _dosage;

  set dosage(String value) {
    if (_dosage != value) {
      _dosage = value;
      notifyListeners();
    }
  }

  String get dosageUnit => _dosageUnit;

  set dosageUnit(String value) {
    if (_dosageUnit != value) {
      _dosageUnit = value;
      notifyListeners();
    }
  }

  String get form => _form;

  set form(String value) {
    if (_form != value) {
      _form = value;
      notifyListeners();
    }
  }

  String? get description => _description;

  set description(String? value) {
    if (_description != value) {
      _description = value;
      notifyListeners();
    }
  }

  double? get retailPrice => _retailPrice;

  set retailPrice(double? value) {
    if (_retailPrice != value) {
      _retailPrice = value;
      notifyListeners();
    }
  }

  double? get hospitalPrice => _hospitalPrice;

  set hospitalPrice(double? value) {
    if (_hospitalPrice != value) {
      _hospitalPrice = value;
      notifyListeners();
    }
  }

  double? get baseReimbursementPrice => _baseReimbursementPrice;

  set baseReimbursementPrice(double? value) {
    if (_baseReimbursementPrice != value) {
      _baseReimbursementPrice = value;
      notifyListeners();
    }
  }

  String get brandOrGeneric => _brandOrGeneric;

  set brandOrGeneric(String value) {
    if (_brandOrGeneric != value) {
      _brandOrGeneric = value;
      notifyListeners();
    }
  }

  double get reimbursementRate => _reimbursementRate;

  set reimbursementRate(double value) {
    if (_reimbursementRate != value) {
      _reimbursementRate = value;
      notifyListeners();
    }
  }

  @override
  Medicament copyWith({
    String? id,
    List<String>? codes,
    String? name,
    String? activeIngredient,
    String? dosage,
    String? dosageUnit,
    String? form,
    String? description,
    double? retailPrice,
    double? hospitalPrice,
    double? baseReimbursementPrice,
    String? brandOrGeneric,
    double? reimbursementRate,
  }) =>
      Medicament(
        id: id ?? this.id,
        codes: codes ?? _codes,
        name: name ?? _name,
        activeIngredient: activeIngredient ?? _activeIngredient,
        dosage: dosage ?? _dosage,
        dosageUnit: dosageUnit ?? _dosageUnit,
        form: form ?? _form,
        description: description ?? _description,
        retailPrice: retailPrice ?? _retailPrice,
        hospitalPrice: hospitalPrice ?? _hospitalPrice,
        baseReimbursementPrice:
            baseReimbursementPrice ?? _baseReimbursementPrice,
        brandOrGeneric: brandOrGeneric ?? _brandOrGeneric,
        reimbursementRate: reimbursementRate ?? _reimbursementRate,
      );

  /// Constructeur permettant de créer une instance à partir d'un document Firebase
  factory Medicament.fromFirebaseDocument(DocumentSnapshot document) {
    return Medicament.fromJson(document.data()! as Map<String, dynamic>);
  }

  /// Constructeur permettant de créer une instance à partir d'un JSON brut
  factory Medicament.fromRawJson(String str) =>
      Medicament.fromJson(json.decode(str));

  /// Constructeur permettant de créer une instance à partir d'un objet JSON
  factory Medicament.fromJson(Map<String, dynamic> json) {
    return Medicament(
      id: json["id"],
      codes: json["codes"],
      name: json["name"],
      activeIngredient: json["active_ingredient"],
      dosage: json["dosage"],
      dosageUnit: json["dosage_unit"],
      form: json["form"],
      description: json["description"],
      retailPrice: json["retail_price"],
      hospitalPrice: json["hospital_price"],
      baseReimbursementPrice: json["base_reimbursement_price"],
      brandOrGeneric: json["brand_or_generic"],
      reimbursementRate: json["reimbursement_rate"],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "codes": _codes,
        "name": _name,
        "active_ingredient": _activeIngredient,
        "dosage": _dosage,
        "dosage_unit": _dosageUnit,
        "form": _form,
        "description": _description,
        "retail_price": _retailPrice,
        "hospital_price": _hospitalPrice,
        "base_reimbursement_price": _baseReimbursementPrice,
        "brand_or_generic": _brandOrGeneric,
        "reimbursement_rate": _reimbursementRate,
      };
}
