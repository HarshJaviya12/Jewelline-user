import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jewellin_user/LOGIN%20&%20SIGNUP-FILE/loginpage.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  var key = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController mailsign = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  bool security = false;
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
          'Sign Up Page',
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("asset/register.png"),
          fit: BoxFit.cover,
        )),
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
                  child: GradientText("Welcome to Jewelline Signup",
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
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: name,
                    validator: (k2) {
                      if (k2!.isEmpty) {
                        return "Its Complesary";
                      }if(k2.contains(" ")){
                        return "Space Is Not Valid";
                      }
                      else if (k2.length < 2) {
                        return "Enter Proper Name";
                      }
                    },
                    decoration: InputDecoration(
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
                    validator: (key) {
                      if (key == null || key.isEmpty) {
                        return 'Please Enter your E-mail';
                      }if(key.contains(" ")){
                        return "Space Is Not Valid";
                      }
                      else if (!key.contains('@gmail.com') ||
                          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(key)) {
                        return "Write valid Email ID";
                      }
                    },
                    decoration: InputDecoration(
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
                      } else if (page.length < 10) {
                        return "Number should be 10 digit";
                      }else if (page.length > 10) {
                        return "Enter valid Number";
                      }else if (!RegExp(r"^[6789]\d{9}$").hasMatch(page)) {
                        return 'Please enter a valid Indian mobile number';
                      }
                    },
                    decoration: InputDecoration(
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
                    obscureText: security,
                    controller: password,
                    validator: (page) {
                      if (page!.isEmpty || page == null) {
                        return "Write Something";
                      }if(page.contains(" ")){
                        return "Space Is Not Valid";
                      }
                      else if (page.length < 6) {
                        return "Password Must be more than 5 characters";
                      } else if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                          .hasMatch(page)) {
                        return "Password should contain Uppercase,Lowercase,Digit and Special Character";
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              security = !security;
                            });
                          },
                          icon: Icon(security
                              ? Icons.visibility_off
                              : Icons.visibility)),
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
                          if (key.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: mailsign.text,
                                      password: password.text);
                              collection
                                  .collection("user")
                                  .doc(FirebaseAuth
                                      .instance.currentUser?.phoneNumber)
                                  .set({
                                "Name": name.text,
                                "mobile": mobile.text,
                                "Email": mailsign.text,
                                "password": password.text,
                                "User id":FirebaseAuth.instance.currentUser?.uid
                              });

                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>loginpage(title: 'Login Page')), (route) => false);

                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'Successful Login') {
                                debugPrint("User successfully signup");
                                const snackBar = SnackBar(
                                    content: Text("User successfully signup"));
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
                        label: Text('Sign UP')),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "if you have account ?",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    TextButton.icon(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>loginpage(title: 'Jewelline')), (route) => false);
                        },
                        icon: Icon(Icons.mail),
                        label: Text(
                          'click here',
                          style: TextStyle(fontSize: 20),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
