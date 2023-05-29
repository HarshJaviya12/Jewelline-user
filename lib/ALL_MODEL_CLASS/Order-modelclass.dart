import 'package:cloud_firestore/cloud_firestore.dart';

class Ordershowmodelclass {
  String? UserName;
  String? UserEmail;
  String? UserNumber;
  String? ProductPrice;
  String? ProductPhoto;
  String? ProductName;
  String? Address;
  String? CityName;
  String? StateName;
  String? Pincode;
  String? id;
  String? Userid;
  String? Date;
  String? Status;


  Ordershowmodelclass(
      {this.UserName,
      this.Pincode,
      this.CityName,
      this.StateName,
      this.Address,
      this.ProductPrice,
      this.ProductPhoto,
      this.ProductName,
      this.UserNumber,
      this.UserEmail,
      this.id,
      this.Userid,
      this.Date,
        this.Status,
      });

  factory Ordershowmodelclass.fromJson(DocumentSnapshot json) =>
      Ordershowmodelclass(
        UserName: json["User Name"],
        UserEmail: json["User Email"],
        UserNumber: json["User Number"],
        ProductName: json["Product Name"],
        ProductPhoto: json["Product Photo"],
        ProductPrice: json["Product Price"],
        StateName: json["Statename"],
        CityName: json["CityName"],
        Pincode: json["Pincode"],
        Address: json["Address"],
        Userid: json["Userid"],
        Date: json["Date Time"],
        Status: json["Status"],
        id: json.id,
      );
}
