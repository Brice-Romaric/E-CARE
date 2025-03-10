import 'package:flutter/material.dart';
import 'package:e_care/models/model.dart';
import 'package:e_care/models/medicament.dart';
import 'package:e_care/repositories/medicament.dart';
import 'package:e_care/screens/admins/details.dart';
import 'package:e_care/screens/admins/form.dart';
import 'package:e_care/screens/admins/management.dart';
import 'package:e_care/widgets/field.dart';

class MedicamentFormScreen extends FormScreen<Medicament> {
  MedicamentFormScreen(
      {super.key, super.item, required super.title, required super.repository, required super.isMasculine});

  @override
  Widget buildFieldsContainer(BuildContext context) {
    return Column(
      children: [

      ],
    );
  }
}

class MedicamentDetailsScreen extends DetailsScreen<Medicament> {
  const MedicamentDetailsScreen(
      {super.key, required super.title, required super.item});

  @override
  Widget buildFieldsContainer(BuildContext context) {
    return Column(children: [

    ]);
  }
}

class MedicamentManagementScreen extends ManagementScreen<Medicament> {
  MedicamentManagementScreen({super.key}) {
    title = "Médicaments";
    cardTitleFields = ["name"];
    cardSubtitleFields = ["description"];
    onSearchFields = ["name"];
    repository = MedicamentRepository.instance;
    maxItems = 50;
    leading = Icons.medication;
    image = null;
  }

  @override
  buildFormScreen(BuildContext context, String title, dynamic item, [bool isMasculine = true]) {
    return MedicamentFormScreen(title: title, repository: repository, item: item, isMasculine: isMasculine);
  }

  @override
  DetailsScreen<Model> buildDetailsScreen(
      BuildContext context, String title, item) {
    return MedicamentDetailsScreen(title: title, item: item);
  }
}
