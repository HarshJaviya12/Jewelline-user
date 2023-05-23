import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'LOGIN & SIGNUP-FILE/loginpage.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {

  TextEditingController Email = TextEditingController();
  var F1 = GlobalKey<FormState>();
  var email="";



  @override

  Resetpassword()async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Password Reset Email has been sent",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold
              ),
            ),

          )
      );

    }on FirebaseAuthException catch (e) {
      if(e.code == 'use not found'){
        print("no user found for this email");
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'No user found for this email',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
            ));
      }
    }

  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: F1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Container(
                height: 60,

              ),
              Text("OTP will be sent on Email so Write your emailid !",
                style: TextStyle(fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),

              Container(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextFormField(
                    controller: Email,
                    validator: (F1){
                      if (F1!.isEmpty){
                        return "Write something";
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email",
                      hintText: "Enter your Email ",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              ElevatedButton(onPressed: (){
                if(F1.currentState!.validate()){
                  setState(() {
                    email = Email.text;
                  });
                  Resetpassword();
                }
              }, child: Text("Send OTP")),


              Container(
                height: 10,
              ),
              Text("Now Click Here to go Login",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
              TextButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>loginpage(title: 'Login',)));
              }, child: Text("Login")),

            ],

          ),
        ),
      ),
    );
  }
}

