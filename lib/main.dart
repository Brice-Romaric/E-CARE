import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_care/models/model.dart';
import 'package:e_care/providers/user.dart';
import 'package:e_care/screens/account/login.dart';
import 'package:e_care/screens/account/signup.dart';
import 'package:e_care/screens/super_admin/home.dart';
import 'package:e_care/screens/user/home.dart';

import 'firebase_options.dart';

Future<void> main() async {
  loadModels();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()..loadUser()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.lightBlueAccent,
          secondary: Colors.greenAccent,
          surface: Colors.white,
          error: Colors.redAccent,
        ),
        fontFamily: 'Roboto',

        // Texte
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
          displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
          displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.greenAccent),
          headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.greenAccent),
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.greenAccent),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
          titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black45),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[700]),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey[600]),
          bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey[500]),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
        ),

        // Boutons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
            foregroundColor: Colors.white,
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),

        // AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightBlueAccent,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent, width: 2),
          ),
          labelStyle: TextStyle(color: Colors.lightBlueAccent),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Colors.greenAccent,
          labelTextStyle: WidgetStateProperty.all(
            TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
          ),
        ),
      ),
      home: MonScaffold(),
    );
  }
}

class MonScaffold extends StatefulWidget {
  const MonScaffold({super.key});

  @override
  State<MonScaffold> createState() => _MonScaffoldState();
}

class _MonScaffoldState extends State<MonScaffold> {
  var _number = 0;

  setNumber(int number) {
    setState(() {
      _number = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.currentUser;

    if (currentUser == null && FirebaseAuth.instance.currentUser != null) {
      return Scaffold(
          appBar: AppBar(
            title: Text("StreamIt"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Un instant...'),
                ),
              ],
            ),
          ));
    } else if (currentUser != null) {
      if (currentUser.role == "super_admin") {
        return SuperAdminPageHome(user: currentUser);
      } else {
        return UserPageHome(idUser: currentUser.id);
      }
    } else {
      return Scaffold(
        appBar: AppBar(
          title: [
            Text("Connexion"),
            Text("Inscription"),
          ][_number],
        ),
        body: [
          Login(),
          Signup(),
        ][_number],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _number,
            iconSize: 32,
            onTap: (index) {
              setNumber(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.accessibility_new_sharp),
                  label: 'Connexion'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.accessibility_new_sharp),
                  label: 'Inscription'),
            ]),
      );
    }
  }
}