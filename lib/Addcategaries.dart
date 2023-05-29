import 'package:flutter/material.dart';
import 'package:jewellineadmin/Drawer.dart';
import 'package:jewellineadmin/homepage.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'ALL_MODEL_CLASS/Method.dart';

class Addcategaries extends StatefulWidget {
  const Addcategaries({Key? key}) : super(key: key);

  @override
  State<Addcategaries> createState() => AddcategariesState();
}

class AddcategariesState extends State<Addcategaries> {

  bool isLoading  = false;

  TextEditingController Categorucontroller = TextEditingController();
  TextEditingController SubCategorucontroller = TextEditingController();
  TextEditingController Details = TextEditingController();

  var k1 = GlobalKey<FormState>();

  // for Category type
  String? JewellaryType;
  final List<String> Type = [];

  //For Subcatogory type
  String? Jewellary;
  final List<String> SubType = [];

  Method ref = Method();

  @override
  Widget build(BuildContext context) {
    // DropdownMenuItem<String> buildMenuItem(String item) =>
    //     DropdownMenuItem(value: item, child: Text(item));

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: GradientText(
            "Add Category Page",
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
          key: k1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    validator: (k1) {
                      if (k1!.isEmpty) {
                        return "Enter Details";
                      } else if (k1.contains(" ")) {
                        return "Space Is Not Valid";
                      }
                      else {
                        return null;
                      }
                    },
                    controller: Categorucontroller,
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      labelText: " Enter Category",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    validator: (k1) {
                      if (k1!.isEmpty) {
                        return "Enter Correct Name";
                      } else if (k1.contains(" ")) {
                        return "Space Is Not Valid";
                      }
                      else {
                        return null;
                      }
                    },
                    controller: SubCategorucontroller,
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      labelText: " Enter SubCategory",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                    ),
                  ),
                ),
              ),

              //button for single image

              ElevatedButton(
                child: Text(
                  "Select image on device",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  ref.singleimage().then((value) => setState(() {

                  }));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    // primary: Colors.lightGreen,
                    foregroundColor: Colors.black),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: (ref.image == null)
                    ? Container(
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
                )
                    : Container(
                  alignment: Alignment.center,
                  width: 300,
                  height: 400,
                  // color: Colors.orangeAccent,
                  child: Image.file(ref.image!, fit: BoxFit.fill),
                ),
              ),

              // Submit Button

              ElevatedButton(
                child: isLoading? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const[
                    Text("Loading...",style: TextStyle(fontSize: 20),),
                    SizedBox(width: 10,),
                    CircularProgressIndicator(color: Colors.white,),
                  ],
                ):const Text(
                  "Submit",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
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
                  if (ref.image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Please Select photo",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                    ));
                  }


                  if (k1.currentState!.validate()) {
                    ref.adddata(
                        Categorucontroller.text, SubCategorucontroller.text)
                        .whenComplete(() =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Category Add Successfully",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ))).whenComplete(() =>  Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => homepage()),
                            (route) => false));

                  }
                  SubCategorucontroller.clear();
                  Categorucontroller.clear();
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    // primary: Colors.lightGreen,
                    foregroundColor: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
