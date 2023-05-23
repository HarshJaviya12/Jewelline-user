import 'dart:async';
import 'dart:async';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jewellin_user/All-MODEL-CLASS/CartModel_Class.dart';
import 'package:jewellin_user/All-MODEL-CLASS/Category__model__Class.dart';
import 'package:jewellin_user/All-MODEL-CLASS/Favoritemodel_class.dart';
import 'package:jewellin_user/All-MODEL-CLASS/OrderModel-class.dart';
import 'package:jewellin_user/All-MODEL-CLASS/Singleimage_Model_Class.dart';
import 'package:jewellin_user/Product-Placed-Page.dart';

// import 'OrderModel-class.dart';
import 'Product_Class.dart';
import 'Usermodelclass.dart';

class Method {
  final categorycollection =
      FirebaseFirestore.instance.collection("Categories");
  final productcollection = FirebaseFirestore.instance.collection("Product");
  final cartcollection = FirebaseFirestore.instance.collection("Cart");
  final Usercollection = FirebaseFirestore.instance.collection("user");
  final favoritecollection = FirebaseFirestore.instance.collection("Favorite");
  final SingleImagecollection =
      FirebaseFirestore.instance.collection("SingleImage");
  final Ordercollection = FirebaseFirestore.instance.collection("Order");

  // final UserCollection = FirebaseFirestore.instance.collection("usercollection");

  late DocumentReference _documentReference;
  late Future<DocumentSnapshot> _futureDocument;

//**************************************************************  For Current User Method ***********************************************************************

  Future<List<usermodelclass>> show() async {
    QuerySnapshot Details = await Usercollection.get();
    return Details.docs.map((e) => usermodelclass.fromJson(e)).toList();
  }

  //**************************************************************  For Getting Collection For Category ***********************************************************************

  Future<List<modelclass>> logos() async {
    // print("response${logos()}");
    QuerySnapshot response = await categorycollection.get();
    return response.docs.map((e) => modelclass.fromJson(e)).toList();
  }

  //**************************************************************  For Getting Collection For Cart ***********************************************************************

  Future<List<Cartmodelclass>> cartshow() async {
    QuerySnapshot response = await cartcollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("FinalCartcollection")
        .get();
    return response.docs.map((e) => Cartmodelclass.fromJson(e)).toList();
  }

  //**************************************************************  For Getting Collection For Product ***********************************************************************

  Future<List<productclass>> Product() async {
    QuerySnapshot response = await productcollection.get();
    return response.docs.map((e) => productclass.fromJson(e)).toList();
  }

  //**************************************************************  For Getting Collection For MyOrderShow ***********************************************************************

  Future<List<OrderModelclass>> Ordershow() async {
    QuerySnapshot response = await Ordercollection.get();
    return response.docs.map((e) => OrderModelclass.fromJson(e)).toList();
  }

  //**************************************************************  For Getting Collection For Favorite ***********************************************************************

  Future<List<Favoritemodelclass>> Favoriteshow() async {
    QuerySnapshot response = await favoritecollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("FinalFavoritecollection")
        .get();
    return response.docs.map((e) => Favoritemodelclass.fromJson(e)).toList();
  }

  //**************************************************************  For Getting Single Image ***********************************************************************

  Future<List<SingleImage>> HomeImageShow() async {
    QuerySnapshot response = await SingleImagecollection.get();
    return response.docs.map((e) => SingleImage.fromJson(e)).toList();
  }

  // ******************************************************************* For Filter Product*****************************************************************

  Future<List<String?>> FilterProduct() async {
    List<String?> RemoveDuplicate = [];
    List<productclass> list = await Product();
    for (int i = 0; i < list.length; i++) {
      RemoveDuplicate.add(list[i].categories);
    }

    Set<String?> listtoset = RemoveDuplicate.toSet();
    print("hii$listtoset");
    print("hii$listtoset");
    List<String?> settolist = listtoset.toList();
    return settolist;
  }

//**************************************************************  For removing duplicate category ***********************************************************************

  Future<List<String?>> FilterCategory() async {
    List<String?> removduplicate = [];
    List<modelclass> list = await logos();
    for (int i = 0; i < list.length; i++) {
      removduplicate.add(list[i].Categaries);
    }

    print("object${removduplicate}");

    Set<String?> listtoset = removduplicate.toSet();
    print("hii$listtoset");
    List<String?> settolist = listtoset.toList();
    return settolist;
  }

//**************************************************************  For Add cart ***********************************************************************

