import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModelclass {
  String? Name;
  String? Email;
  String? Number;
  String? ProductName;
  String? ProductPrice;
  String? ProductPhoto;
  String? Address;
  String? CityName;
  String? StateName;
  String? Pincode;
  String? id;
  String? Userid;
  String? Status;
  String? PaymentMode;


  OrderModelclass(
      {this.CityName,
      this.ProductPrice,
      this.ProductName,
      this.id,
      this.Address,
      this.Pincode,
      this.ProductPhoto,
      this.StateName,
      this.Email,
      this.Name,
      this.Number,
      this.Userid,
      this.Status});

  factory OrderModelclass.fromJson(DocumentSnapshot json) => OrderModelclass(
        Name: json["User Name"],
        Email: json["User Email"],
        Number: json["User Number"],
        ProductName: json["Product Name"],
        ProductPhoto: json["Product Photo"],
        ProductPrice: json["Product Price"],
        Address: json["Address"],
        StateName: json["Statename"],
        CityName: json["CityName"],
        Pincode: json["Pincode"],
        Status: json["Status"],
        id: json.id,
        Userid: json["Userid"],
      );
}
