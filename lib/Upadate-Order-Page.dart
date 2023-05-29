import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jewellineadmin/ALL_MODEL_CLASS/Order-modelclass.dart';
import 'package:jewellineadmin/homepage.dart';

class Trackorder extends StatefulWidget {
  Trackorder({Key? key,this.Details}) : super(key: key);

  Ordershowmodelclass? Details;

  @override
  State<Trackorder> createState() => _TrackorderState();
}


class _TrackorderState extends State<Trackorder> {

  bool isLoding = false;

List<String> Menu =[
  "Order Conformed",
  "Order Shipped",
  "Out For Delivery",
  "Order Delivered"
];

 String? Select;


 Future<void>upadeStatus()async{
   await FirebaseFirestore.instance.collection("Order").doc(widget.Details!.id).update({
     "Status": Select
   });
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("OrderTracking"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text("Product id:- ${widget.Details!.id.toString()}",style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),),
              ),
            ),
            ListTile(
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                      ),
                      child: Text("Product Name:-${widget.Details!.ProductName.toString()}",style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black
                      ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Product Price:-${widget.Details!.ProductPrice.toString()}/-",style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black
                    ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Product Status:-${widget.Details!.Status.toString()}",style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black
                    ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Date and Time:-${widget.Details!.Date.toString()}",style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black
                    ),
                    ),
                  ),


                  Divider(color: Colors.black,thickness: 2,),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Customer Name:-${widget.Details!.UserName.toString()}",style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black
                    ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Customer Num:-${widget.Details!.UserNumber.toString()}",style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black
                    ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Address:-${widget.Details!.Address.toString()}",style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black
                        ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("City:-${widget.Details!.CityName.toString()}",style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black
                        ),
                        ),
                      ),


                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Pincode:-${widget.Details!.Pincode.toString()}",style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black
                    ),
                    ),
                  ),


                  Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),

                  Center(
                      child: Text("Order Status",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orangeAccent,fontSize: 25),)),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Order Tracking"),
                        ),
                        InputDecorator(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          isEmpty: Select == null,
                          child: DropdownButtonFormField(
                            items: Menu.map((e) => DropdownMenuItem(child: Text(e),value: e,)).toList(),
                            onChanged: (String ? newvalue){
                              setState(() {
                                Select = newvalue!;
                              });

                            },

                          ),
                        ),

                        ElevatedButton(onPressed: (){
                          setState(() {
                            isLoding = false;
                          });
                          Future.delayed(Duration(seconds: 3),(){
                            setState(() {
                              isLoding = true;
                            });
                          });
                          print("Order${Select}");
                          upadeStatus().whenComplete(() =>
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: isLoding? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Loading...",
                                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      CircularProgressIndicator(color: Colors.black,),
                                    ],
                                  ):Text(
                                    "Order Update Successfully",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, color: Colors.red,fontSize: 20),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                              ))
                          ).whenComplete(() => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>homepage()), (route) => false));

                        },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              )
                            ),
                            child: Text("Update",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
                      ],
                    ),
                  )
                  

                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}

class TrackOrderList {

}
