import 'package:e_care/models/measure.dart';
import 'package:e_care/repositories/firebase_firestore.dart';

class MeasureRepository extends FirebaseFirestoreRepository<Measure> {
  static final MeasureRepository _instance = MeasureRepository();

  static MeasureRepository get instance => _instance;
}