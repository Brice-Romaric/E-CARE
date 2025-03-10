import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_care/models/model.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Gender {
  man(value: "Homme"),
  woman(value: "Femme");

  const Gender({required this.value});

  final String value;

  static Gender? fromValue(dynamic value) {
    value = value.toString();
    switch (value.trim().toLowerCase()) {
      case "man":
      case "homme":
        return Gender.man;
      case "woman":
      case "femme":
        return Gender.woman;
      default:
        return null;
    }
  }

  @override
  String toString() {
    return value;
  }

  bool equals(dynamic other) {
    if (other != null) {
      switch (other.runtimeType) {
        case Gender:
          return this == other;
        default:
          switch (other.toString().trim().toLowerCase()) {
            case "man":
            case "homme":
              return this == Gender.man;
            case "woman":
            case "femme":
              return this == Gender.woman;
            default:
              return false;
          }
      }
    }
    return false;
  }
}

enum Role {
  patient(value: "patient"),
  doctor(value: "doctor"),
  hospitalAdmin(value: "hospital_admin"),
  superAdmin(value: "super_admin"),
  ;

  const Role({required this.value});

  final String value;

  static Role? fromValue(dynamic value) {
    value = value.toString().trim().toLowerCase();
    value = value.replaceAll(RegExp(r"(\s|-)+"), "_");
    switch (value.trim().toLowerCase()) {
      case "patient":
        return Role.patient;
      case "doctor":
        return Role.doctor;
      case "hospital_admin":
      case "hospitalAdmin":
        return Role.hospitalAdmin;
      case "super_admin":
      case "superAdmin":
        return Role.superAdmin;
      default:
        return null;
    }
  }

  @override
  String toString() {
    return value;
  }

  bool equals(dynamic other) {
    if (other != null) {
      switch (other.runtimeType) {
        case Gender:
          return this == other;
        default:
          String temp = other.toString().trim().toLowerCase();
          temp = temp.replaceAll(RegExp(r"(\s|-)+"), "_");
          switch (temp) {
            case "patient":
              return this == Role.patient;
            case "doctor":
              return this == Role.doctor;
            case "hospital_admin":
            case "hospitalAdmin":
              return this == Role.hospitalAdmin;
            case "super_admin":
            case "superAdmin":
              return this == Role.superAdmin;
            default:
              return false;
          }
      }
    }
    return false;
  }
}

extension DateTimeExtension on DateTime {
  static DateTime? fromValue(dynamic value) {
    if (value != null) {
      return value is DateTime ? value : DateTime.parse(value.toString());
    }
    return null;
  }
}

class User extends Model {
  static final bool isRegisteredModel = (() {
    Model.registerModel<User>(ModelInfo(modelFields: [
      "first_name",
      "last_name",
      "email",
      "role",
      "hospital_id",
      "phone",
      "gender",
      "birth_date",
      "blood_group",
      "protected_mode"
    ], callables: [
      User.new,
      User.fromFirebaseDocument,
      User.fromJson,
      User.fromRawJson
    ], relations: {
      "hospital": null
    }));
    return true;
  })();

  String _firstName;
  String _lastName;
  String _email;
  Role _role;
  RelationData _hospitalId;
  String _phone;
  Gender _gender;
  DateTime? _birthDate;
  String? _bloodGroup;
  bool? _protectedMode;

  User({
    super.id,
    required String firstName,
    required String lastName,
    required String email,
    required Object role,
    dynamic hospitalId,
    required String phone,
    required Object gender,
    dynamic birthDate,
    String? bloodGroup,
    bool? protectedMode,
  })  : _firstName = firstName,
        _lastName = lastName,
        _email = email,
        _role = Role.fromValue(role)!,
        _hospitalId = RelationData.fromValue(hospitalId),
        _phone = phone,
        _gender = Gender.fromValue(gender)!,
        _birthDate = DateTimeExtension.fromValue(birthDate),
        _bloodGroup = bloodGroup,
        _protectedMode = protectedMode,
        super(isRegisteredModel: User.isRegisteredModel);

