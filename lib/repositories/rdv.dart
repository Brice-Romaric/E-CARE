import 'package:e_care/models/rdv.dart';
import 'package:e_care/repositories/firebase_firestore.dart';

class RDVRepository extends FirebaseFirestoreRepository<RDV> {
  static final RDVRepository _instance = RDVRepository();

  static RDVRepository get instance => _instance;
}