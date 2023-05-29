import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'ALL_MODEL_CLASS/Adminshowmodel-class.dart';
import 'loginpage.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {





  final z = FirebaseFirestore.instance.collection("Admin");


  Future<List<Adminmodelclass>> show() async {
    QuerySnapshot Details = await z.get();
    return Details.docs.map((e) => Adminmodelclass.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Admin"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height:685,


              child: FutureBuilder<List<Adminmodelclass>>(
                  future: show().then((value) => value.where((element) => element.Email ==FirebaseAuth.instance.currentUser?.email).toList()),
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
                                        child: Text(" Password:  ${snapshot.data![i].Password.toString()}",
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
                                        child: Text(" Number:  ${snapshot.data![i].Number.toString()}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
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






            ],
        ),
      ),
    );
  }
}
