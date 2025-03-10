import 'package:e_care/models/medical_condition.dart';
import 'package:e_care/repositories/firebase_firestore.dart';

class MedicalConditionRepository extends FirebaseFirestoreRepository<MedicalCondition> {
  static final MedicalConditionRepository _instance = MedicalConditionRepository();

  static MedicalConditionRepository get instance => _instance;
}