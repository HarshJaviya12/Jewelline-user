import 'dart:math';

import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:jewellin_user/All-MODEL-CLASS/Product_Class.dart';

class OrderTracking extends StatefulWidget {
  OrderTracking({Key? key,this.productid,this.Status,}) : super(key: key);

  String? productid;
  String? Status;

  @override
  State<OrderTracking> createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {

  int? randomnumber = Random().nextInt(1000);

  int? ActiveStep = 0;


  @override
  void initState() {

    switch(widget.Status){
      case "Order Conformed":
        ActiveStep = 0;
        break;
      case "Order Shipped":
        ActiveStep = 1;
        break;
      case "Out For Delivery":
        ActiveStep = 2;
        break;
      case "Order Delivered":
        ActiveStep = 3;
        break;
      default:
        ActiveStep = 0;
    }
  }

  List<TrackOrderList> trackOrderList = [
    TrackOrderList(
      title: "order confirmed",
      subtitle: "your order has been placed",
    ),
    TrackOrderList(
      title: "shipped",
      subtitle: "your item has been shipped",
    ),
    TrackOrderList(
      title: "out for delivery",
      subtitle: "your order out for delivery",
    ),
    TrackOrderList(
      title: "delivered",
      subtitle: "your order has been delivered",
    ),
  ];




  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(
          child: Text("Track Page"),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.orangeAccent,
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Product Id:-${widget.productid}",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                  ),
                  Text(
                    'Order #${randomnumber}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  // SizedBox(height: 8.0),
                ],
              ),
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height/1.6,
                  width: MediaQuery.of(context).size.width/5,
                  child: IconStepper(
                    direction: Axis.vertical,
                    activeStep: ActiveStep!.toInt(),
                    enableNextPreviousButtons: false,
                    enableStepTapping: false,
                    stepColor: Colors.yellow,
                    activeStepColor: Colors.green,
                    stepReachedAnimationDuration: const Duration(seconds: 2),
                    activeStepBorderColor: Colors.black,
                    activeStepBorderWidth: 0.0,
                    activeStepBorderPadding: 0.0,
                    previousButtonIcon: const Icon(Icons.arrow_back),
                    lineColor: Colors.green,
                    scrollingDisabled: true,
                    lineLength: 68.0,
                    lineDotRadius: 2.0,
                    stepRadius: 16.0,
                    icons: const [
                      Icon(Icons.radio_button_checked, color: Colors.green),
                      Icon(Icons.check, color: Colors.white),
                      Icon(Icons.check, color: Colors.white),
                      Icon(Icons.check, color: Colors.white),
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    height: 400,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                        itemCount: trackOrderList.length,
                        itemBuilder: (context,index){
                          final item = trackOrderList[index];
                          return Column(
                            children: [
                              Container(
                                height: 23,
                              ),
                            ListTile(
                              title: Text(item.title,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 22),),
                              subtitle: Text(item.subtitle),
                            )
                            ],
                          );
                        }
                    ),
                  ),
                )
              ],
            ),
            
            Container(
                alignment: Alignment.bottomLeft,
                child: Icon(Icons.home_outlined,size: 50,))



          ],
        ),
      ),
    );
  }
}

class TrackOrderList {
  final String title;
  final String subtitle;
  TrackOrderList({required this.title, required this.subtitle});
}





