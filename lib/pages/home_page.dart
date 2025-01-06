import 'package:flutter/material.dart';

//page d'accueil
class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Center(
      child:Column(
        children: [
          Image.asset("assets/images/logo1.jpg"),
          SizedBox(height: 60),
          ElevatedButton(
              style:const ButtonStyle(
                backgroundColor:MaterialStatePropertyAll(Colors.blueAccent),
                padding:(MaterialStatePropertyAll(EdgeInsets.all(20))),

              ) ,
              onPressed: () {

              },
              child: const Text("voir",
                  style: TextStyle(fontSize: 30)
              )
          )
        ],
      ),
    );
  }
}
