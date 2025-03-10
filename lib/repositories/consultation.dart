import 'package:e_care/models/consultation.dart';
import 'package:e_care/repositories/firebase_firestore.dart';

class ConsultationRepository extends FirebaseFirestoreRepository<Consultation> {
  static final ConsultationRepository _instance = ConsultationRepository();

  static ConsultationRepository get instance => _instance;
}