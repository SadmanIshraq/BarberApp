import 'package:barberapp/pages/home.dart';
import 'package:barberapp/pages/login.dart';
import 'package:barberapp/services/database.dart';
import 'package:barberapp/services/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String? name, mail, password;
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null && name != null && mail != null) {
      try{
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: mail!, password: password!);
        String id= randomAlphaNumeric(10);
        await SharedpreferenceHelper().saveUserName(namecontroller.text);
        await SharedpreferenceHelper().saveUserEmail(emailcontroller.text);
        await SharedpreferenceHelper().saveUserImage("https://icon2.cleanpng.com/20180401/goe/kisspng-user-profile-computer-icons-profile-5ac09244d91906.2547020615225697968892.jpg");
        await SharedpreferenceHelper().saveUserId(id);
        Map<String, dynamic> userInfoMap={
          "Name":namecontroller.text,
          "Email":emailcontroller.text,
          "Id": id,
          "Image":"https://icon2.cleanpng.com/20180401/goe/kisspng-user-profile-computer-icons-profile-5ac09244d91906.2547020615225697968892.jpg" ,
        };
        await DatabaseMethods().addUserDetails(userInfoMap, id);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registered Successfully",style: TextStyle(fontSize: 20),)));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
      }
      on FirebaseAuthException catch(e){
        if(e.code=='weak-password'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password Provided is too weak",style: TextStyle(fontSize: 20),)));
        }
        else if(e.code=="email-already-in-use"){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Account Already Exists",style: TextStyle(fontSize: 20),)));
        }
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
                child: Text("Create Your\nAccount!", style:TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
              ),
              Container(
                padding: EdgeInsets.only(top: 35,left: 30,right: 17),
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration:BoxDecoration (color: Colors.white70,borderRadius: BorderRadius.only(topLeft:Radius.circular(40),topRight: Radius.circular(40))),
                child:Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name", style:TextStyle(color: Colors.black87,fontSize: 26,fontWeight: FontWeight.w500),),
                      TextFormField(
                        validator: (value){
                          if(value==null || value.isEmpty){
                            return 'Please Enter Name';
                          }
                          return null;
                        },
                        controller: namecontroller,
                        decoration: InputDecoration(hintText: "Name",prefixIcon: Icon(Icons.person_outline)),
                      ),
                      SizedBox(height: 35),
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
                      SizedBox(height: 40),
                        GestureDetector(
                          onTap: (){
                            if(_formkey.currentState!.validate()){
                              setState(() {
                                mail=emailcontroller.text;
                                name=namecontroller.text;
                                password=passwordcontroller.text;
                              });
                            }
        
                           registration();
        
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10,),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration (color: Colors.orangeAccent,borderRadius: BorderRadius.circular(30)),
                            child:
                            Center(child: Text("SIGN UP",style: TextStyle(color: Colors.black87,fontSize: 26,fontWeight: FontWeight.bold),))
                                              ),
                        ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Already have an account?",style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w500),),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIn()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Sign In",style: TextStyle(color: Colors.black87,fontSize: 24,fontWeight: FontWeight.w500),),
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
