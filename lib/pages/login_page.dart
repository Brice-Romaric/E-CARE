import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:validators/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formkey=GlobalKey<FormState>();

  final mailController=TextEditingController();
  final mdpController=TextEditingController();
  final phonenumberController=TextEditingController();

  @override
  void dispose() {
    super.dispose();
    mailController.dispose();
    mdpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50, right:20,bottom:20,left: 20),
      child: Form(
          key: _formkey,
          child: Column(
            children:[
              TextFormField(
                decoration:const InputDecoration(
                  labelText:"Mail",
                  hintText:"entrez votre adresse mail",
                  border:OutlineInputBorder(),
                ),
                validator: (value) {
                  if (mailController.text.isEmpty && phonenumberController.text.isEmpty) {
                    return "Veuillez saisir l'un des champs (Mail ou Numero)";
                  }
                  else if (phonenumberController.text.isEmpty) {
                       if(!isEmail(value!)){
                         return "Ce n'est pas un mail";
                       }
                  }
                },
                controller: mailController,
              ),

                 const SizedBox(height: 5),
              Text("ou"),
              TextFormField (
                decoration: const InputDecoration(
                  labelText: "Numéro de téléphone",
                  hintText: "+212 06xxxxxx78",
                  border: OutlineInputBorder(),

                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (mailController.text.isEmpty && phonenumberController.text.isEmpty) {
                    return "Veuillez saisir l'un des champs (Mail ou Numero)";
                  }
                },
                controller: phonenumberController,
              ),

              const SizedBox(height:30),

              TextFormField(
                decoration:const InputDecoration(
                  labelText:'Mot De Passe',
                  hintText:'entrez votre Mot de passe',
                  border: OutlineInputBorder(),
                ),
                validator:(value){
                  if (value == null || value.isEmpty){
                    return "Mot de passe vide";
                  }
                  if (value.length < 6) {
                    return "le mot de passe doit comporter plus de 6 caractères";
                  }
                  return null;
                },
                controller: mdpController,
                obscureText: true,
              ),

              const SizedBox(height:40),

              SizedBox(
                width: double.infinity,
                height:50,
                child:ElevatedButton(
                  style:const ButtonStyle(
                    backgroundColor:MaterialStatePropertyAll(Colors.blueAccent),
                  ) ,
                  onPressed: () async
                  {
                    if (_formkey.currentState!.validate()){
                      final mail=mailController.text;
                      final mdp=mdpController.text;
                      try{
                        final  userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(email:mail,password:mdp);
                        if (userCredential.user != null){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("connexion en cours..."))
                          );
                          FocusScope.of(context).requestFocus(FocusNode());

                          CollectionReference userRef = FirebaseFirestore.instance.collection("utilisateurs");
                          DocumentSnapshot doc=  await userRef.doc(userCredential.user!.uid).get();
                          String role = doc.get('role');

                          Future.delayed(Duration(milliseconds: 2000), () {

                            switch(role) {
                              case 'super_admin':
                              /*  Navigator.push(context,
                                    MaterialPageRoute(builder: (context)
                                    {return AdminHomePage();} )
                                ); */
                                break;

                              case 'admin_hospital':

                                break;

                              case 'doctor':

                                break;

                              case 'patient':

                                break;
                            }
                          });
                        }
                      }on FirebaseAuthException catch(e){
                        if (e.code == 'user-not-found' || e.code == 'wrong-password' ) {

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("mauvais utilisateur ou mauvais mot de passe"))
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("erreur dans l'authentification"))
                          );
                        }
                      }

                    }
                  },
                  child: const Text("Se connecter avec mail",
                      style: TextStyle(fontSize: 20,color: Colors.black)
                  ),
                ),
              ),
              const SizedBox(height:20),

              SizedBox(
                width: double.infinity,
                height:50,
                child:ElevatedButton(
                  style:const ButtonStyle(
                    backgroundColor:MaterialStatePropertyAll(Colors.blueAccent),
                  ) ,
                  onPressed: () async
                  {
                      if (_formkey.currentState!.validate()){
                        final mail=mailController.text;
                        final phonenumber=phonenumberController.text;
                    }
                  },
                  child: const Text("Se connecter avec tel",
                    style: TextStyle(fontSize: 20,color: Colors.black),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
