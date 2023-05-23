import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jewellin_user/PaymentPage.dart';
import 'All-MODEL-CLASS/MethodClass.dart';
import 'All-MODEL-CLASS/Usermodelclass.dart';
import 'package:http/http.dart' as http;

class CartBuyPage extends StatefulWidget {
  CartBuyPage({Key? key,this.ProductName,this.ProductPhoto,this.ProductPrice}) : super(key: key);

  String? ProductName;
  String? ProductPhoto;
  String? ProductPrice;

  @override
  State<CartBuyPage> createState() => CartBuyPageState();
}

class CartBuyPageState extends State<CartBuyPage> {


  String? _city;
  String? _state;

  Future<void> _getCityAndState(String pinCode) async {
    final url = Uri.parse('https://api.postalpincode.in/pincode/$pinCode');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)[0];
      final postOffice = jsonData['PostOffice'][0];
      setState(() {
        _city = postOffice['District'];
        _state = postOffice['State'];
      });
    } else {
      setState(() {
        _city = '';
        _state = '';
      });
    }
  }



  TextEditingController addresscontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();

  var key = GlobalKey<FormState>();
  Method ref = Method();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [

                Container(

                  height: 800,
                  child: FutureBuilder<List<usermodelclass>>(
                      future: ref.show().then((value) => value.where((element) => element.Uid ==FirebaseAuth.instance.currentUser?.uid).toList()),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Name:-${snapshot.data![i].Name.toString()}",style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                color: Colors.green
                                              ),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Email:-${snapshot.data![i].Email}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.cyan),),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Phone Number:${snapshot.data![i].mobile}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.indigo),),
                                            ),
                                            Divider(
                                              color: Colors.black,
                                              thickness: 2,
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Product Price:-${widget.ProductPrice.toString()}",
                                              style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color:  Colors.blue),
                                              ),
                                            )

                                          ],

                                        ),

                                        subtitle: Container(
                                          alignment: Alignment.topLeft,
                                          height: 150,
                                          width: 100,
                                          child: Image.network(widget.ProductPhoto.toString()),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: TextFormField(
                                            controller: addresscontroller,
                                            validator: (k2) {
                                              if (k2!.isEmpty) {
                                                return "Its Complesary";
                                              }else {
                                                return null;
                                              }
                                            },
                                            decoration: InputDecoration(
                                               labelStyle: TextStyle(
                                                 color: Colors.indigoAccent
                                               ),
                                              labelText:"Enter Your Address",
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                   color: Colors.green,
                                                   width: 3
                                                ),
                                                borderRadius: BorderRadius.circular(10)
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),


                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: TextFormField(
                                                  controller: TextEditingController(text: _state),
                                                  validator: (k2) {
                                                    if (k2!.isEmpty) {
                                                      return "Its Complesary";
                                                    }else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                      labelStyle: TextStyle(
                                                          color: Colors.indigoAccent
                                                      ),
                                                    labelText:"Enter Your State",
                                                      border: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.green,
                                                              width: 3
                                                          ),
                                                          borderRadius: BorderRadius.circular(10)
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: TextFormField(
                                                  controller: TextEditingController(text: _city),
                                                  validator: (k2) {
                                                    if (k2!.isEmpty) {
                                                      return "Its Complesary";
                                                    }else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                      labelStyle: TextStyle(
                                                          color: Colors.indigoAccent
                                                      ),
                                                    labelText:"Enter Your CityName",
                                                      border: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.green,
                                                              width: 3
                                                          ),
                                                          borderRadius: BorderRadius.circular(10)
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: TextFormField(
                                            style: TextStyle(
                                              color: Colors.black
                                            ),
                                            controller: pincodecontroller,
                                            onChanged: (value){
                                              if(value.length == 6){
                                                _getCityAndState(value);
                                              }else{
                                                setState(() {
                                                  _city='';
                                                  _state='';
                                                });
                                              }
                                            },


                                            keyboardType: TextInputType.phone,
                                            validator: (k2) {
                                              if (k2!.isEmpty) {
                                                return "Its Complesary";
                                              }else if(k2.length>6){
                                                return "Enter correct pincode";
                                              }
                                            },
                                            decoration: InputDecoration(
                                                labelStyle: TextStyle(
                                                    color: Colors.indigoAccent
                                                ),
                                              labelText:"Enter Your Pincode",
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 3
                                                    ),
                                                    borderRadius: BorderRadius.circular(10)
                                                )
                                            ),
                                          ),
                                        ),
                                      ),


                                      ElevatedButton(onPressed: (){

                                        if(key.currentState!.validate()){



                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Payment(
                                            UserName:snapshot.data![i].Name.toString(),
                                            UserEmail:snapshot.data![i].Email.toString(),
                                            UserNumber:snapshot.data![i].mobile.toString(),
                                            ProductName:widget.ProductName.toString(),
                                            ProductPrice:widget.ProductPrice.toString(),
                                            ProductPhoto:widget.ProductPhoto.toString(),
                                            Address:addresscontroller.text.toString(),
                                            StateName:_state.toString(),
                                            Pincode:pincodecontroller.text.toString(),
                                            CityName:_city.toString(),


                                          )));
                                        }


                                      },
                                          style: ElevatedButton.styleFrom(
                                            maximumSize:Size(MediaQuery.of(context).size.width, 200),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),

                                          ),
                                          child: Text("Placed Order",style: TextStyle(
                                              fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white
                                          ),))

                                    ],
                                  ),
                                );

                              });
                        }else{
                          return
                            Center(
                              child:  CircularProgressIndicator(),
                            );

                        }


                      }
                      ),

                ),

              ],
            ),
          ),
        ),
      ),
    );

  }
}
