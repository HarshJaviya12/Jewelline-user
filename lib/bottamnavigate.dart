import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jewellin_user/All-MODEL-CLASS/MethodClass.dart';
import 'Account.dart';
import 'All-MODEL-CLASS/CartModel_Class.dart';
import 'Favorite.dart';
import 'Mycart.dart';
import 'homepage.dart';

class Bottamnavigate extends StatefulWidget {
  int ? selectedindex = 0;

   Bottamnavigate({Key? key,this.selectedindex}) : super(key: key);


  @override
  State<Bottamnavigate> createState() => _BottamnavigateState();
}

class _BottamnavigateState extends State<Bottamnavigate> {

  Method ref=Method();

  List<Widget> widgetsPage = [
    const homepage(),
    Favorite(),
    const mycart(),
    Account(),
  ];

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit the app?'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: Text('No',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: Text('Yes',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    )) ??
        false;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.indigo,
          unselectedItemColor: Colors.grey,
          currentIndex: widget.selectedindex!.toInt(),
          onTap: (value) {
            widget.selectedindex = value;
            setState(() {

            });
          },



          items: [
            const BottomNavigationBarItem(
                backgroundColor: Colors.white70,
                label: "Home",
                icon: Icon(Icons.home)
            ),

            const BottomNavigationBarItem(
                backgroundColor: Colors.white70,
                label: "Favorite",
                icon: Icon(Icons.favorite)
            ),

            BottomNavigationBarItem(
                backgroundColor: Colors.white70,
                label: "My Cart",
                icon: Badge(
                    label: FutureBuilder<List<Cartmodelclass>>(
                future: ref.cartshow(),
              builder: (context, snapshot) {
                print("data${snapshot.error}");
                if (snapshot.hasData) {
                  return Text(snapshot.data!.length.toString(),style: TextStyle(color: Colors.black),);

                }
                return Text("0",style: TextStyle(color: Colors.orangeAccent),
                );
              },
            ),

                    child: Icon(CupertinoIcons.cart))
            ),

            BottomNavigationBarItem(
                backgroundColor: Colors.white70,
                label: "Account",
                icon: Icon(Icons.person_outline_outlined)
            ),
          ],

        ),
        body: widgetsPage.elementAt(widget.selectedindex!.toInt()),


      ),
    );
  }
}
