


import 'package:cloud_firestore/cloud_firestore.dart';

class Favoritemodelclass{


  String ? category;
  String ? subcategory;
  String ? price;
  String ? discount;
  String ? photo;
  String ? id;


  Favoritemodelclass({this.category,this.discount,this.photo,this.price,this.subcategory,this.id});

  factory Favoritemodelclass.fromJson(DocumentSnapshot json)=> Favoritemodelclass(
    category: json["Category"],
    subcategory: json["SubCategory"],
    discount: json["Discount"],
    photo: json["Image"],
    price: json["Price"],
    id: json.id,
  );
}