import 'package:cloud_firestore/cloud_firestore.dart';

class productclass{
  String ? categories;
  String ? subcategories;
  String ? details;
  String ? Price;
  String ? Discountprice;
  List<String> ? Photo;
  String ? productsid;

  productclass({this.categories,this.subcategories,this.details,this.Photo,this.productsid,this.Price,this.Discountprice});

  factory productclass.fromJson(DocumentSnapshot json)=>productclass(
    categories: json["category"],
    subcategories: json["subcategory"],
    details: json["Details"],
    Price: json["price"],
    Discountprice: json["Discount"],
    Photo: List<String>.from(json["photo"]),
    productsid: json.id,
  );
}