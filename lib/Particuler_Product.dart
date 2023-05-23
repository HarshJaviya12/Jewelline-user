import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:jewellin_user/All-MODEL-CLASS/Category__model__Class.dart';
import 'package:jewellin_user/Product-Placed-Page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'All-MODEL-CLASS/MethodClass.dart';
import 'All-MODEL-CLASS/Product_Class.dart';
import 'bottamnavigate.dart';
import 'homepage.dart';

class PrticulerImage extends StatefulWidget {
  PrticulerImage({
    Key? key,
    this.product,
  }) : super(key: key);

  productclass? product;

  @override
  State<PrticulerImage> createState() => _PrticulerImageState();
}

class _PrticulerImageState extends State<PrticulerImage> {
  Method ref = Method();

  String? proid;

  late int activeIndex = 0;

  void Share(BuildContext context) async {
    await FlutterShare.share(
      title: "First Product",
      text: "${widget.product!.subcategories}\n Price:-${widget.product!
          .Price}",
      linkUrl: "Photo:${widget.product!.Photo!.first}",
      chooserTitle: "Share This Product",


    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  widget.product!.subcategories!.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black),
                ),
              ),
            ),

            Container(
              child: Text(
                "  Meterial Type:- ${widget.product!.categories!.toString()}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black),
              ),
            ),


            Stack(children: [
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: 350,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index),
                ),
                itemCount: widget.product!.Photo!.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    child:
                    Image.network(widget.product!.Photo![index].toString()),
                  );
                },
              ),


              Container(
                alignment: Alignment.topRight,
                child: IconButton(

                  onPressed: () {
                    Share(context);
                  }, icon: Icon(Icons.share),
                ),
              ),
            ]),
            Center(
              child: Container(
                height: 20,
                child: AnimatedSmoothIndicator(
                  effect: SlideEffect(
                      spacing: 6.0,
                      radius: 4.0,
                      dotWidth: 20.0,
                      dotHeight: 8.0,
                      paintStyle: PaintingStyle.fill,
                      strokeWidth: 1.5,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.indigo
                  ),
                  activeIndex: activeIndex,
                  count: widget.product!.Photo!.length,
                  axisDirection: Axis.horizontal,
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: 300),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  widget.product!.details!.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  "₹ ${widget.product!.Price!}/-",
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.black,
                    fontSize: 18,
                    fontStyle: FontStyle.normal,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),


            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " Discount Price:-${widget.product!.Discountprice!}/-",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            ref.Cartcollection(
                              ProductDiscountPrice:widget.product!.Discountprice.toString(),
                              ProductPhoto:widget.product!.Photo!.first.toString(),
                              Productprice:widget.product!.Price.toString(),
                              ProductName: widget.product!.subcategories.toString(),
                              Productid:widget.product!.productsid.toString(),
                              Productcategory:widget.product!.categories.toString(),



                            ).whenComplete(() =>
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Bottamnavigate(selectedindex: 2,)), (route) => false)
                            );
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Product Add in Cart Successfully",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.grey
                                ),),
                              backgroundColor: Colors.black,

                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )

                        ),
                        label: Text("ADD TO CART"),
                        icon: Icon(CupertinoIcons.cart),
                      ),

                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CartBuyPage(ProductName:widget.product!.subcategories.toString(),
                           ProductPrice:widget.product!.Discountprice.toString(),
                          ProductPhoto: widget.product!.Photo!.first.toString(),
                          )));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )

                        ),
                        label: Text("BUY NOW"),
                        icon: Icon(Icons.flash_on),
                      ),


                    ],
                  ),

                  Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Navigator.pushReplacement(context, MaterialPageRoute(
                          //     builder: (context) => Bottamnavigate(selectedindex: 1,)));

                          ref.Favoritecollection(

                              ProductDiscountPrice:widget.product!.Discountprice.toString(),
                              ProductPhoto:widget.product!.Photo!.first.toString(),
                              Productprice:widget.product!.Price.toString(),
                              ProductName: widget.product!.subcategories.toString(),
                              Productid:widget.product!.productsid.toString(),
                              Productcategory:widget.product!.categories.toString(),
                          ).whenComplete(() =>
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Product Add in Favorite."
                                      " Successfully",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Colors.grey
                                    ),),
                                  backgroundColor: Colors.black,

                                ),
                              )
                          );

                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )

                        ),
                        label: Text("Add Favorite"),
                        icon: Icon(Icons.favorite_border),
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
