// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class allusermodelclass{
  final String? Mail;
  final String? Name;
  final String? phonenumber;
  final String? Userid;
  final String? password;
  final String? id;



  allusermodelclass({this.Mail,this.Name,this.phonenumber,this.Userid,required this.password,this.id});

  factory allusermodelclass.fromJson(DocumentSnapshot json) =>allusermodelclass(
    Mail: json['Email'],
    Name: json['Name'],
    phonenumber: json['mobile'],
    Userid: json['User id'],
    password:json["password"],
    id: json.id,
  );

}