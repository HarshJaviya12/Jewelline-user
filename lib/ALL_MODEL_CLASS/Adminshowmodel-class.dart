import 'package:cloud_firestore/cloud_firestore.dart';


class Adminmodelclass {
  String? Email;
  String? Name;
  String? Number;
  String? Uid;
  String? Password;


  Adminmodelclass({this.Email, this.Name, this.Number,this.Uid,this.Password});

  factory Adminmodelclass.fromJson(DocumentSnapshot json) => Adminmodelclass(
    Email: json["Email"],
    Name: json["Name"],
    Number: json["mobile"],
    Password:json["password"],
  );

}
