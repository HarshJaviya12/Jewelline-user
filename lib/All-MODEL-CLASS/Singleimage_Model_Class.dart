
import 'package:cloud_firestore/cloud_firestore.dart';

class SingleImage{
  String? Image;

  SingleImage({this.Image});

  factory SingleImage.fromJson(DocumentSnapshot json)=> SingleImage(
    Image:json["image"],
  );
}
