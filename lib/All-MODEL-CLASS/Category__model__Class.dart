import 'package:cloud_firestore/cloud_firestore.dart';

class modelclass{
  final String? Categaries;
  final String? SubCategaries;
  final String? Image;

  modelclass({required this.Categaries,required this.SubCategaries,required this.Image});

  factory modelclass.fromJson(DocumentSnapshot json)=> modelclass(
    Categaries:json["categories"],
    SubCategaries:json["sub categories"],
    Image:json["photo"],
  );
}