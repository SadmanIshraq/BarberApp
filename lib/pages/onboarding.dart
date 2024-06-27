import 'package:barberapp/pages/home.dart';
import 'package:barberapp/pages/signup.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Container(
          margin:EdgeInsets.only(top: 70),
        child: Column(
          children: [
            Image.asset("images/barber.png"),
            SizedBox(height: 50,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>SignUp()
                )
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18,vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,borderRadius: BorderRadius.circular(40),
                ),
                child: Text("Get a Stylish Haircut",style: TextStyle(color: Colors.black87, fontSize:27,fontWeight:FontWeight.bold),
                ),
              ),
            ),
            ],
        ),
      ),
    );
  }
}
