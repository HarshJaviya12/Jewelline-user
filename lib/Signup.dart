import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'loginpage.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  bool isLoding = false;

  var key = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController mailsign = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  bool cell = true;
  final collection = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Sign Up Page',
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("asset/adminregister.jpg"),
              fit: BoxFit.cover,
            )
        ),


        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 116,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: GradientText("Welcome to Jewelline Admin Signup",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        gradientType: GradientType.radial,
                        radius: 6,
                        colors: const [
                          Colors.purple,
                          Colors.blue,
                          Colors.orange,
                          Colors.red,
                          Colors.pink,
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: name,
                      validator: (k2) {
                        if (k2!.isEmpty) {
                          return "Its Complesary";
                        } if(k2.contains(" ")){
                          return "Space Is Not Valid";
                        }
                        else if (k2.length < 2) {
                          return "Enter Proper name";
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.blueGrey,
                        filled: true,
                        prefixIcon: Icon(Icons.people),
                        hintText: "Enter Name",
                        labelText: "Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: mailsign,
                      validator: (page) {
                        if (page == null || page.isEmpty) {
                          return 'Please Enter your E-mail';
                        }if(page.contains(" ")){
                          return "Space Is Not Valid";
                        }
                        else if (!page.contains('@gmail.com') ||
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(page)) {
                          return "Write valid Email ID";
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.blueGrey,
                        filled: true,
                        prefixIcon: Icon(Icons.mail),
                        hintText: "Enter E-mail",
                        labelText: "E-mail",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: mobile,
                      validator: (page) {
                        if (page!.isEmpty) {
                          return "It's Complesary";
                        } else if (page.length > 10) {
                          return "Enter Valid Number";
                        } else if (page.length < 10) {
                          return "Number should be 10 digit";
                        }else if (!RegExp(r"^[6789]\d{9}$").hasMatch(page)) {
                          return 'Please enter a valid Indian mobile number';
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.blueGrey,
                        filled: true,
                        prefixIcon: Icon(Icons.mobile_friendly),
                        hintText: "Enter Mobile No.",
                        labelText: "Mobile NO",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: cell,
                      controller: password,
                      validator: (page) {
                        if (page!.isEmpty || page == null) {
                          return "Write Something";
                        }if(page.contains(" ")){
                          return "Space Is Not Valid";
                        }
                        else if (page.length < 6) {
                          return "Password Should be 6 Digit";
                        } else if (!RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                            .hasMatch(page)) {
                          return "Password should contain upper,lower,digit and Special character";
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.blueGrey,
                        filled: true,
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                cell = !cell;
                              });
                            },
                            icon: Icon(
                                cell ? Icons.visibility_off : Icons.visibility)),
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton.icon(
                          icon: Icon(Icons.account_box_rounded),
                          onPressed: () async {
                            setState(() {
                              isLoding = true;
                            });
                            Future.delayed(Duration(seconds: 4),(){
                              setState(() {
                                isLoding = false;
                              });
                            });
                            if (key.currentState!.validate()) {
                              try {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: mailsign.text,
                                        password: password.text);
                                collection
                                    .collection("Admin")
                                    .doc(FirebaseAuth
                                        .instance.currentUser?.phoneNumber)
                                    .set({
                                  "Name": name.text,
                                  "mobile": mobile.text,
                                  "Email": mailsign.text,
                                  "password": password.text
                                });

                               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>loginpage(title: 'Login Page')), (route) => false);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'Successful Login') {
                                  debugPrint("Admin successfully signup");
                                  const snackBar = SnackBar(
                                      content: Text("Admin successfully signup"));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }

                                if (e.code == 'weak-password') {
                                  debugPrint('The password provided is too weak');
                                  const snackbar = SnackBar(
                                      content: Text(
                                          'The password provided is too weak'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                } else if (e.code == 'email-already-in-use') {
                                  const snackbar = SnackBar(
                                      content: Text('email-already-in-use '));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                }
                              }
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("User Signup Successfully",
                                    style: TextStyle(fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),)));

                              print("User have created account");
                            }
                          },
                          label: isLoding?Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Signup...",
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CircularProgressIndicator(color: Colors.black,),
                            ],
                          ):Text('Sign UP')),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "If you have account ?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      TextButton.icon(
                          onPressed: () {
                           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>loginpage(title:'Admin Login')), (route) => false);
                          },
                          icon: Icon(Icons.mail,color: Colors.black,),
                          label: Text(
                            'click here',
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,
                            color: Colors.black),
                          )),
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
