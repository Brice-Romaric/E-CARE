import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_care/models/user.dart';
import 'package:e_care/providers/user.dart';
import 'package:e_care/screens/admins/super_admin/management_entities/hospital_admin.dart';

import 'management_entities/hospital.dart';
import 'management_entities/medicament.dart';

class ManagementItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget Function() screen;

  const ManagementItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.screen});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              title,
              maxLines: 1,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return screen();
        }));
      },
    );
  }
}

class SuperAdminPageHome extends StatelessWidget {
  final User user;
  final Function(BuildContext)? onLogout;

  static final List<ManagementItem> managementItems = [
    ManagementItem(
      title: "Administrateurs",
      icon: Icons.supervised_user_circle,
        screen: () => HospitalAdminManagementScreen()),
    ManagementItem(
        title: "Hôpitaux",
        icon: Icons.medical_services,
        screen: () => HospitalManagementScreen()),
    ManagementItem(
        title: "Médicaments",
        icon: Icons.medication_liquid,
        screen: () => MedicamentManagementScreen()),
  ];

  const SuperAdminPageHome({super.key, required this.user, this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tableau de bord"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () =>
                (onLogout != null ? onLogout!(context) : null) ??
                Provider.of<UserProvider>(context, listen: false).logout(),
            tooltip: "Déconnexion",
          ),
        ],
      ),
      body: GridView.builder(
          padding: EdgeInsets.all(15),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15),
          itemCount: managementItems.length,
          itemBuilder: (context, index) {
            return managementItems[index];
          }),
    );
  }
}
