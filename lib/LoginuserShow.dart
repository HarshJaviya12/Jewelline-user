import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jewellineadmin/ALL_MODEL_CLASS/Method.dart';
import 'package:jewellineadmin/Drawer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'ALL_MODEL_CLASS/AllLoginUserModel-class.dart';
// import 'package:jewellineadmin/modelclass.dart';

// import 'UserShowclass.dart';

class UserShow extends StatefulWidget {
  const UserShow({Key? key}) : super(key: key);

  @override
  State<UserShow> createState() => UserShowState();
}

class UserShowState extends State<UserShow> {

  final Random random = Random();
  Method abc = Method();


  final Usercollection = FirebaseFirestore.instance.collection("user");


  Future<void> DeleteUser(String email, String password, String id) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    await Usercollection.doc(id).delete().whenComplete(() =>
        userCredential.user?.delete());

    print("User Delete succesfully");
  }

  Deletedialodbox(
      {required String Email, required String password, required String Id}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("do you want delete"),
            actions: [
              ElevatedButton(onPressed: () {
                DeleteUser(Email, password,Id).whenComplete(() => Navigator.pop(context)).whenComplete(() => ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Product Add Successfully",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 20),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(25)),
                )));
              }, child: Text("Yes")),
              ElevatedButton(
                  onPressed: () {

                    Navigator.pop(context);

                  },
                  child: Text("Cancel")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: GradientText(
            "User Login Page",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            colors: [
              Colors.black,
              Colors.red,
              Colors.purple,
              Colors.pinkAccent,

            ],
          ),
        ),
      ),
      drawer: drawer(),
      // backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: FutureBuilder<List<allusermodelclass>>(
              future: abc.showalluser(),
              builder: (context, snapshot) {
                print("hi${snapshot.hasData}");
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        final color = Color.fromARGB(255,
                          random.nextInt(256),
                          random.nextInt(256),
                          random.nextInt(256),

                        );
                        return InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // color: color,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                    color: Colors.black, width: 2),
                              ),
                              child: ListTile(
                                title: Text(
                                  "User name:-${snapshot.data![i].Name
                                      .toString()}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.lightBlue),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Mail:-${snapshot.data![i].Mail
                                          .toString()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      "Phone no:-${snapshot.data![i].phonenumber
                                          .toString()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      "Password:-${snapshot.data![i].password
                                          .toString()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    // Text(
                                    //   "User-id:-${snapshot.data![i].Userid.toString()}",
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 20),
                                    // ),
                                  ],
                                ),
                                trailing: Container(
                                    child: IconButton(onPressed: () {
                                      setState(() {
                                        Deletedialodbox(
                                          Email: snapshot.data![i].Mail
                                              .toString(),
                                          password: snapshot.data![i].password
                                              .toString(),
                                          Id: snapshot.data![i].id.toString(),
                                        );
                                      });


                                    },
                                        icon: Icon(
                                          Icons.delete, color: Colors.black,))
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
        // child: Text("User:-${user}"),
      ),

    );
  }
}
