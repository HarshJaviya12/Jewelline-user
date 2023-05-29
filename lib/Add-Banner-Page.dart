import 'package:flutter/material.dart';
import 'package:jewellineadmin/Drawer.dart';
import 'package:jewellineadmin/homepage.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'ALL_MODEL_CLASS/Method.dart';

class AddBanner extends StatefulWidget {
  const AddBanner({Key? key}) : super(key: key);

  @override
  State<AddBanner> createState() => AddBannerState();
}

class AddBannerState extends State<AddBanner> {

  bool isLoading  = false;

  Method ref = Method();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: GradientText(
            "Add Banner Page",
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
      drawer: drawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
            ),
            ElevatedButton(
              child: Text(
                "Select image on device",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                ref.singleimage().then((value) => setState(() {}));
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

            ElevatedButton(
                child: isLoading? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
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
                onPressed: () {
                  if (ref.image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Please Select photo",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        )));
                  }else{
                    setState(() {
                      isLoading = true;
                    });
                    Future.delayed(Duration(seconds: 4),() {
                      setState(() {
                        isLoading = false;
                      });
                    });
                    ref.ImageCollectionAdd().whenComplete(() =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Banner Uplod Successfully",
                              style: TextStyle(fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),)))
                    ).whenComplete(() =>
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) =>
                            homepage())));

                  }


                }
            ),



          ],
        ),
      ),


    );
  }
}
