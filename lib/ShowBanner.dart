import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewellineadmin/ALL_MODEL_CLASS/Method.dart';
import 'package:jewellineadmin/homepage.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'ALL_MODEL_CLASS/UserBanner-ModelClass.dart';
import 'Drawer.dart';

class ShowBanner extends StatefulWidget {
  const ShowBanner({Key? key}) : super(key: key);

  @override
  State<ShowBanner> createState() => ShowBannerState();
}

final Imagecollection = FirebaseFirestore.instance.collection("SingleImage");


class ShowBannerState extends State<ShowBanner> {



  Future<void> DeleteBanner(String id) async {
    await Imagecollection.doc(id).delete().whenComplete(() =>
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Banner Deleted",style: TextStyle(fontSize: 20,color: Colors.red),)
        ))
        ).whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>homepage())));
  }


  DeletebannerDialogbox( {required String Id}) {
    showDialog(context: context, builder: (BuildContext contex) {
      return SimpleDialog(
        title: Text("Do You wnat to delete Banner", style: TextStyle(
            fontSize: 18,
            color: Colors.lightBlue,
            fontWeight: FontWeight.bold),),

        children: [
          SimpleDialogOption(
            onPressed: (){
              setState(() {
                DeleteBanner(Id);
              }
              );

            },
            child: Text("Yes",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 18),),
          ),
          SimpleDialogOption(
            onPressed: (){},
            child: Text("No"),
          ),
        ],
      );
    }
    );
  }

  Method ref = Method();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: GradientText(
            "Show Banner",
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
      drawer: drawer(),

      body: FutureBuilder<List<SingleImage>>(
        future: ref.showBanner(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Colors.black, width: 2)
                      ),
                      child: ListTile(
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              alignment: Alignment.topLeft,
                              height: 200,
                              child: Image.network(
                                  snapshot.data![i].Image.toString())),
                        ),
                        trailing: IconButton(onPressed: () {
                          DeletebannerDialogbox(Id:snapshot.data![i].id.toString());
                        }, icon: Icon(Icons.delete_forever_rounded, size: 35,)),
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
    );
  }
}
