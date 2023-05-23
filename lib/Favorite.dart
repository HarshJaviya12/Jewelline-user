import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewellin_user/All-MODEL-CLASS/Favoritemodel_class.dart';
import 'package:jewellin_user/All-MODEL-CLASS/MethodClass.dart';
import 'package:jewellin_user/Product-Placed-Page.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'All-MODEL-CLASS/Product_Class.dart';
import 'bottamnavigate.dart';

class Favorite extends StatefulWidget {
  Favorite({Key? key, this.product}) : super(key: key);

  productclass? product;

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  Method ref = Method();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: GradientText(
            "Favorite",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            colors: [
              Colors.black,
              Colors.orange,
              Colors.red,
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 700,
              child: FutureBuilder<List<Favoritemodelclass>>(
                future: ref.Favoriteshow(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print("data${snapshot.error}");
                    if (snapshot.data!.isEmpty) {
                      return Center(child: Text("Add Something In Favorite",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25, color: Colors.indigo
                        ),
                      ),);
                    }
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border:
                                  Border.all(color: Colors.black, width: 2),
                                  shape: BoxShape.rectangle),
                              child: ListTile(
                                title: Container(
                                  height: 100,
                                  alignment: Alignment.topLeft,
                                  child: Image.network(
                                    snapshot.data![i].photo.toString(),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data![i].subcategory
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Category Type:-${snapshot.data![i]
                                            .category.toString()}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            // backgroundColor: Colors.grey
                                            fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "₹ ${snapshot.data![i].price
                                            .toString()}/-",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          decoration:
                                          TextDecoration.lineThrough,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 40,
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              setState(() {
                                                ref.RemovedatafromFavorite(
                                                    id: snapshot.data![i].id
                                                        .toString());
                                              });

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "Product Remove From Favorite",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 17,
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.indigo,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      50)),
                                            ),
                                            label: Text("Remove"),
                                            icon: Icon(Icons.delete),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CartBuyPage(
                                                            ProductPrice: snapshot
                                                                .data![i].price
                                                                .toString(),
                                                            ProductPhoto: snapshot
                                                                .data![i].photo!

                                                                .toString(),
                                                            ProductName: snapshot
                                                                .data![i]
                                                                .subcategory
                                                                .toString(),
                                                          )));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.indigo,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      50)),
                                            ),
                                            label: Text("Buy this Now"),
                                            icon: Icon(Icons.flash_on_outlined),
                                          ),
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: Colors.black,
                                        )
                                      ],
                                    ),


                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 40,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              ref.Cartcollection(
                                                ProductName: snapshot.data![i].subcategory.toString(),
                                                ProductDiscountPrice: snapshot.data![i].discount.toString(),
                                                ProductPhoto: snapshot.data![i].photo!.toString(),
                                                Productprice: snapshot.data![i].price.toString(),
                                                Productid: snapshot.data![i].id.toString(),
                                                Productcategory: snapshot.data![i].category.toString(),



                                              ).whenComplete(() =>
                                                  Navigator.pushAndRemoveUntil(
                                                      context, MaterialPageRoute(
                                                      builder: (context) =>
                                                          Bottamnavigate(
                                                            selectedindex: 2,)), (
                                                      route) => false)
                                              );
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.indigo,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    50)),
                                          ),
                                          label: Text("Add to Cart"),
                                          icon: Icon(Icons.shopping_cart),
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                                // trailing: Image.network(snapshot.data![i].photo!.first),
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
            ),
          ],
        ),
      ),
    );
  }
}
