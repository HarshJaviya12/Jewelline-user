import 'package:flutter/material.dart';

// import 'package:jewellineadmin/Glasshouses.dart';
import 'package:jewellineadmin/ALL_MODEL_CLASS/Method.dart';
import 'package:jewellineadmin/ALL_MODEL_CLASS/CategoryModel-class.dart';
import 'package:jewellineadmin/Drawer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'Update-Category-page.dart';

class Showcategory extends StatefulWidget {
  const Showcategory({Key? key}) : super(key: key);

  @override
  State<Showcategory> createState() => ShowcategoryState();
}

class ShowcategoryState extends State<Showcategory> {
  Method ref = Method();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: GradientText(
            "Category Show",
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
      // backgroundColor: Colors.black,

      // ***********************FutureBuilder for Single Image ********************************

      body: FutureBuilder<List<Categorymodelclass>>(
          future: ref.logos(),
          builder: (context, snapshot) {
            print("hii${snapshot.error}");
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 150,
                        width: 80,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              shape: BoxShape.rectangle),
                          child: ListTile(
                            title: Text(
                              "Category: ${snapshot.data![i].Categaries.toString()}",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 22,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sub Category: ${snapshot.data![i].SubCategaries.toString()}",
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 22,
                                  ),
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
                                                        Updatecategory(
                                                          Categoryname:snapshot.data![i].Categaries.toString(),
                                                          Subcategory:snapshot.data![i].SubCategaries.toString(),
                                                          Id:snapshot.data![i].id.toString(),
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
                                              print("id:-${snapshot.data![i].id}");
                                              ref.RemoveoCategory(
                                                  Id:snapshot.data![i].id.toString()
                                              ).whenComplete(() =>
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                      child: Text(
                                                        "Category Delete Successfully",
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
                              height: 150,
                              child: Image.network(snapshot
                                  .data![i].Image!
                                  .toString()),
                            ),

                          ),
                        ),
                      ),
                    );
                  });
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