  String get firstName => _firstName;

  set firstName(String value) {
    if (_firstName != value) {
      _firstName = value;
      notifyListeners();
    }
  }

  String get lastName => _lastName;

  set lastName(String value) {
    if (_lastName != value) {
      _lastName = value;
      notifyListeners();
    }
  }

  String get email => _email;

  set email(String value) {
    if (_email != value) {
      _email = value;
      notifyListeners();
    }
  }

  Role get role => _role;

  set role(Role value) {
    if (_role != value) {
      _role = value;
      notifyListeners();
    }
  }

  get fullName {
    return "$firstName $lastName";
  }

  RelationData get hospitalId => _hospitalId;

  set hospitalId(dynamic value) {
    _hospitalId.data = value;
  }

  String get phone => _phone;

  set phone(String value) {
    if (_phone != value) {
      _phone = value;
      notifyListeners();
    }
  }

  Gender get gender => _gender;

  set gender(Gender value) {
    if (_gender != value) {
      _gender = value;
      notifyListeners();
    }
  }

  DateTime? get birthDate => _birthDate;

  set birthDate(DateTime? value) {
    if (_birthDate != value) {
      _birthDate = value;
      notifyListeners();
    }
  }

  String? get bloodGroup => _bloodGroup;

  set bloodGroup(String? value) {
    if (_bloodGroup != value) {
      _bloodGroup = value;
      notifyListeners();
    }
  }

  bool? get protectedMode => _protectedMode;

  set protectedMode(bool? value) {
    if (_protectedMode != value) {
      _protectedMode = value;
      notifyListeners();
    }
  }

  @override
  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    dynamic role,
    dynamic hospitalId,
    String? phone,
    dynamic gender,
    dynamic birthDate,
    String? bloodGroup,
    bool? protectedMode,
  }) =>
      User(
        id: id ?? this.id,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        email: email ?? _email,
        role: Role.fromValue(role) ?? _role,
        hospitalId: hospitalId ?? _hospitalId,
        phone: phone ?? _phone,
        gender: Gender.fromValue(gender) ?? _gender,
        birthDate: DateTimeExtension.fromValue(birthDate) ?? _birthDate,
        bloodGroup: bloodGroup ?? _bloodGroup,
        protectedMode: protectedMode ?? _protectedMode,
      );

  /// Contructeur permettant de creer une instance de ce model a
  /// partir d'un document de type DocumentSnapshot de firebase
  factory User.fromFirebaseDocument(DocumentSnapshot document) {
    return User.fromJson(document.data()! as Map<String, dynamic>);
  }

  /// Contructeur permettant de creer une instance de ce model a
  /// partir d'un document JSON au format texte
  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  /// Contructeur permettant de creer une instance de ce model a
  /// partir d'un objet JSON (Map\<String, dynamic\>)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      role: Role.fromValue(json["role"])!,
      hospitalId: json["hospital_id"],
      phone: json["phone"],
      gender: Gender.fromValue(json["gender"])!,
      birthDate: DateTimeExtension.fromValue(json["birth_date"]),
      bloodGroup: json["blood_group"],
      protectedMode: json["protected_mode"],
    );
  }

  Future<bool> login() async {
    if (this["password"] != null) {
      try {
        FirebaseAuth.instance.currentUser?.delete();
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: this["password"]);
        return true;
      } catch (e) {
        print("Erreur: $e");
        return false;
      }
    }
    return false;
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": _firstName,
        "last_name": _lastName,
        "email": _email,
        "role": _role.toString(),
        "hospital_id": _hospitalId.id,
        "phone": _phone,
        "gender": _gender.toString(),
        "birth_date": _birthDate?.toIso8601String(),
        "blood_group": _bloodGroup,
        "protected_mode": _protectedMode,
      };
}
