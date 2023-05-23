import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jewellin_user/All-MODEL-CLASS/MethodClass.dart';

import 'UpdateDetails.dart';
import 'LOGIN & SIGNUP-FILE/loginpage.dart';
import 'All-MODEL-CLASS/Usermodelclass.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

Method abc = Method();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login User Details")
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height:685,


              child: FutureBuilder<List<usermodelclass>>(
                  future: abc.show().then((value) => value.where((element) => element.Uid ==FirebaseAuth.instance.currentUser?.uid).toList()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, i) {
                            return ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(color: Colors.black,width: 2),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        " Name:  ${snapshot.data![i].Name.toString()}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          border: Border.all(color: Colors.black,width: 2),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(" Email:  ${snapshot.data![i].Email.toString()}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          border: Border.all(color: Colors.black,width: 2),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(" Password:  ${snapshot.data![i].password.toString()}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          border: Border.all(color: Colors.black,width: 2),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(" Number:  ${snapshot.data![i].mobile.toString()}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),


                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton.icon(
                                        label: Text("Update Details"),
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Edit(
                                            snapshot.data![i].Name.toString(),
                                            snapshot.data![i].Email.toString(),
                                            snapshot.data![i].mobile.toString(),
                                            snapshot.data![i].password.toString(),
                                            snapshot.data![i].id.toString(),


                                          )));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            primary: Colors.blue,
                                            foregroundColor: Colors.white
                                        ), icon: Icon(Icons.update),
                                      ),
                                    ),

                                  ],

                                ),
                              );
                          });
                    }else{
                      return
                        Center(
                          child:  CircularProgressIndicator(),
                        );

                    }


                  }),
            ),

            // Container(
            //   height: MediaQuery.of(context).size.width,
            // ),



          ],
        ),
      ),
    );
  }
}
