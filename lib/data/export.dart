import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

import '../firebase_options.dart';

Future<void> exportMedicament() async {
  // Lire le fichier CSV en local
  final file = await rootBundle
      .loadString('assets/data/ref-des-medicaments-cnops-2014.csv');
  List<List<dynamic>> fields =
      const CsvToListConverter(fieldDelimiter: ";").convert(file);

  if (fields.isEmpty) {
    print("❌ Le fichier est vide !");
    return;
  }

  // Récupérer les en-têtes
  List<List<dynamic>> rows = fields.skip(1).toList();

  // Référence Firestore
  final CollectionReference medicaments =
      FirebaseFirestore.instance.collection('medicament');

  // Envoi en batch
  WriteBatch batch = FirebaseFirestore.instance.batch();
  int count = 0;
  for (int i = 0; i < rows.length; ++i) {
    getValue(List<dynamic> row, int i,
        [bool isDouble = false, bool isFrenchFormat = false]) {
      String temp = row[i].toString().trim();
      if (temp.isEmpty || temp == "-") return null;
      if (isDouble) {
        if (isFrenchFormat) {
          temp = temp.replaceAll(".", "").replaceAll(",", ".");
        }
        temp = temp.replaceAll(RegExp(r"[^\d.e]", caseSensitive: false), "");
        return double.tryParse(temp);
      }
      return temp;
    }

    getData(List<dynamic> row) {
      Map<String, dynamic> data = {};
      data["codes"] = [getValue(row, 0)];
      data["name"] = getValue(row, 1);
      data["active_ingredient"] = getValue(row, 2);
      data["dosage"] = getValue(row, 3);
      data["dosage_unit"] = getValue(row, 4);
      data["form"] = getValue(row, 5);
      data["description"] = getValue(row, 6);
      data["retail_price"] = getValue(row, 7, true, true);
      data["hospital_price"] = getValue(row, 8, true, true);
      data["base_reimbursement_price"] = getValue(row, 9, true, true);
      data["brand_or_generic"] = getValue(row, 10);
      data["reimbursement_rate"] = getValue(row, 11, true, true);
      return data;
    }

    var currentRow = rows[i];
    var currentMedicament = getData(currentRow);

    while (i + 1 < rows.length &&
        getValue(rows[i + 1], 1) == currentMedicament["name"]) {
      currentMedicament["codes"].add(getValue(rows[i + 1], 0));
      ++i;
    }

    DocumentReference docRef = medicaments.doc();
    batch.set(docRef, currentMedicament);

    if (++count % 500 == 0) {
      // Firestore limite 500 opérations par batch
      await batch.commit();
      batch = FirebaseFirestore.instance.batch();
    }
  }

  // Envoi du dernier batch
  await batch.commit();

  print("✅ Importation terminée : $count médicaments ajoutés !");
}

Future<void> main() async {
  // Initialisation Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await exportMedicament();
}
