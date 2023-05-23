import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jewellin_user/Account.dart';

class usermodelclass {
  String? Email;
  String? Name;
  String? mobile;
  String? Uid;
  String? password;
  String? id;


  usermodelclass({this.Email, this.Name, this.mobile,this.Uid,this.password,this.id});

  factory usermodelclass.fromJson(DocumentSnapshot json) => usermodelclass(
        Email: json["Email"],
        Name: json["Name"],
        mobile: json["mobile"],
    Uid: json["User id"],
      password:json["password"],
    id: json.id,
      );
}
