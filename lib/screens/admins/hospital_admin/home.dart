import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_care/models/user.dart';
import 'package:e_care/providers/user.dart';

import 'package:e_care/screens/admins/hospital_admin/management_entities/doctor.dart';

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

class HospitalAdminPageHome extends StatelessWidget {
  final User user;
  final Function(BuildContext)? onLogout;

  static final List<ManagementItem> managementItems = [
    ManagementItem(
      title: "Médecins",
      icon: Icons.supervised_user_circle,
        screen: () => DoctorManagementScreen()),
  ];

  const HospitalAdminPageHome({super.key, required this.user, this.onLogout});

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