  Future<bool> cartadd(String productcategory, String productName) async {
    QuerySnapshot response = await cartcollection
        .where("Category", isEqualTo: productcategory)
        .where("SubCategory", isEqualTo: productName)
        .get();
    return response.docs.isNotEmpty;
  }

  Future<bool> Cartcollection({
      required String ProductName,
      required String ProductDiscountPrice,
      required String ProductPhoto,
      required String Productprice,
      required String Productid,
      required String Productcategory,
      }) async {
    bool cartExists = await cartadd(Productcategory, ProductName);
    if (cartExists) {
      print("Already in cart");
      return false;
    }

    await cartcollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("FinalCartcollection")
        .doc(Productid)
        .set({
      "Category": Productcategory,
      "SubCategory": ProductName,
      "Price": Productprice,
      "Discount": ProductDiscountPrice,
      "Image": ProductPhoto,

    }).then((value) => print("Add in cart"));
    return true;
  }

//**************************************************************  For Add Favorite ***********************************************************************

  Future<bool> favoriteadd(String productName, String productcategory) async {
    QuerySnapshot response = await favoritecollection
        .where("Category", isEqualTo: productcategory)
        .where("SubCategory", isEqualTo: productName)
        .get();
    return response.docs.isNotEmpty;
  }

  Future<bool> Favoritecollection(
      {required String ProductDiscountPrice,
      required String ProductPhoto,
      required String Productprice,
      required String Productid,
      required String Productcategory,
      required String ProductName}) async {
    bool favoriteExists = await favoriteadd(ProductName,Productcategory);
    if (favoriteExists) {
      print("Already in Favorite");
      return false;
    }
    await favoritecollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("FinalFavoritecollection")
        .doc(Productid)
        .set({
      "Category": Productcategory,
      "SubCategory": ProductName,
      "Price": Productprice,
      "Discount": ProductDiscountPrice,
      "Image": ProductPhoto,

    }).then((value) => print("Add in Favorite"));
    return true;
  }

//**************************************************************  For Remove cart method ***********************************************************************

  Future<void> Removedatafromcart({required String id}) async {
    _documentReference = cartcollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("FinalCartcollection")
        .doc(id);
    _futureDocument = _documentReference.get();
    _documentReference
        .delete()
        .whenComplete(() => print("Product Delete from cart"));
  }

//************************************************************** Remove From Favorite method ***********************************************************************

  Future<void> RemovedatafromFavorite({required String id}) async {
    _documentReference = favoritecollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("FinalFavoritecollection")
        .doc(id);
    _futureDocument = _documentReference.get();
    _documentReference
        .delete()
        .whenComplete(() => print("Product Delete from favorite"));
  }

  //************************************************************** Remove Order method ***********************************************************************


  Future<void> Removeorder({required String id}) async {
    _documentReference = Ordercollection.doc(id);
    _futureDocument = _documentReference.get();
    _documentReference.delete().whenComplete(() => print("Canceled Order"));
  }

//**************************************************************  For Add Payment***********************************************************************

  Future<bool> OrderPayment(
    String UserName,
    String UserEmail,
    String UserNumber,
    String ProductPrice,
    String ProductName,
    String ProductPhoto,
    String Address,
    String CityName,
    String StateName,
    String Pincode,
    String Cardcontroller,
    String Cvvcontroller,
    String Expirycontroller, String payment,

  ) async {
    await Ordercollection.add({
      "User Name": UserName,
      "User Email": UserEmail,
      "User Number": UserNumber,
      "Product Name": ProductName,
      "Product Photo": ProductPhoto,
      "Product Price": ProductPrice,
      "Address": Address,
      "Statename": StateName,
      "CityName": CityName,
      "Pincode": Pincode,
      "Card Number": Cardcontroller,
      "Cvv Number": Cvvcontroller,
      "Last Date": Expirycontroller,
      "Status": null,
      "Date Time":DateTime.now().toString(),
      "Payment Mode":payment,

      "Userid": FirebaseAuth.instance.currentUser!.uid
    }).then((value) => print("Details added"));
    return true;
  }
}
