import 'package:barberapp/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:barberapp/Admin/booking_admin.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernamecontroller = new TextEditingController();
  TextEditingController userpasswordcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 50, left: 20,),
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(color: Colors.orangeAccent,),
                child: Text("Admin\nPanel!", style: TextStyle(color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),),
              ),
              Container(
                padding: EdgeInsets.only(top: 35, left: 30, right: 17),
                margin: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height / 4),
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(color: Colors.white70,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Username", style: TextStyle(color: Colors.black87,
                          fontSize: 26,
                          fontWeight: FontWeight.w500),),
                      TextFormField(
                        controller: usernamecontroller,
                        decoration: InputDecoration(hintText: "Username",
                            prefixIcon: Icon(Icons.mail_outline)),
                      ),
                      SizedBox(height: 35),
                      Text("Password", style: TextStyle(color: Colors.black87,
                          fontSize: 26,
                          fontWeight: FontWeight.w500),),
                      TextFormField(
                        controller: userpasswordcontroller,
                        decoration: InputDecoration(hintText: "Password",
                          prefixIcon: Icon(Icons.password_outlined),),
                        obscureText: true,
                      ),
                      SizedBox(height: 40),
                      GestureDetector(
                        onTap: () {
                          loginAdmin();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10,),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            decoration: BoxDecoration(color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(30)),
                            child:
                            Center(child: Text("LOG IN", style: TextStyle(
                                color: Colors.black87,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),))
                        ),
                      ),
                      SizedBox(height: 45,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push((context), MaterialPageRoute(builder: (context) =>LogIn()));
                        },
        
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("User Log-In",style: TextStyle(color: Colors.black87,fontSize: 24,fontWeight: FontWeight.w500),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        
            ],
          ),
        ),
      ),
    );
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if(result.data()['id']!=usernamecontroller.text.trim()){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your id is not correct",style: TextStyle(fontSize: 20),)));
        }
        else  if(result.data()['password']!=userpasswordcontroller.text.trim()){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your password is not correct",style: TextStyle(fontSize: 20),)));
        }
        else{
          Navigator.push(context, MaterialPageRoute(builder:(context)=>BookingAdmin()));
        }
      });
    }
    );
  }
}