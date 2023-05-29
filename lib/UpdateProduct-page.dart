import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewellineadmin/ALL_MODEL_CLASS/Method.dart';
import 'package:jewellineadmin/homepage.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'dart:io';

class UpdateProduct extends StatefulWidget {
  UpdateProduct(
      {Key? key,
      this.ProductName,
      this.ProductPrice,
      this.ProductCategory,
      this.ProductDiscount,
      this.ProductDetails,
      this.Id})
      : super(key: key);

  String? ProductName;
  String? ProductPrice;
  String? ProductCategory;
  String? ProductDiscount;
  String? ProductDetails;
  String? Id;

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  var key = GlobalKey<FormState>();

  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController detailscontroller = TextEditingController();
  TextEditingController categorycontroller = TextEditingController();
  TextEditingController discountcontroller = TextEditingController();

  String? Id;

  bool isLoading = false;
  bool _isLoading = false;

  Method ref = Method();

  List<String> file = [];

  @override
  void initState() {
    namecontroller.text = widget.ProductName!;
    pricecontroller.text = widget.ProductPrice!;
    categorycontroller.text = widget.ProductCategory!;
    detailscontroller.text = widget.ProductDetails!;
    discountcontroller.text = widget.ProductDiscount!;
    Id = widget.Id;
  }

  Future<void> updateDetails() async {
    try {
      await FirebaseFirestore.instance.collection("Product").doc(Id).update({
        "subcategory": namecontroller.text,
        "category": categorycontroller.text,
        "price": pricecontroller.text,
        "Discount": discountcontroller.text,
        "Details": detailscontroller.text,
      });
      print("update");
    } on FirebaseException catch (e) {
      print("product${e}");
    }
  }

  Future<void> updatephoto({required List<String> photo}) async {
    try {
      await FirebaseFirestore.instance.collection("Product").doc(Id).update({
        "photo": photo,
      }).whenComplete(() => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "Update Photo Succesfully",
            style: TextStyle(
                fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
          ))));
      print("update");
    } on FirebaseException catch (e) {
      print("product${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: GradientText(
            "Update Product",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            colors: [
              Colors.purple,
              Colors.black,
              Colors.pinkAccent,
              Colors.red,
            ],
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton.icon(
        icon: Icon(Icons.update),
        label: _isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Loading...",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ],
              )
            : Text("Update"),
        onPressed: () {
          setState(() {
            _isLoading = true;
          });
          Future.delayed(Duration(seconds: 4), () {
            setState(() {
              _isLoading = false;
            });
          });
          if (key.currentState!.validate()) {
            updateDetails()
                .whenComplete(
                    () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Product Update Successfully",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 20),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        )))
                .whenComplete(() => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => homepage()),
                    (route) => false));
          }
        },
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40))),
      ),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: GradientText(" Product Update Details",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    gradientType: GradientType.radial,
                    radius: 6,
                    colors: const [
                      Colors.purple,
                      Colors.blue,
                      Colors.orange,
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: namecontroller,
                  validator: (k2) {
                    if (k2!.isEmpty) {
                      return "Its Complesary";
                    } else if (k2.length < 2) {
                      return "Enter Proper Productname";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "ProductName", border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 3,
                  controller: detailscontroller,
                  validator: (k2) {
                    if (k2!.isEmpty) {
                      return "Its Complesary";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "ProductDetails", border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: categorycontroller,
                  validator: (k2) {
                    if (k2!.isEmpty) {
                      return "Its Complesary";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "ProductCategory",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: pricecontroller,
                  validator: (k2) {
                    if (k2!.isEmpty) {
                      return "Its Complesary";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "ProductPrice", border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: discountcontroller,
                  validator: (k2) {
                    if (k2!.isEmpty) {
                      return "Its Complesary";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "ProductDiscountPrice",
                      border: OutlineInputBorder()),
                ),
              ),
              ElevatedButton(
                child: Text(
                  "Select Multiple Image",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  ref.selectmultipleImage().then((value) => setState(() {}));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    foregroundColor: Colors.black),
              ),
              (ref.imagelist.isEmpty)
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 5)),
                        // width: 350,w\
                        height: 450,
                        child: Text(
                          "Image not selected",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 5)),
                      height: 400,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ref.imagelist!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5),
                        itemBuilder: (BuildContext context, int index) {
                          return Image.file(
                            File(ref.imagelist![index].path),
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
              Center(
                child: ElevatedButton(
                  child: isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Loading...",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ],
                        )
                      : const Text(
                          "Submit",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal),
                        ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    Future.delayed(Duration(seconds: 4), () {
                      setState(() {
                        isLoading = false;
                      });
                    });
                    int random = Random().nextInt(10000);
                    String id =
                        "$random${DateTime.now().microsecondsSinceEpoch}";

                    if (ref.imagelist.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        "Please Select Image",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 20),
                      )));
                    } else {
                      if (key.currentState!.validate()) {
                        key.currentState!.save();
                        for (int i = 0; i < ref.imagelist.length; i++) {
                          String url = await ref.uploadFile(ref.imagelist[i]);
                          file.add(url);

                          if (i == ref.imagelist.length - 1) {
                            updatephoto(photo: file);
                          }
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      foregroundColor: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
