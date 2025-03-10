import 'package:e_care/models/hospital.dart';
import 'package:e_care/repositories/firebase_firestore.dart';

class HospitalRepository extends FirebaseFirestoreRepository<Hospital> {
  static final HospitalRepository _instance = HospitalRepository();

  static HospitalRepository get instance => _instance;
}