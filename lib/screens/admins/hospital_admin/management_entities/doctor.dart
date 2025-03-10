import 'package:flutter/material.dart';
import 'package:e_care/models/model.dart';
import 'package:e_care/models/user.dart';
import 'package:e_care/repositories/user.dart';
import 'package:e_care/screens/admins/details.dart';
import 'package:e_care/screens/admins/form.dart';
import 'package:e_care/screens/admins/management.dart';
import 'package:e_care/widgets/field.dart';

class DoctorFormScreen extends FormScreen<User> {
  DoctorFormScreen(
      {super.key,
      super.item,
      required super.title,
      required super.repository,
      super.isMasculine,
      super.authenticationIdentifier});

  @override
  Widget buildFieldsContainer(BuildContext context) {
    return Column(
      children: [
        Field<String>(
          placeholder: "Nom",
          required: true,
          initialValue: item?['last_name'],
          name: "last_name",
          onSave: onSave,
        ),
        Field<String>(
          placeholder: "Prénom",
          required: true,
          initialValue: item?['first_name'],
          name: "first_name",
          onSave: onSave,
        ),
        Field<String>(
          placeholder: "Téléphone",
          required: true,
          initialValue: item?['phone'],
          name: "phone",
          onSave: onSave,
        ),
        Field<String>(
          placeholder: "Email",
          type: "email",
          required: true,
          initialValue: item?['email'],
          name: "email",
          onSave: onSave,
        ),
        if (item == null)
          Field<String>(
            placeholder: "Mot de passe",
            required: true,
            type: "password",
            name: "%password%",
            // "%%" champs non destine a l'entite
            onSave: onSave,
          ),
        Field<Gender>(
          type: "select",
          placeholder: "Genre",
          required: true,
          initialValue: item?['gender'],
          name: "gender",
          selectOptions: Gender.values,
          onSave: onSave,
        ),
        Field<Role>(
          type: "select",
          hidden: true,
          placeholder: "Rôle",
          required: true,
          initialValue: Role.doctor,
          name: "role",
          selectOptions: Role.values,
          onSave: onSave,
        ),
      ],
    );
  }
}

class DoctorDetailsScreen extends DetailsScreen<User> {
  const DoctorDetailsScreen(
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
          Text(item.lastName)
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Prénom : ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(item.firstName)
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Email : ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(item.email)
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Téléphone : ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(item.phone)
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Genre : ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(item.gender.toString())
        ],
      ),
    ]);
  }
}

class DoctorManagementScreen extends ManagementScreen<User> {
  DoctorManagementScreen({super.key}) {
    title = "Médecins";
    subtitle = "Médecin";
    cardTitleFields = ["first_name", "last_name"];
    cardSubtitleFields = ["email"];
    onSearchFields = Model.modelInfoOf<User>()?.fields ?? [];
    repository = UserRepository.instance;
    maxItems = 50;
    leading = Icons.medical_information;
    image = null;
    customFilter = {"role": "doctor"};
    authenticationIdentifier = "email";
  }

  @override
  buildFormScreen(BuildContext context, String title, dynamic item) {
    return DoctorFormScreen(
      title: title,
      repository: repository,
      item: item,
      isMasculine: isMasculine,
      authenticationIdentifier: authenticationIdentifier,
    );
  }

  @override
  DetailsScreen<Model> buildDetailsScreen(
      BuildContext context, String title, item) {
    return DoctorDetailsScreen(title: title, item: item);
  }
}
