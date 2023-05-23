import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewellin_user/All-MODEL-CLASS/CartModel_Class.dart';
import 'package:jewellin_user/All-MODEL-CLASS/MethodClass.dart';
import 'package:jewellin_user/Product-Placed-Page.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'bottamnavigate.dart';

class mycart extends StatefulWidget {
  const mycart({Key? key}) : super(key: key);

  @override
  State<mycart> createState() => _mycartState();
}

class _mycartState extends State<mycart> {

  double TotalCartProductprice = 0.0;


  Method ref = Method();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: GradientText(
            "Cart",
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

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topRight,
                height: 60,
                child: FutureBuilder<List<Cartmodelclass>>(
                    future: ref.cartshow(),
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        for( int i=0 ; i<snapshot.data!.length; i++){
                          TotalCartProductprice += double.parse(snapshot.data![i].discount.toString());
                        }
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Subtotal:-₹${TotalCartProductprice}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.indigoAccent),),
                        ],
                      );

                    }
                ),
              ),
            ),
            Divider(color: Colors.black,thickness: 2,),
            SizedBox(
              height: 600,
              child:FutureBuilder<List<Cartmodelclass>>(
                future: ref.cartshow(),
                builder: (context, snapshot) {
                  print("data${snapshot.hasData}");

                  //  return Center(child: Text("Add in Cart",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),));
                  if (snapshot.hasData) {
                    if(snapshot.data!.isEmpty){
                      return Center(
                        child: Text("Add in Cart",style: TextStyle(
                          fontSize: 25,fontWeight: FontWeight.bold,color: Colors.green
                        ),),
                      );
                    }
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                      color: Colors.black, width: 2)
                              ),
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 150,
                                      alignment: Alignment.topLeft,
                                      child: Image.network(
                                          snapshot.data![i].photo!.toString())),
                                ),


                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Text(
                                          snapshot.data![i].subcategory
                                              .toString(), style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("₹ ${snapshot.data![i].price
                                          .toString()}/-",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black,
                                            decoration: TextDecoration
                                                .lineThrough,
                                            decorationStyle: TextDecorationStyle
                                                .solid
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Special Price:-${snapshot.data![i]
                                            .discount.toString()}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),


                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Container(
                                          height: 40,
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              setState(() {
                                                ref.Removedatafromcart(
                                                    id: snapshot.data![i].id
                                                        .toString())
                                                    .whenComplete(() =>
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                Bottamnavigate(
                                                                  selectedindex: 2,)))

                                                );
                                              });

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                  SnackBar(content: Text(
                                                    "Product Remove From Cart",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 17,
                                                        color: Colors.grey
                                                    ),))
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.indigo,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(50)
                                              ),
                                            ),
                                            label: Text("Remove"),
                                            icon: Icon(Icons.delete),),
                                        ),

                                        Container(
                                          height: 40,
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CartBuyPage(ProductName: snapshot.data![i].subcategory.toString(),
                                                ProductPhoto: snapshot.data![i].photo!.toString(),
                                              ProductPrice: snapshot.data![i].discount.toString(),
                                              )));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.indigo,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(50)
                                              ),
                                            ),
                                            label: Text("Buy this Now"),
                                            icon: Icon(
                                                Icons.flash_on_outlined),),
                                        ),

                                        Divider(
                                          thickness: 3,
                                          color: Colors.black,
                                        )

                                      ],
                                    ),


                                  ],
                                ),


                              ),
                            ),
                          );
                        }

                    );
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
