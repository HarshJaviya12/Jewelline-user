import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jewellin_user/MyOrders-Page.dart';

// import 'package:jewellin_user/My-Orders-Page.dart';
import 'package:jewellin_user/UserShow.dart';

import 'All-MODEL-CLASS/Product_Class.dart';
import 'OrderTrackPage.dart';
import 'PaymentPage.dart';
import 'bottamnavigate.dart';
import 'LOGIN & SIGNUP-FILE/loginpage.dart';

class Account extends StatefulWidget {
  Account({
    Key? key,
    this.product,
  }) : super(key: key);

  productclass? product;

  @override
  State<Account> createState() => AccountState();
}

class AccountState extends State<Account> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  LogoutDialogbox() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(content: Text("Are you sure for this"), actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                )),
            ElevatedButton(
                onPressed: () {
                  Logout();
                },
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.black),
                )),
          ]);
        });
  }

  Logout() async {
    await auth.signOut().whenComplete(() =>   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "User Logout Successfully",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.red,fontSize: 20),
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)),
    ))).whenComplete(() => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>loginpage(title: 'User Login')), (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // height: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.black, width: 1)),
                    child: TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyOrders()));
                        },
                        icon: Icon(
                          Icons.fire_truck,
                          color: Colors.black,
                        ),
                        label: Text(
                          "My Orders",
                          style: TextStyle(fontSize: 22, color: Colors.black),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Colors.black, width: 1)),
                      child: TextButton.icon(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Bottamnavigate(
                                          selectedindex: 1,
                                        )));
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.black,
                          ),
                          label: Text(
                            "Favorite Item",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ))),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 151,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.black, width: 1)),
                    child: TextButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.percent_rounded,
                          color: Colors.black,
                        ),
                        label: Text(
                          "Discount",
                          style: TextStyle(fontSize: 22, color: Colors.black),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: 180,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Colors.black, width: 1)),
                      child: TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.headphones,
                            color: Colors.black,
                          ),
                          label: Text(
                            "Help Center",
                            style: TextStyle(fontSize: 22, color: Colors.black),
                          ))),
                ),
              ],
            ),
            Container(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // height: 200,
                width: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account Setting",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Profile()));
                                  },
                                  icon: Icon(Icons.account_circle_outlined),
                                  label: Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            onPressed: () {
                              LogoutDialogbox();
                            },
                            icon: Icon(Icons.logout),
                            label: Text(
                              "Logout",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
