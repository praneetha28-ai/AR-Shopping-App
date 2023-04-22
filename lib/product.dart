import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture/itemList.dart';
import 'package:furniture/loginPage.dart';
import 'package:furniture/models/itemModel.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart' as badges;
import 'detail.dart';
import 'models/userModel.dart';

class CatalogScreen extends StatefulWidget {
   String username;
   String email;
   String cat;
  CatalogScreen({required this.username,required this.email,required this.cat});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState(username: username,email: email,cat: cat);
}

class _CatalogScreenState extends State<CatalogScreen> {
   final List<ItemModel> cart=[];
   final String username;
   final String email;
   final String cat;
   _CatalogScreenState({required this.username,required this.email,required this.cat});
   late  int cartItems=0;
   // void initState(){
   //   super.initState();
   //   getCart();
   // }
   // void getCart()async{
   //   int count;
   //   setState(() async {
   //     final QuerySnapshot qSnap = await FirebaseFirestore.instance.collection('users').doc(email).collection("products").get();
   //     final int documents = qSnap.docs.length;
   //     count = await FirebaseFirestore.instance.collection("users").doc(email).collection("products").where("cart",isEqualTo: true).snapshots().length;
   //   });
   //
   // }

  List<ItemModel> products= [
    ItemModel(
      'Double Bed',
      'Double Bed with 2 Lamps',
      'assets/items/bed.png',
      1200,
    ),
    ItemModel(
      'Single Sofa T55',
      'White Sofa For Your Home',
      'assets/items/sofa_white.png',
      16000,
    ),
    ItemModel(
      'Double Sofa ',
      'Three Seater Branded Sofa',
      'assets/items/sofa_yellow.png',
      10000,
    ),
    ItemModel(
      'Chair Brown ',
      'A Small Chair For Your Backyard ',
      'assets/items/pc_table.png',
      6500,
    ),
    ItemModel(
      'G78 Single Sofa',
      'Branded Single Yellow Sofa',
      'assets/items/single_sofa.png',
      8500,
    ),
    ItemModel(
      'Dinner Table',
      'Beautiful Dinner Table For Family',
      'assets/items/dinner_table.png',
      1100,
    ),
    ItemModel(
      'Branded Pc Table',
      'Wooden Branded UK Table',
      'assets/items/pc_table2.png',
      1000,
    ),
    ItemModel(
      'Chair Short',
      'A Small Cheap Chair',
      'assets/items/chair2.png',
      1100,
    ),
    ItemModel(
      'Wooden Table',
      'Wooden Branded UK Table',
      'assets/items/table.png',
      1650,
    ),
    ItemModel(
      'Thai Double Bed',
      'Branded Double Bed With Locker ',
      'assets/items/bed_double.png',
      1200,
    ),

    ItemModel(
      'Rotatable Chair',
      'A Brand New Rotatable Chair',
      'assets/items/rot_chair.png',
      5000,
    ),
    ItemModel(
      'UK5 Sofa',
      'Brand New Single Sofa',
      'assets/items/sofa_uk.png',
      1500,
    ),
    ItemModel(
      'T80 Dinner Table',
      'Beautiful table for Dinner',
      'assets/items/dinner_table2.png',
      1950,
    ),
    ItemModel(
      '2 Seat Sofa',
      'This is branded new Double sofa',
      'assets/items/sofa_yellow.png',
      1568,
    ),
    ItemModel(
      'Grey Sofa',
      'This is a 2 seater and Brand new double sofa',
      'assets/items/sofa_grey.png',
      1569,
    ),
    ItemModel(
      'Brown Chair Y9',
      'A Beautiful chair for sitting',
      'assets/items/chair1.png',
      3650,
    ),
    ItemModel(
      'HU9 Dinner Table',
      'Beautiful Table For Dinner',
      'assets/items/dinner_table3.png',
      2250,
    ),
    ItemModel(
      'Men\'s Watch',
      'Stylish Men\'s Watch',
      'assets/items/watch.png',
      5500,
    ),ItemModel(
      'Men\'s Suit',
      'A decent Men\'s Suit',
      'assets/items/suit.png',
      4500,
    ),ItemModel(
      'Short Frock',
      'This is  a trendy Short Frock',
      'assets/items/dress.png',
      10000,
    ),ItemModel(
      'Women\'s Frock',
      'This is Women\'s Frock',
      'assets/items/woman-clothes.png',
      1200,
    ),
  ];

   final GoogleSignIn googleSignIn = GoogleSignIn();

   void signOutGoogle() async{
     await googleSignIn.signOut();
     final SharedPreferences prefs =await SharedPreferences.getInstance();
     prefs.setBool("logged", false);
     print("User Sign Out");
   }

  @override
  Widget build(BuildContext context) {
    print(widget.username);


    return Scaffold(
      backgroundColor: Color(0xffDDF7E3),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffDF2E38),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // IconButton(onPressed: (){
            //   signOutGoogle();
            //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Login()));
            // }, icon: Icon(Icons.logout)),
            Text("Hello ${widget.username}"),
            InkWell(
              onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>itemListScreen(email: widget.email,)));},
              child: badges.Badge(
                  badgeStyle: badges.BadgeStyle(
                    shape: badges.BadgeShape.circle,
                    badgeColor: Colors.red,
                    padding: EdgeInsets.all(5),
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Colors.white, width: 2),

                  ),
                badgeAnimation:const badges.BadgeAnimation.scale(
                  toAnimate: true,
                  // loopAnimation: true,
                  animationDuration: Duration(seconds: 5)
                ),
                badgeContent: Text(
                 cartItems.toString()
                ),
                child: Icon(Icons.shopping_cart,size: 25,),
              )
            )
          ],
        ),
      ),
      body:StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(widget.email).collection("products").doc("categories").collection(cat).snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }
          return GridView(
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            primary: false,
            shrinkWrap: true,
            children: List<Widget>.generate(
              snapshot.data!.size, // same length as the data
                  (index) => GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>ProductScreen(product: snapshot.data!.docs[index],emailid: widget.email,))
                      );
                    },
                      child: ProductCard(product: snapshot.data!.docs[index])
                  )
            ),
          );
        },
      )
      // GridView.count(
      //   crossAxisCount: 2,
      //   children: List.generate(
      //     products.length,
      //         (index) => GestureDetector(
      //       onTap: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => ProductScreen(
      //               email:user,
      //               product: products[index],
      //               cart: cart,
      //             ),
      //           ),
      //         );
      //       },
      //       child: ProductCard(
      //         product: products[index],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final DocumentSnapshot product;
  ProductCard({required this.product});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      color: Color(0xffFFF4E0),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(product["pic"],width: 100,height: 100,
          ),
          Center(child: Text(product["name"],style: TextStyle(fontSize: 18),)),
        ],
      ),
    );
  }
}

