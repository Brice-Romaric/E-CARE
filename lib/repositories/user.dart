import 'package:e_care/models/user.dart';
import 'package:e_care/repositories/firebase_firestore.dart';

class UserRepository extends FirebaseFirestoreRepository<User> {
  static final UserRepository _instance = UserRepository();

  static UserRepository get instance => _instance;
}