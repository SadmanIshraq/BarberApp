import 'package:barberapp/Admin/admin_login.dart';
import 'package:barberapp/pages/home.dart';
import 'package:barberapp/pages/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String? mail, password;
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();
  userLogin()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: mail!, password:password!);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
    }
    on FirebaseAuthException catch(e){
      if(e.code=='user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
            "No User Found for That Email",
            style: TextStyle(fontSize: 18, color: Colors.black))));
      }
      else if(e.code=='wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
            "Wrong Password Provided",
            style: TextStyle(fontSize: 18, color: Colors.black))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 50,left: 20,),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                  decoration:BoxDecoration (color: Colors.orangeAccent,),
                child: Text("Hello\nSign In!", style:TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
              ),
              Container(
                padding: EdgeInsets.only(top: 35,left: 30,right: 17),
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration:BoxDecoration (color: Colors.white70,borderRadius: BorderRadius.only(topLeft:Radius.circular(40),topRight: Radius.circular(40))),
                child:Form(
                  key:_formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Gmail", style:TextStyle(color: Colors.black87,fontSize: 26,fontWeight: FontWeight.w500),),
                    TextFormField(
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Please Enter E-mail';
                        }
                        return null;
                      },
                      controller: emailcontroller,
                      decoration: InputDecoration(hintText: "Gmail",prefixIcon: Icon(Icons.mail_outline)),
                    ),
                      SizedBox(height: 35),
                      Text("Password", style:TextStyle(color: Colors.black87,fontSize: 26,fontWeight: FontWeight.w500),),
                      TextFormField(
                        validator: (value){
                          if(value==null || value.isEmpty){
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                        controller: passwordcontroller,
                        decoration: InputDecoration(hintText: "Password",prefixIcon: Icon(Icons.password_outlined),),obscureText: true,
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Forgot Password", style:TextStyle(color: Colors.black87,fontSize: 17,fontWeight: FontWeight.w500),),
                        ],
                      ),
                      SizedBox(height: 30,),
                      GestureDetector(
                        onTap: (){
                          if(_formkey.currentState!.validate()) {
                            setState(() {
                              mail = emailcontroller.text;
                              password = passwordcontroller.text;
                            });
                          }
                          userLogin();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10,),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration (color: Colors.orangeAccent,borderRadius: BorderRadius.circular(30)),
                        
                            child:
                        Center(child: Text("SIGN IN",style: TextStyle(color: Colors.black87,fontSize: 26,fontWeight: FontWeight.bold),))
                        ),
                      ),
                      SizedBox(height: 35,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Don't have account",style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w500),),
                      ],
                    ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push((context), MaterialPageRoute(builder: (context) =>SignUp()));
                        },
        
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Sign Up",style: TextStyle(color: Colors.black87,fontSize: 24,fontWeight: FontWeight.w500),),
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push((context), MaterialPageRoute(builder: (context) =>AdminLogin()));
                        },
        
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Admin Login",style: TextStyle(color: Colors.black87,fontSize: 24,fontWeight: FontWeight.w500),),
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
}
