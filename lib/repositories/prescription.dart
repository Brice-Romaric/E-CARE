import 'package:e_care/models/prescription.dart';
import 'package:e_care/repositories/firebase_firestore.dart';

class PrescriptionRepository extends FirebaseFirestoreRepository<Prescription> {
  static final PrescriptionRepository _instance = PrescriptionRepository();

  static PrescriptionRepository get instance => _instance;
}