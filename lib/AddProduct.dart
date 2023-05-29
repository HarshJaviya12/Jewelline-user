import 'dart:math';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jewellineadmin/homepage.dart';
import 'package:jewellineadmin/ALL_MODEL_CLASS/Method.dart';
import 'package:jewellineadmin/ALL_MODEL_CLASS/CategoryModel-class.dart';
import 'package:jewellineadmin/main.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'Drawer.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  State<AddProducts> createState() => AddProductsState();
}

class AddProductsState extends State<AddProducts> {
  TextEditingController Categorycontroller = TextEditingController();
  TextEditingController SubCategorycontroller = TextEditingController();
  TextEditingController Detailscontroller = TextEditingController();
  TextEditingController Pricecontroller = TextEditingController();
  TextEditingController Discountprice = TextEditingController();

  // method call = method();

  late List<Categorymodelclass> allCategoryData;

  String? selectedcategory;
  String? selectedsubcategory;

  //*********** Reference for Method *************
  Method ref = Method();

  var add = GlobalKey<FormState>();

  bool isLoading  = false;

  List<String> file = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: GradientText(
            "Add Product Page",
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
      drawer: drawer(),
      // backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Form(
          key: add,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width,
              ),
              FutureBuilder<List>(
                future: ref.Category(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Select Product Category"),
                          ),


                          InputDecorator(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            isEmpty: selectedcategory == null,
                            child: DropdownButtonFormField(
                              value: selectedcategory,
                              isDense: true,
                              onChanged: (newvalue) {
                                setState(() {
                                  selectedcategory = newvalue;
                                  selectedsubcategory = null ;
                                });
                              },
                              items: snapshot.data!
                                  .map((e) => DropdownMenuItem<String>(
                                        child: Text(
                                          e,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        value: e,
                                      ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return "Select Anything";
                                }
                                return null;
                              },
                            ),
                          ),
                          if(selectedcategory!= null)
                            FutureBuilder<List>(
                              future: ref.SubCategory(selectedcategory!),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CupertinoActivityIndicator(),
                                  );
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Select Product SubCategory"),
                                        ),
                                        InputDecorator(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                          isEmpty: selectedsubcategory == null,
                                          child: DropdownButtonFormField(
                                            value: selectedsubcategory,
                                            isDense: true,
                                            onChanged: (newvalue) {
                                              setState(() {
                                                selectedsubcategory = newvalue;
                                              });
                                            },
                                            items: snapshot.data!
                                                .map((e) => DropdownMenuItem<String>(
                                              child: Text(
                                                e,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              value: e,
                                            ))
                                                .toList(),
                                            validator: (value) {
                                              if (value == null) {
                                                return "Select Anything";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                        ],
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  controller: Detailscontroller,
                  validator: (add1) {
                    if (add1 == null || add1.isEmpty) {
                      return "It's Complesary";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    labelText: "Enter your Details",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: Pricecontroller,
                  validator: (add1) {
                    if (add1 == null || add1.isEmpty) {
                      return "It's Complesary";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    labelText: "Enter Price",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: Discountprice,
                  validator: (add1) {
                    if (add1 == null || add1.isEmpty) {
                      return "It's Complesary";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    labelText: "Enter Discount",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)),
                  ),
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
                  child: isLoading? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Loading...",
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircularProgressIndicator(color: Colors.white,),
                    ],
                  ):Text(
                    "Submit",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal),
                  ),

                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    Future.delayed(Duration(seconds:1),(){
                      setState(() {
                        isLoading = false;
                      });
                    });
                    int random = Random().nextInt(10000);
                    String id =
                        "$random${DateTime.now().microsecondsSinceEpoch}";

                    if (ref.imagelist.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                        "Please Select Image",
                        style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontSize: 20),
                      ),
                          ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ));
                    } else {
                      if (add.currentState!.validate()) {
                        add.currentState!.save();
                        for (int i = 0; i < ref.imagelist.length; i++) {
                          String url = await ref.uploadFile(ref.imagelist[i]);
                          file.add(url);

                          if (i == ref.imagelist.length - 1) {
                            ref.multipladata(
                                  file,
                                  Detailscontroller.text,
                                  selectedcategory!,
                                  selectedsubcategory!,
                                  Pricecontroller.text,
                                  Discountprice.text,
                                )
                                .whenComplete(() =>
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Product Add Successfully",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 20),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                    )))
                                .whenComplete(() =>
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => homepage()),
                                        (route) => false));
                            print("xyz${file}");
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
