import 'package:flutter/material.dart';
import 'package:e_care/models/model.dart';
import 'package:e_care/models/hospital.dart';
import 'package:e_care/repositories/hospital.dart';
import 'package:e_care/screens/admins/details.dart';
import 'package:e_care/screens/admins/form.dart';
import 'package:e_care/screens/admins/management.dart';
import 'package:e_care/widgets/field.dart';

class HospitalFormScreen extends FormScreen<Hospital> {
  HospitalFormScreen(
      {super.key, super.item, required super.title, required super.repository, super.isMasculine});

  @override
  Widget buildFieldsContainer(BuildContext context) {
    return Column(
      children: [
        Field<String>(
          placeholder: "Nom",
          required: true,
          initialValue: item?['name'],
          name: "name",
          onSave: onSave,
        ),
      ],
    );
  }
}

class HospitalDetailsScreen extends DetailsScreen<Hospital> {
  const HospitalDetailsScreen(
      {super.key, required super.title, required super.item});

  @override
  Widget buildFieldsContainer(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Nom : ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(item.name)
        ],
      ),
    ]);
  }
}

class HospitalManagementScreen extends ManagementScreen<Hospital> {
  HospitalManagementScreen({super.key}) {
    title = "Hôpitaux";
    cardTitleFields = ["name"];
    cardSubtitleFields = [];
    onSearchFields = Model.modelInfoOf<Hospital>()?.fields ?? [];
    repository = HospitalRepository.instance;
    maxItems = 50;
    leading = Icons.medical_services;
    image = null;
  }

  @override
  buildFormScreen(BuildContext context, String title, dynamic item, [bool isMasculine = true]) {
    return HospitalFormScreen(title: title, repository: repository, item: item, isMasculine: isMasculine);
  }

  @override
  DetailsScreen<Model> buildDetailsScreen(
      BuildContext context, String title, item) {
    return HospitalDetailsScreen(title: title, item: item);
  }
}
