import 'package:e_care/models/measure_information.dart';
import 'package:e_care/repositories/firebase_firestore.dart';

class MeasureInformationRepository extends FirebaseFirestoreRepository<MeasureInformation> {
  static final MeasureInformationRepository _instance = MeasureInformationRepository();

  static MeasureInformationRepository get instance => _instance;
}