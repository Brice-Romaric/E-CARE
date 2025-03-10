import 'package:e_care/models/medical_condition_information.dart';
import 'package:e_care/repositories/firebase_firestore.dart';

class MedicalConditionInformationRepository extends FirebaseFirestoreRepository<MedicalConditionInformation> {
  static final MedicalConditionInformationRepository _instance = MedicalConditionInformationRepository();

  static MedicalConditionInformationRepository get instance => _instance;
}