
import 'package:cloud_firestore/cloud_firestore.dart';

class Categorymodelclass{
   final String? Categaries;
  final String? SubCategaries;
   final String? Image;
   final String? id;

   Categorymodelclass({required this.Categaries,required this.SubCategaries,required this.Image,required this.id});

factory Categorymodelclass.fromJson(DocumentSnapshot json)=> Categorymodelclass(
    Categaries:json["categories"],
    SubCategaries:json["sub categories"],
    Image:json["photo"],
  id: json.id,
);
}
