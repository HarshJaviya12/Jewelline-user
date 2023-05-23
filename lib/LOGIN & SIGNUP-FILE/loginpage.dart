import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';


import '../Forgot.dart';
import 'Signup.dart';
import '../bottamnavigate.dart';
import '../homepage.dart';

class loginpage extends StatefulWidget {
  const loginpage({super .key, required this.title});

  final String title;

  @override
  State<loginpage> createState() => _loginpageState();
}


class _loginpageState extends State<loginpage> {
  var page1 = GlobalKey<FormState>();
  TextEditingController mail = TextEditingController();
  TextEditingController pwd = TextEditingController();
  bool security = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(


        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(widget.title),
        ),

      ),

      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("asset/userlogin.png"),
              fit: BoxFit.cover,
            )
        ),
        child: Center(


          child: Form(

            key: page1,
            child: SingleChildScrollView(
              child: Column(


                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: GradientText("Welcome To Jewelline Login",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      gradientType: GradientType.radial,
                      radius: 6,
                      colors: const [
                        Colors.orange,
                        Colors.blue,
                        Colors.orange,

                      ],


                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: TextFormField(
                        validator: (page1) {
                          if (page1 == null || page1.isEmpty ||
                              !page1.contains('@gmail.com')) {
                            return 'invaild Email';
                          } else {
                            return null;
                          }
                        },
                        controller: mail,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                          hintText: "Enter Your E-mail",
                          labelText: "Email",
                          border: OutlineInputBorder(),

                        ),


                      ),

                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: security,
                      controller: pwd,
                      validator: (page1) {
                        if (page1!.isEmpty || page1 == null) {
                          return 'Write Something';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(onPressed: () {
                          setState(() {
                            security = !security;
                          });
                        },
                            icon: Icon(security ? Icons.visibility_off : Icons
                                .visibility)),
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Enter Your Password",
                        labelText: "Password",
                        border: OutlineInputBorder(),


                      ),
                    ),
                  ),


                  Container(
                    alignment: Alignment.topRight,
                    child: TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Forgot()));
                    },
                        child: Text("Forgot Password?")),


                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.login),
                        onPressed: () async {
                          if (page1.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                  email: mail.text, password: pwd.text);


                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) =>
                                      Bottamnavigate(selectedindex: 0,)));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                debugPrint(
                                    'No user found for that email');
                                const snackbar = SnackBar(
                                    content: Text(
                                        'No user found for that email'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                                mail.clear();
                              } else if (e.code == 'wrong-password') {
                                debugPrint('Wrong password ');
                                const snackbar = SnackBar(
                                    content: Text('Wrong password '));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                                pwd.clear();
                              }
                            }
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("User Login Successfully",
                                  style: TextStyle(fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),)));
                          }
                        },
                        label: Text("Login")
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                        style: const TextStyle(
                          fontSize: 15,
                        ),

                      ),
                      TextButton.icon(onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => signup()));
                      }, label: Text('click here'), icon: Icon(Icons.mail),),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}




