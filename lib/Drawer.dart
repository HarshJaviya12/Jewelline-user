import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewellineadmin/ALL_MODEL_CLASS/Adminshowmodel-class.dart';
import 'package:jewellineadmin/ALL_MODEL_CLASS/Method.dart';
import 'package:jewellineadmin/AddProduct.dart';
import 'package:jewellineadmin/User-Order-page.dart';
import 'package:jewellineadmin/homepage.dart';

import 'Addcategaries.dart';
import 'Add-Banner-Page.dart';
import 'LoginuserShow.dart';
import 'Category Show.dart';
import 'ProductShow-Page.dart';
import 'ShowBanner.dart';
import 'loginpage.dart';

class drawer extends StatelessWidget {
  Method ref = Method();
  final FirebaseAuth auth = FirebaseAuth.instance;

  drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              header(context),
              MenuItem(context),
            ],
          ),
        ),
      );

  Widget header(contex) => Container(
        height: 150,
        width: double.infinity,
        color: Colors.blue,
        child: Container(
          child: FutureBuilder<List<Adminmodelclass>>(
            future: ref.Adminshow().then((value) => value
                .where((element) =>
                    element.Email == FirebaseAuth.instance.currentUser!.email)
                .toList()),
            builder: (contex, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (contex, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: Text("Name:- ${snapshot.data![i].Name}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: Text("Email:- ${snapshot.data![i].Email}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                          ],
                        ),
                      );
                    });
              }
              return Center(
                child: CupertinoActivityIndicator(),
              );
            },
          ),
        ),
      );

  Widget MenuItem(context) => Container(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: InkWell(
                  child: Text(
                "Homepage",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              )),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (contex) => homepage()));
              },
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),
            ListTile(
              title: Text(
                "Add Category",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                    fontSize: 20),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Addcategaries()));
              },
            ),

            Divider(
              color: Colors.black,
              thickness: 1,
            ),

            ListTile(
              title: Text(
                "Add Product",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                    fontSize: 20),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AddProducts()));
              },
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),

            ListTile(
              title: Text(
                "Category Show",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                    fontSize: 20),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Showcategory()));
              },
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),

            ListTile(
              title: Text(
                "Product Show",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                    fontSize: 20),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ProductShow(

                    )));
              },
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),

            ListTile(
              title: Text(
                "User Login Data",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                    fontSize: 20),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => UserShow()));
              },
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),
            ListTile(
              title: Text(
                "User Orders",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                    fontSize: 20),
              ),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserOrder()));
              },
            ),

            Divider(
              color: Colors.black,
              thickness: 1,
            ),

            ListTile(
              title: Text(
                "Banner Show",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                    fontSize: 20),
              ),
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShowBanner()));
              },
            ),

            Divider(
              color: Colors.black,
              thickness: 1,
            ),


            ListTile(
              leading: Icon(Icons.image),
              title: Text(
                " Add Banner",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                    fontSize: 20),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AddBanner()));
              },
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.logout,shadows: [Shadow(color: Colors.red)],),
              title: Text(
                "Logout",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
              onTap: () {
                Logout() async {
                  await auth.signOut();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>loginpage(title: "Admin Login")), (route) => false);
                }

                logoutdialogbox() {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("Are you sure for this!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold)),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                            ElevatedButton(
                                onPressed: () {
                                  Logout();
                                },
                                child: Text("Logout",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                          ],
                        );
                      });
                }

                logoutdialogbox();
              },
            ),
          ],
        ),
      );
}
