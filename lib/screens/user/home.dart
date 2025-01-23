import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_care/providers/user.dart';

class UserPageHome extends StatefulWidget {
  final idUser;
  final Function(BuildContext)? onLogout;

  const UserPageHome({super.key, required this.idUser, this.onLogout});

  @override
  State<UserPageHome> createState() => _UserPageHomeState();
}

class _UserPageHomeState extends State<UserPageHome> {
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
