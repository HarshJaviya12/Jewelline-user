import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewellineadmin/ALL_MODEL_CLASS/Order-modelclass.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'ALL_MODEL_CLASS/Method.dart';
import 'Drawer.dart';
import 'Upadate-Order-Page.dart';

class UserOrder extends StatefulWidget {
  const UserOrder({Key? key}) : super(key: key);

  @override
  State<UserOrder> createState() => _UserOrderState();
}

class _UserOrderState extends State<UserOrder> {
  Method ref = Method();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: GradientText(
            "User Orders",
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
      drawer: drawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 700,
              child: FutureBuilder<List<Ordershowmodelclass>>(
                  future: ref.showOrder(),
                  builder: (context, snapshot) {
                    print("Order${snapshot.hasData}");
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 2),
                                  shape: BoxShape.rectangle,
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Customer Name:-${snapshot.data![i].UserName.toString()}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigoAccent),
                                      ),
                                      Text(
                                        "Customer Num:-${snapshot.data![i].UserNumber}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.purple),
                                      ),
                                      Text(
                                        "Product Name:-${snapshot.data![i].ProductName.toString()}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigoAccent),
                                      ),
                                      Text(
                                        "Product Price:-${snapshot.data![i].ProductPrice.toString()}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.purple),
                                      ),
                                      Text(
                                        "Customer City:-${snapshot.data![i].CityName}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigoAccent),
                                      ),
                                      Text(
                                        "Customer State:-${snapshot.data![i].StateName}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.purple),
                                      ),
                                      Text(
                                        "Ordered Date:-${snapshot.data![i].Date}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.purple),
                                      ),
                                      Container(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Trackorder(
                                                            Details: snapshot
                                                                .data![i])));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0))),
                                          child: Text("Update Order"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
