import 'package:e_care/models/medicament.dart';
import 'package:e_care/repositories/firebase_firestore.dart';

class MedicamentRepository extends FirebaseFirestoreRepository<Medicament> {
  static final MedicamentRepository _instance = MedicamentRepository();

  static MedicamentRepository get instance => _instance;
}