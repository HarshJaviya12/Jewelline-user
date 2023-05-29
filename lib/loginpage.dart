import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewellineadmin/Forgotpage.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'Signup.dart';
import 'homepage.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key, required this.title});

  final String title;

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {

  bool isLoding = false;

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
            image: AssetImage("asset/adminlogin.jpg"),
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
                  GradientText(
                    "Welcome To Jewelline Admin",
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
                      Colors.black,
                      Colors.red,
                    ],
                  ),


                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        validator: (page1) {
                          if (page1 == null || page1.isEmpty) {
                            return 'invaild Email';
                          } else if (!page1.contains('@gmail.com') ||
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(page1)) {
                            return "Write valid Email ID";
                          }
                        },
                        controller: mail,
                        decoration: const InputDecoration(
                          fillColor: Colors.green,
                          filled: true,
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
                          return "Write Something";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.green,
                        filled: true,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                security = !security;
                              });
                            },
                            icon: Icon(security
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        prefixIcon: Icon(Icons.lock),
                        hintText: "Enter Your Password",
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Forgot()));
                        },
                        child: Text("Forgot Password?",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15
                        ),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.login),
                        onPressed: () async {
                          setState(() {
                            isLoding = true;
                          });
                          Future.delayed(Duration(seconds: 5),(){
                            setState(() {
                              isLoding = false;
                            });
                          });
                          if (page1.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: mail.text, password: pwd.text).then((value) =>  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Admin Login Successfully",
                                    style: TextStyle(fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),)
                              ))
                                  );

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => homepage()));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                debugPrint('No user found for that email');
                                const snackbar = SnackBar(
                                    content: Text('No user found for that email'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                                mail.clear();
                              } else if (e.code == 'wrong-password') {
                                debugPrint('Wrong password ');
                                const snackbar =
                                    SnackBar(content: Text('Wrong password '));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                                pwd.clear();
                              }
                            }

                          }
                        },
                        label: isLoding?Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Loagin...",
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CircularProgressIndicator(color: Colors.black,),
                          ],
                        ):Text("Login"),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => signup()));
                        },
                        label: Text('click here',style: TextStyle(
                          fontWeight: FontWeight.bold,color: Colors.black
                        ),),
                        icon: Icon(Icons.mail,color: Colors.black,),
                      ),
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
