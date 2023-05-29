import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'homepage.dart';

class Updatecategory extends StatefulWidget {
  Updatecategory({Key? key,this.Categoryname,this.Subcategory, this.Id}) : super(key: key);

  String? Categoryname;
  String? Subcategory;
  String? Id;


  @override
  State<Updatecategory> createState() => _UpdatecategoryState();
}

class _UpdatecategoryState extends State<Updatecategory> {

  TextEditingController categorycontroller = TextEditingController();
  TextEditingController subcategorycontroller = TextEditingController();

  bool isLoading = false;

  var key = GlobalKey<FormState>();

  String? Id;


  @override
  void initState() {
    categorycontroller.text = widget.Categoryname!;
    subcategorycontroller.text = widget.Subcategory!;
    Id=widget.Id;
  }

  Future<void> Updatedetails()async{
    try{
      await FirebaseFirestore.instance.collection("Categories").doc(Id).update({
        "categories":categorycontroller.text,
        "sub categories":subcategorycontroller.text
      });
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
            "Update Category",
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
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: GradientText(" Category Update Details",
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
                controller: categorycontroller,
                validator: (k2) {
                  if (k2!.isEmpty) {
                    return "Its Complesary";
                  } else if (k2.length < 2) {
                    return "Enter Proper Type";
                  }
                },
                decoration: InputDecoration(
                    hintText: "CategoryType",
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: subcategorycontroller,
                validator: (k2) {
                  if (k2!.isEmpty) {
                    return "Its Complesary";
                  } else if (k2.length < 2) {
                    return "Enter Proper SubCategoryName";
                  }
                },
                decoration: InputDecoration(
                    hintText: "SubCategoryName",
                    border: OutlineInputBorder()),
              ),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.update),
              label: isLoading? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Loading...",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircularProgressIndicator(color: Colors.white,),
                ],
              ):Text("Update"),
              onPressed: () {
                if (key.currentState!.validate()) {

                  setState(() {
                    isLoading = true;
                  });
                  Future.delayed(Duration(seconds: 5), () {
                    setState(() {
                      isLoading = false;
                    });
                  });


                Updatedetails().whenComplete(() =>
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Category Update Successfully",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 20),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ))
                  ).whenComplete(() =>
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) => homepage()), (
                              route) => false));
                }
                },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
            ),

          ]
          ),
        ),
      ),
    );
  }
}
