import 'package:e_care/pages/home_page.dart';
import 'package:e_care/pages/login_page.dart';
import 'package:e_care/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  // const MyApp({super.key});
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _currentIndex=0;

  setCurrentIndex(int index){
    setState(() {
      _currentIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: [
            Text("HOME"),
            Text("INSCRIPTION"),
            Text("CONNEXION"),
          ][_currentIndex],
          backgroundColor: Colors.blueAccent,
        ),

        body: [
          const HomePage(),
          const SignUpPage(),
          const LoginPage(),
        ][_currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index)=>setCurrentIndex(index),
          type: BottomNavigationBarType.fixed,
          iconSize: 32,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.brown,
          backgroundColor: Colors.blueAccent,
          elevation: 15,

          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Accueil'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.accessibility_new_sharp),
                label: 'inscription'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.accessibility_new_sharp),
                label: 'connexion'
            ),
          ],
        ),
      ),
    );
  }
}