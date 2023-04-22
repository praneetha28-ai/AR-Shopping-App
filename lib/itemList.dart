import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:furniture/pay.dart';
import 'package:furniture/payments.dart';

import 'arView.dart';
import 'package:flutter/material.dart';

import 'models/itemModel.dart';
class itemListScreen extends StatefulWidget {
  // late List<ItemModel> cart;
  final String email;
  itemListScreen({required this.email});

  @override
  State<itemListScreen> createState() => _itemListScreenState(email: email);
}

class _itemListScreenState extends State<itemListScreen> {
  // final List<ItemModel> cart;
  final String email;
  _itemListScreenState({required this.email});
  List<ItemModel> items= [
    ItemModel(
      'Double Bed',
      'Double Bed with 2 Lamps',
      'assets/items/bed.png',
      15000,
    ),
    ItemModel(
      'Single Sofa T55',
      'White Sofa For Your Home',
      'assets/items/sofa_white.png',
      5000,
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
      4000,
    ),
    ItemModel(
      'G78 Single Sofa',
      'Branded Single Yellow Sofa',
      'assets/items/single_sofa.png',
      1500,
    ),
    ItemModel(
      'Dinner Table',
      'Beautiful Dinner Table For Family',
      'assets/items/dinner_table.png',
      1200,
    ),
    ItemModel(
      'Branded Pc Table',
      'Wooden Branded UK Table',
      'assets/items/pc_table2.png',
      10000,
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
      1600,
    ),
    ItemModel(
      'Thai Double Bed',
      'Branded Double Bed With Locker ',
      'assets/items/bed_double.png',
      1000,
    ),

    ItemModel(
      'Rotatable Chair',
      'A Brand New Rotatable Chair',
      'assets/items/rot_chair.png',
      10000,
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
      15000,
    ),
    ItemModel(
      '2 Seat Sofa',
      'This is branded new Double sofa',
      'assets/items/sofa_yellow.png',
      1500,
    ),
    ItemModel(
      'Grey Sofa',
      'This is a 2 seater and Brand new double sofa',
      'assets/items/sofa_grey.png',
      1200,
    ),
    ItemModel(
      'Brown Chair Y9',
      'A Beautiful chair for sitting',
      'assets/items/chair1.png',
      15000,
    ),
    ItemModel(
      'HU9 Dinner Table',
      'Beautiful Table For Dinner',
      'assets/items/dinner_table3.png',
      12000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        body:SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                  children: <Widget>[
                    Text('MY CART  ', style: TextStyle(fontSize: 35, color: Colors.white),),
                    // Text('Before You BUY', style: TextStyle(fontSize: 35, color: Colors.white ),),

                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Container(
                    padding: EdgeInsets.only(left:20,right:20,top:6),
                    decoration: BoxDecoration(
                      color: Color(0xffFFF4E0),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)
                      ),
                    ),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("users").doc(email).collection("products").where("cart",isEqualTo: true).snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.hasError){
                          return Container(
                              padding: EdgeInsets.only(left:20,right:20,top:6),
                              child: CircularProgressIndicator());
                        }
                        else {
                          if(!snapshot.hasData){
                            return Container(
                              width: MediaQuery.of(context).size.width,
                                // padding: EdgeInsets.only(left:20,right:20,top:6),
                                child: CircularProgressIndicator()
                            );
                          }
                          return ListView.separated(
                            itemBuilder: (BuildContext, int index) {
                              final prod = snapshot.data!.docs[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context, MaterialPageRoute(
                                    builder: (context) =>
                                        ARViewScreen(
                                          itemImg: prod["pic"],
                                        ),
                                  ),
                                  );
                                },
                                child: Slidable(
                                  endActionPane: ActionPane(
                                    motion: StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (conte) {
                                          showDialog(context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(10)),
                                                  backgroundColor: Color(
                                                      0xffFFF4E0),
                                                  content: Text(
                                                      "Remove the item from cart"),
                                                  actions: [
                                                    TextButton(onPressed: () {
                                                      FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(email)
                                                          .collection(
                                                          "products").doc(
                                                          prod.id)
                                                          .update({
                                                        "cart": false
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                        child: Text(
                                                          "Yes, Remove",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .red),)),
                                                    TextButton(onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                        child: Text(
                                                          "No, Keep it",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .red),)),
                                                  ],
                                                );
                                              }
                                          );
                                          // cart.removeAt(index);
                                        },
                                        icon: Icons.delete,
                                        backgroundColor: Colors.red,
                                        borderRadius: BorderRadius.circular(12),
                                      )
                                    ],
                                  ),
                                  child: Container(
                                    color: Color(0xffFFF4E0),
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: Image.asset(
                                            "${prod["pic"]}", width: 60,),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Text(prod["name"],
                                                style: TextStyle(fontSize: 16,
                                                    color: Colors.black),),
                                              Text(prod["detail"],
                                                style: TextStyle(fontSize: 10,
                                                    color: Colors.black87),),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 60,
                                          child: Text(prod["price"].toString(),
                                            style: TextStyle(fontSize: 14,
                                                color: Colors.red),),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context,
                                int index) => Divider(),
                            itemCount: snapshot.data!.size,
                          );
                        }
                      }
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white
                ),
                  onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Payment()));
                  }, child: Text("Proceed to checkout",style: TextStyle(color: Colors.red),))
            ],
          ),
        )
    );
  }
}
