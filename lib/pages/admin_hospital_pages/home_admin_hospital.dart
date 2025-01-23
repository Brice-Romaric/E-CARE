import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminHopitalPage extends StatefulWidget {
  const AdminHopitalPage({super.key});

  @override
  State<AdminHopitalPage> createState() => _AdminHopitalPageState();
}

class _AdminHopitalPageState extends State<AdminHopitalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page Admin Hopital"),
        backgroundColor: Colors.blueAccent,
      ),
      body:Center(
          child:Column(
              children: [
                Image.asset("assets/images/logo1.jpg"),

                SizedBox(height: 20),

                IconButton(
                  icon: Icon(Icons.logout,color: Colors.red,),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Déconnexion en cours..."))
                    );
                    Future.delayed(Duration(milliseconds: 1000), () {
                      Navigator.pop(context);
                    });
                  },
                ),
              ]
          )
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.blueAccent,
        elevation: 15,
        child: Container(height: 50.0),
      ),

    );
  }
}
