import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewellin_user/All-MODEL-CLASS/MethodClass.dart';

import 'Category_Photo_.dart';
import 'Particuler_Product.dart';
import 'All-MODEL-CLASS/Product_Class.dart';

class Seeall extends StatefulWidget {
  const Seeall({Key? key}) : super(key: key);

  @override
  State<Seeall> createState() => _SeeallState();
}

class _SeeallState extends State<Seeall> {

  Method ref= Method();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
            ),

            SizedBox(
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder<List>(
                  future: ref.FilterProduct(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 100,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child: ElevatedButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> NewPage(
                                      selectcategory: snapshot.data![i]
                                  )
                                  ));
                                },style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                                    )
                                ),
                                  child: Text(snapshot.data![i].toString(),style: TextStyle(
                                      fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black
                                  ),),
                                )
                            ),
                          );
                        },
                      );
                    }
                    return Center(
                        child: CupertinoActivityIndicator());
                  }),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: FutureBuilder<List<productclass>>(
                  future: ref.Product(),
                  builder: (context ,snapshot){
                    if(snapshot.hasData){
                      return SizedBox(
                        height:MediaQuery.of(context).size.height,
                        child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 15
                            ),
                            itemBuilder: (context , i){
                              return ListTile(
                                contentPadding: const EdgeInsets.all(8.0),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PrticulerImage(product: snapshot.data![i])));
                                },
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      // border: Border.all(color: Colors.black,width: 2),
                                      image: DecorationImage(
                                        image: NetworkImage(snapshot.data![i].Photo!.first.toString()),

                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),

                                subtitle: Container(
                                  child: Column(
                                    children: [
                                      Text(snapshot.data![i].subcategories.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              );
                            }

                        ),
                      );
                    }
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  },
                ),
              ),
            ),


          ],

        ),
      ),
    );
  }
}
