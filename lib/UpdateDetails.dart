// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'UserShow.dart';

class Edit extends StatefulWidget {


  Edit(this.Name,this.Email,this.mobile,this.password, this.id ,{Key? key}) : super(key: key);

  String ? Name;
  String ? Email;
  String ? mobile;
  String ? password;
  String ? id;



  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {

  var key = GlobalKey<FormState>();


  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController num = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  String ? Id;

  @override
  void initState() {

    name.text=widget.Name!;
    password.text=widget.password!;
    mail.text=widget.Email!;
    num.text=widget.mobile!;
    Id=widget.id!;


    // TODO: implement initState
    super.initState();
  }

  Future<void>changedetails()async {
    try {
      await FirebaseFirestore.instance.collection("user").doc(Id).update({

        "Email": mail.text,
        "Name": name.text,
        "mobile": num.text,
        "password": password.text,
      });
      await user!.updateEmail(mail.text);
      await user!.updatePassword(password.text);
      print("hii");
    }on FirebaseException catch (e){
      print("Wrong${e}");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text("User Details",
      style: TextStyle(
        fontSize: 20,
      ),
      ),
    ),
      body: Form(
        key: key,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height:5,
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: GradientText(" User Update Details",
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
                      } else if (k2.length < 2) {
                        return "Enter Proper name";
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Name",

                      prefixIcon: Icon(Icons.people),
                      border: OutlineInputBorder()
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: mail,
                    validator: (page) {
                      if (page == null || page.isEmpty) {
                        return 'Please Enter your E-mail';
                      } else if (!page.contains('@gmail.com') ||
                          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(page)) {
                        return "Write valid Email ID";
                      }
                    },

                    decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.mail_outline),
                        border: OutlineInputBorder()
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: password,
                    validator: (page) {
                      if (page!.isEmpty || page == null) {
                        return "Write Something";
                      } else if (page.length < 6) {
                        return "Password Should be 6 Digit";
                      } else if (!RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                          .hasMatch(page)) {
                        return "Password should contain upper,lower,digit and Special character";
                      }
                    },

                    decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder()
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: num,
                    validator: (page) {
                      if (page!.isEmpty) {
                        return "It's Complesary";
                      } else if (page.length > 10) {
                        return "Enter Valid Number";
                      } else if (page.length < 10) {
                        return "Number should be 10 digit";
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Phone Number",
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder()
                    ),
                  ),
                ),

                ElevatedButton(
                    child: Text("Update"),
                  onPressed: (){
                      if (key.currentState!.validate()){
                        changedetails().whenComplete(() =>   ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Details update Successfully",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.red
                                ),),
                            ),
                            backgroundColor: Colors.black,

                          ),
                        ));
                      }
                      },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)
                  )
                ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
