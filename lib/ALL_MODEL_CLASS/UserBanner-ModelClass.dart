
import 'package:cloud_firestore/cloud_firestore.dart';

class SingleImage{
  String? Image;
  String? id;


  SingleImage({this.Image,this.id});

  factory SingleImage.fromJson(DocumentSnapshot json)=> SingleImage(
    Image:json["image"],
    id: json.id,
  );
}
