import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewellineadmin/ALL_MODEL_CLASS/Method.dart';
import 'package:jewellineadmin/ALL_MODEL_CLASS/ProductModel-class.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'Drawer.dart';
import 'UpdateProduct-page.dart';

class ProductShow extends StatefulWidget {
  const ProductShow({Key? key}) : super(key: key);

  @override
  State<ProductShow> createState() => _ProductShowState();
}

class _ProductShowState extends State<ProductShow> {
  Method ref = Method();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        title: Center(
          child: GradientText(
            "Product Show",
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
      body: FutureBuilder<List<ProductModelclass>>(
          future: ref.ShowProduct(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 150,
                        width: 80,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: Colors.black, width: 1)),
                        child: ListTile(
                          title: Text(
                            "Product Name:-${snapshot.data![i].ProductName.toString()}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Product Price:-${snapshot.data![i].ProductPrice.toString()}/-",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                "Product DiscountPrice:-${snapshot.data![i].ProductDiscountPrice.toString()}/-",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                "Product Category:-${snapshot.data![i].ProductCategory.toString()}.",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateProduct(
                                                        ProductName: snapshot.data![i].ProductName.toString(),
                                                        ProductPrice: snapshot.data![i].ProductPrice.toString(),
                                                        ProductCategory: snapshot.data![i].ProductCategory.toString(),
                                                        ProductDiscount: snapshot.data![i].ProductDiscountPrice.toString(),
                                                        ProductDetails: snapshot.data![i].ProductDetails.toString(),
                                                        Id: snapshot.data![i].id.toString(),
                                                      )));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0))),
                                        child: Text("Update",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.black))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            print("id${snapshot.data![i].id}");

                                            ref.RemoveoProduct(
                                              Id: snapshot.data![i].id.toString(),
                                            ).whenComplete(() =>
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Product Delete Successfully",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                )));
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0))),
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.black),
                                        )),
                                  ),
                                ],
                              )
                            ],
                          ),
                          trailing: Container(
                            height: 100,
                            child: Image.network(snapshot.data![i].ProductImage!.first.toString()),
                          ),
                          // trailing: Container(
                          //   height: 100,
                          //   child: Image.network(snapshot
                          //       .data![i].ProductImage!.first
                          //       .toString()),
                          // ),
                        ),
                      ),
                    );
                  });
            }
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }),
    );
  }
}
