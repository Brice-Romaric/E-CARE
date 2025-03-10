import 'package:e_care/models/authorisation.dart';
import 'package:e_care/repositories/firebase_firestore.dart';

class AuthorisationRepository extends FirebaseFirestoreRepository<Authorisation> {
  static final AuthorisationRepository _instance = AuthorisationRepository();

  static AuthorisationRepository get instance => _instance;
}