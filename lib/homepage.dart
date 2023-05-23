import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:jewellin_user/Category_Photo_.dart';
import 'package:jewellin_user/All-MODEL-CLASS/MethodClass.dart';
import 'package:jewellin_user/All-MODEL-CLASS/Product_Class.dart';
import 'package:jewellin_user/Seeall.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'Particuler_Product.dart';
import 'All-MODEL-CLASS/Singleimage_Model_Class.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  TextEditingController b1 = TextEditingController();
  TextEditingController b2 = TextEditingController();
  TextEditingController b3 = TextEditingController();
  TextEditingController b4 = TextEditingController();
  TextEditingController b5 = TextEditingController();
  TextEditingController searchController = TextEditingController();

  List<productclass>allproducts = [];

  late int activeIndex = 0;



  Method ref = Method();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Center(
          child: GradientText(
            "Jewelline",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            colors: [
              Colors.white,
              Colors.red,
              Colors.purple,
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white10,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   height: 30,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.only(left: 5),
                height: 50,
                width: 300,
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    labelText: 'Search here...',
                    labelStyle: TextStyle(
                      color: Colors.deepPurpleAccent
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),

                  onChanged: (value) {

                    setState(() {});
                  },
                ),
              ),
            ),


            (searchController.text.isEmpty)?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Hello Dear",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Let's Shop Something!",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),


                Stack(
                  children: [
                    FutureBuilder<List<SingleImage>>(
                        future: ref.HomeImageShow(),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            return  CarouselSlider.builder(
                              options: CarouselOptions(
                                height: 400,
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.8,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.3,
                                scrollDirection: Axis.horizontal,
                                onPageChanged: (index, reason) =>
                                    setState(() => activeIndex = index),
                              ),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index, realIndex) {
                                return Container(
                                  child: Image.network(snapshot.data![index].Image.toString()),
                                );
                              },

                            );


                          }
                          return Center(
                            child: CupertinoActivityIndicator(),
                          );
                        }
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text("Shop By Category",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:22
                    ),),
                  ),
                ),


//******************************************************************** Category Show FutureBuilder ********************************************************************************//
                SizedBox(
                  height: 68,
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
                                  // height: 100,
                                    width: 120,
                                    // decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(25)
                                    // ),
                                    child: ElevatedButton(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> NewPage(
                                          selectcategory: snapshot.data![i]
                                      )
                                      ));
                                    },style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black45,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15)

                                        )
                                    ),
                                      child: Text(snapshot.data![i].toString(),style: TextStyle(
                                          fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white
                                      ),),
                                    )
                                ),
                              );
                            },
                          );
                        }
                        return Center(
                            child: CupertinoActivityIndicator()
                        );
                      }),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Top Product",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Seeall()));
                      },
                          style: TextButton.styleFrom(

                          ),
                          child: Text("see all",style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                          ),)),
                    ),
                  ],
                ),


//*********************************************************************** Product Show FutureBuilder ********************************************************************************//

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 420,
                    // height: MediaQuery.of(context).size.height,
                    child: FutureBuilder<List<productclass>>(
                      future: ref.Product(),
                      builder: (context ,snapshot){
                        if(snapshot.hasData){

                          allproducts = snapshot.data!;
                          List<productclass>filterProduct=allproducts;

                          if(searchController.text.isNotEmpty){
                            String query = searchController.text.toLowerCase();
                            filterProduct = filterProduct.where((element) => element.subcategories!.toLowerCase().contains(query)).toList();
                          }

                          if(filterProduct.isEmpty){
                            return Container(
                                alignment: Alignment.topCenter,
                                child: const Text("Opps.Data is not Found",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),
                                ));
                          }

                          return SizedBox(
                            // height:MediaQuery.of(context).size.height,
                            height: 500,
                            child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: filterProduct.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 15
                                ),
                                itemBuilder: (context , i){
                                  return ListTile(
                                    contentPadding: const EdgeInsets.all(8.0),
                                    onTap: (){
                                      searchController.clear();
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => PrticulerImage(product: filterProduct[i])));
                                    },
                                    title: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          // border: Border.all(color: Colors.black,width: 2),
                                          image: DecorationImage(
                                            image: NetworkImage(filterProduct[i].Photo!.first.toString()),

                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),

                                    subtitle: Container(
                                      child: Column(
                                        children: [
                                          Text(filterProduct[i].subcategories.toString(),
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
            ):

 //*********************************************************************** Product Show After Search********************************************************************************//


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 420,
                child: FutureBuilder<List<productclass>>(
                  future: ref.Product(),
                  builder: (context ,snapshot){
                    if(snapshot.hasData){

                      allproducts = snapshot.data!;
                      List<productclass>filterProduct=allproducts;

                      if(searchController.text.isNotEmpty){
                        String query = searchController.text.toLowerCase();
                        filterProduct = filterProduct.where((element) => element.subcategories!.toLowerCase().contains(query)).toList();
                      }

                      if(filterProduct.isEmpty){
                        return Container(
                            alignment: Alignment.topCenter,
                            child: const Text("Opps.Data is not Found",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ));
                      }

                      return SizedBox(
                        // height:MediaQuery.of(context).size.height,
                        height: 500,
                        child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: filterProduct.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 15
                            ),
                            itemBuilder: (context , i){
                              return ListTile(
                                contentPadding: const EdgeInsets.all(8.0),
                                onTap: (){
                                  searchController.clear();
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PrticulerImage(product: filterProduct[i])));
                                },
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      // border: Border.all(color: Colors.black,width: 2),
                                      image: DecorationImage(
                                        image: NetworkImage(filterProduct[i].Photo!.first.toString()),

                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),

                                subtitle: Container(
                                  child: Column(
                                    children: [
                                      Text(filterProduct[i].subcategories.toString(),
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
