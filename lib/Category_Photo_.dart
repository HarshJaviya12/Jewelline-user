import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:jewellin_user/Click_Product_Show.dart';
import 'package:jewellin_user/All-MODEL-CLASS/MethodClass.dart';

import 'Particuler_Product.dart';
import 'All-MODEL-CLASS/Product_Class.dart';

class NewPage extends StatefulWidget {
   NewPage({Key? key, this.selectcategory}) : super(key: key);

  String? selectcategory;

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {

  TextEditingController searchController = TextEditingController();

  List<productclass>allproducts = [];

  Method ref= Method();
  String? selectcategory;

  @override
  void initState() {
    selectcategory = widget.selectcategory;
    print("product${widget.selectcategory}");
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.only(left: 5),
                height: 50,
                child: TextFormField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    labelText: 'Search here...',
                    labelStyle: TextStyle(
                        color: Colors.deepPurpleAccent
                    ),
                    border: OutlineInputBorder(),
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
              children: [
                SizedBox(
                  height: 600,
                  child: FutureBuilder<List<productclass>>(
                    future: ref.Product().then((value) => value.where((element) => element.categories==selectcategory).toList()),
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        return Container(
                          child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                              ),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context,i){
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PrticulerImage(product: snapshot.data![i],)));
                                    },
                                    title: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 120,
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                            image: NetworkImage(snapshot.data![i].Photo!.first.toString()),fit: BoxFit.contain
                                          )
                                        ),

                                      ),
                                    ),

                                    subtitle: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        // height: 200,
                                        width: MediaQuery.of(context).size.width,
                                        child: Column(
                                          children: [
                                            Text(snapshot.data![i].subcategories.toString(),
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                color: Colors.black
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
              ],
            ):

            SizedBox(
              height: 600,
              child: FutureBuilder<List<productclass>>(
                future: ref.Product().then((value) => value.where((element) => element.categories==selectcategory).toList()),
                builder: (context,snapshot){
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
                    return Container(
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context,i){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PrticulerImage(product: snapshot.data![i],)));
                                },
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 120,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(snapshot.data![i].Photo!.first.toString()),fit: BoxFit.contain
                                        )
                                    ),

                                  ),
                                ),

                                subtitle: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    // height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        Text(snapshot.data![i].subcategories.toString(),
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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

          ],
        ),
      ),

    );


  }
}
