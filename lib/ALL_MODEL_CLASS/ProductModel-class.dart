import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModelclass{
  String? ProductName;
  String? ProductPrice;
  String? ProductDiscountPrice;
  String? ProductCategory;
  String? ProductDetails;
  String? id;
  List<String> ? ProductImage;


  ProductModelclass({this.ProductPrice,this.ProductName,this.ProductDiscountPrice,this.ProductCategory,this.ProductImage,this.ProductDetails,this.id});

  factory ProductModelclass.fromJson(DocumentSnapshot json)=> ProductModelclass(
    ProductName: json["subcategory"],
    ProductPrice: json["price"],
    ProductCategory: json["category"],
    ProductDiscountPrice: json["Discount"],
    ProductImage:List<String>.from(json["photo"]),
    ProductDetails: json["Details"],
    id: json.id,
  );


}