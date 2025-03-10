import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_care/providers/user.dart';

class DoctorPageHome extends StatefulWidget {
  final idUser;
  final Function(BuildContext)? onLogout;

  const DoctorPageHome({super.key, required this.idUser, this.onLogout});

  @override
  State<DoctorPageHome> createState() => _DoctorPageHomeState();
}

class _DoctorPageHomeState extends State<DoctorPageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Care"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () =>
            (widget.onLogout != null ? widget.onLogout!(context) : null) ??
                Provider.of<UserProvider>(context, listen: false).logout(),
            tooltip: "Déconnexion",
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Exemple de texte
            Text(
              "Bienvenue dans E-Care",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20),
            Text(
              "Simplifiez votre santé, un clic à la fois.",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 30),
            // Bouton d'exemple
            ElevatedButton(
              onPressed: () {
                // Action à réaliser
              },
              child: Text("Commencer"),
            ),
          ],
        ),
      ),
    );
  }
}
