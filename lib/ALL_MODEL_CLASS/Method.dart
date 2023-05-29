import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jewellineadmin/ALL_MODEL_CLASS/Adminshowmodel-class.dart';
import 'package:jewellineadmin/ALL_MODEL_CLASS/CategoryModel-class.dart';
import 'package:jewellineadmin/ALL_MODEL_CLASS/Order-modelclass.dart';
import 'package:jewellineadmin/ALL_MODEL_CLASS/ProductModel-class.dart';
import 'AllLoginUserModel-class.dart';
import 'UserBanner-ModelClass.dart';

class Method {
  final categorycollection = FirebaseFirestore.instance.collection("Categories");
  final productcollection = FirebaseFirestore.instance.collection("Product");
  final Usercollection = FirebaseFirestore.instance.collection("user");
  final Imagecollection = FirebaseFirestore.instance.collection("SingleImage");
  final Admincollection = FirebaseFirestore.instance.collection("Admin");
  final Ordercollection = FirebaseFirestore.instance.collection("Order");


  late DocumentReference _documentReference;
  late Future<DocumentSnapshot> _futureDocument;

  //for single image
  File? image;
  String Singleimage = "";
  Reference? imgstorage;

  //for multiple image
  // String url = "";
  Reference? Storage;
  List<File> imagelist = [];
  String Multipleimage = "";

  //**************************************************************  Ffor multiple image Select methoad *********************************************************************************

  Future<void> selectmultipleImage() async {
    final List<XFile> selectdImage = await ImagePicker().pickMultiImage();
    if (selectdImage != null) {
      selectdImage.forEach((element) {
        imagelist.add(File(element.path));
        print("hii${imagelist}");
      });
    }
  }

  Future<String> uploadFile(File file) async {
    int random = Random().nextInt(10000);
    String imageName = "$random${DateTime.now().microsecondsSinceEpoch}.jpg";
    Storage = FirebaseStorage.instance.ref(imageName);
    await Storage!.putFile(file);
    String url = await Storage!.getDownloadURL();
    return url;
  }

  //**************************************************************  For Add Product Collection In Firebase ********************************************************************************

  Future<bool> multipladata(
      List<String> file,
      String Detailscontroller,
      String selectedcategory,
      String selectedsubcategory,
      String Pricecontroller,
      String Discountprice) async {
    bool productexists =
        await ProductExits(selectedcategory, selectedsubcategory);
    if (productexists) {
      print("This is alredy in database");
      return false;
    }

    await productcollection.add({
      "category": selectedcategory,
      "subcategory": selectedsubcategory,
      "Details": Detailscontroller,
      "Discount": Discountprice,
      "price": Pricecontroller,
      "photo": file,
    }).then((value) => print("Details added"));
    return true;
  }

  //**************************************************************  For Remove Duplicate Product ***************************************************************************************

  Future<bool> ProductExits(
      String selectedCategory, String selectedSubCategory) async {
    QuerySnapshot snapshot = await productcollection
        .where("Category", isEqualTo: selectedCategory)
        .where('Sub-category', isEqualTo: selectedSubCategory)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  //**************************************************************  Ffor Single image Select methoad *************************************************************************************

  Future<void> singleimage() async {
    final XFile? picimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picimage != null) {
      image = File(picimage.path);
      int random = Random().nextInt(10000);
      String Storage = "$random${DateTime.now().microsecondsSinceEpoch}.jpg";
      imgstorage = FirebaseStorage.instance.ref(Storage);
    }
  }

//**************************************************************  For Remove Duplicate Category ***************************************************************************************

