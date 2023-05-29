import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewellineadmin/Drawer.dart';
import 'package:jewellineadmin/Add-Banner-Page.dart';
import 'package:jewellineadmin/Addcategaries.dart';
import 'package:jewellineadmin/AddProduct.dart';
import 'package:jewellineadmin/ProductShow-Page.dart';
import 'package:jewellineadmin/User-Order-page.dart';
import 'package:jewellineadmin/loginpage.dart';
import 'package:jewellineadmin/LoginuserShow.dart';
import 'package:jewellineadmin/Category Show.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'Example.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  final FirebaseAuth auth = FirebaseAuth.instance;


  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit the app?'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: Text('No',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: Text('Yes',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: GradientText(
              "HomePage",
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

        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                height: 50,
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width:double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black,width: 2),
                    color: Colors.green

                  ),
                  child: ElevatedButton(
                    child: Text("Add Category",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Addcategaries()));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        primary: Colors.green,
                        foregroundColor: Colors.black),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black,width: 2),
                      color: Colors.green
                  ),
                  child: ElevatedButton(
                    child: Text("Add Products",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddProducts()));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        primary: Colors.green,
                        foregroundColor: Colors.black),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black,width: 2),
                    color: Colors.green,
                  ),
                  child: ElevatedButton(
                      child: Text("Product Show",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ProductShow()));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          primary: Colors.green,
                          foregroundColor: Colors.black)
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black,width: 2),
                    color: Colors.green,
                  ),
                  child: ElevatedButton(
                      child: Text("Category Show",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Showcategory()));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          primary: Colors.green,
                          foregroundColor: Colors.black)
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black,width: 2),
                    color: Colors.green
                  ),
                  child: ElevatedButton(
                    child: Text("User login data",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),),
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => UserShow()));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        primary: Colors.green,
                        foregroundColor: Colors.black),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black,width: 2),
                      color: Colors.green
                  ),
                  child: ElevatedButton(
                    child: Text("Add Banner",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),),
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => AddBanner()));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        primary: Colors.green,
                        foregroundColor: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black,width: 2),
                      color: Colors.green
                  ),
                  child: ElevatedButton(
                    child: Text("User Order",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),),
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => UserOrder()));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        primary: Colors.green,
                        foregroundColor: Colors.black),
                  ),
                ),
              ),



            ],
          ),
        ),
        drawer: drawer(),
      ),
    );
  }
}
