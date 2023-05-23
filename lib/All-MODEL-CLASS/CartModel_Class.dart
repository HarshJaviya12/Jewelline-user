


import 'package:cloud_firestore/cloud_firestore.dart';

class Cartmodelclass{


  String ? category;
  String ? subcategory;
  String ? price;
  String ? discount;
  String ? id;
  String ? photo;

  Cartmodelclass({this.category,this.discount,this.photo,this.price,this.subcategory,this.id});

  factory Cartmodelclass.fromJson(DocumentSnapshot json)=> Cartmodelclass(
    category: json["Category"],
    subcategory: json["SubCategory"],
    discount: json["Discount"],
    photo: json["Image"],
    price: json["Price"],
    id: json.id
  );
}