  Future<bool> checkdetails(String c1, String s1) async {
    QuerySnapshot snapshot = await categorycollection
        .where("categories", isEqualTo: c1)
        .where("sub categories", isEqualTo: s1)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  //**************************************************************  For Add Category Collection In Firebase ****************************************************************************

  Future<bool> adddata(String c1, String s1) async {
    bool productexists = await checkdetails(c1, s1);
    if (productexists) {
      print("This is alredy in database");
      return false;
    }
    if (imgstorage == null || image == null) {
      print("Image is not found");
      return false;
    }
    await imgstorage!.putFile(image!);
    Singleimage = await imgstorage!.getDownloadURL();
    await categorycollection.add({
      "categories": c1,
      "sub categories": s1,
      "photo": Singleimage
    }).then((value) => print("details added"));
    return true;
  }

//**************************************************************  For User Category Show Method *****************************************************************************************

  Future<List<Categorymodelclass>> logos() async {
    QuerySnapshot response = await categorycollection.get();
    return response.docs.map((e) => Categorymodelclass.fromJson(e)).toList();
  }

  //**************************************************************  For Product Show Method *****************************************************************************************

  Future<List<ProductModelclass>> ShowProduct() async {
    QuerySnapshot response = await productcollection.get();
    return response.docs.map((e) => ProductModelclass.fromJson(e)).toList();
  }

  //**************************************************************  For User Category Show Method *****************************************************************************************

  Future<List<Adminmodelclass>> Adminshow() async {
    QuerySnapshot response = await Admincollection.get();
    return response.docs.map((e) => Adminmodelclass.fromJson(e)).toList();
  }

//**************************************************************  For Login User Show Method *********************************************************************************************

  Future<List<allusermodelclass>> showalluser() async {
    QuerySnapshot show = await Usercollection.get();
    return show.docs.map((e) => allusermodelclass.fromJson(e)).toList();
  }

  //**************************************************************  For Show Banner Method *********************************************************************************************

  Future<List<SingleImage>> showBanner() async {
    QuerySnapshot show = await Imagecollection.get();
    return show.docs.map((e) => SingleImage.fromJson(e)).toList();
  }

//************************************************************************* For Filter Sub Category **************************************************************************************
  Future<List<String?>> SubCategory(String selectedcategory) async {
    List<String?> RemoveDuplicate = [];
    List<Categorymodelclass> list = await logos().then((value) => value.where((element) => element.Categaries == selectedcategory).toList());
    for (int i = 0; i < list.length; i++) {
      RemoveDuplicate.add(list[i].SubCategaries);
    }

    Set<String?> listtoset = RemoveDuplicate.toSet();
    print("hii$listtoset");
    List<String?> settolist = listtoset.toList();
    print("Sub categorylistcategory$settolist");

    return settolist;
  }

  //*********************************************************************** For Filter Category ******************************************************************************************

  Future<List<String?>> Category() async {
    List<String?> RemoveDuplicate = [];
    List<Categorymodelclass> list = await logos();
    for (int i = 0; i < list.length; i++) {
      RemoveDuplicate.add(list[i].Categaries);
    }

    Set<String?> listtoset = RemoveDuplicate.toSet();
    print("categorylist$listtoset");
    List<String?> settolist = listtoset.toList();
    print("categorylistcategory$settolist");

    return settolist;
  }

  Future<void> ImageCollectionAdd() async {
    await imgstorage!.putFile(image!);
    Singleimage = await imgstorage!.getDownloadURL();
    await Imagecollection.add({
      "image": Singleimage,
    });
  }

//**************************************************************  For User Order Show Method *****************************************************************************************

  Future<List<Ordershowmodelclass>> showOrder() async {
    QuerySnapshot showorder = await Ordercollection.get();
    return showorder.docs.map((e) => Ordershowmodelclass.fromJson(e)).toList();
  }

  //************************************************************** Remove Product method ***********************************************************************

  Future<void> RemoveoProduct({required String Id}) async {
    _documentReference = productcollection.doc(Id);
    _futureDocument = _documentReference.get();
    _documentReference.delete().whenComplete(() => print("Product Delete"));
  }

  //************************************************************** Remove Category method ***********************************************************************


  Future<void> RemoveoCategory({required String Id}) async {
    _documentReference = categorycollection.doc(Id);
    _futureDocument = _documentReference.get();
    _documentReference.delete().whenComplete(() => print("Category Delete"));
  }
}



