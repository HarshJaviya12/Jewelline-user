import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewellin_user/All-MODEL-CLASS/MethodClass.dart';
import 'package:jewellin_user/All-MODEL-CLASS/OrderModel-class.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'OrderTrackPage.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  Method ref = Method();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: GradientText(
            "MY Orders",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            colors: [
              Colors.orange,
              Colors.black,
              Colors.red,
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 800,
              child: FutureBuilder<List<OrderModelclass>>(
                future: ref.Ordershow().then((value) => value.where((element) => element.Userid== FirebaseAuth.instance.currentUser!.uid).toList()),
                builder: (context, snapshot) {
                  print("Order....${snapshot.hasData}");
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                shape: BoxShape.rectangle,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Product Name:-${snapshot.data![i].ProductName.toString()}",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigoAccent),
                                  ),
                                  Text(
                                    "Price:-${snapshot.data![i].ProductPrice.toString()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.green),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderTracking(productid:snapshot.data![i].id.toString(),Status:snapshot.data![i].Status.toString())));
                                          },
                                          child: Text(
                                            "Track Your Order",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.yellowAccent),
                                          )),
                                      Container(
                                          child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {

                                                  ref.Removeorder(
                                                    id:snapshot.data![i].id.toString(),
                                                  );

                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text("Order Canceled",
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 17,
                                                          color: Colors.red),
                                                    )),
                                                  );

                                                });

                                              },
                                              child: Text(
                                                "Cancel Order",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.yellowAccent),
                                              )))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
