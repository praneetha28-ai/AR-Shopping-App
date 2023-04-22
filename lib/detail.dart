import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture/arView.dart';
import 'package:furniture/itemList.dart';
import 'models/itemModel.dart';

class ProductScreen extends StatelessWidget {
  // final ItemModel product;
  // late List<ItemModel> cart;
  final String emailid;
  final DocumentSnapshot product;
  ProductScreen({required this.product,required this.emailid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffDF2E38),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(product["name"]),
            IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>itemListScreen(email: emailid,)));
            }, icon: Icon(Icons.shopping_cart)),
          ],
        ),
      ),
      body: Container(
        color: Color(0xffDDF7E3),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color(0xffDDF7E3),
                height: MediaQuery.of(context).size.height*(1/2),
                child: Image.asset(product["pic"]),
              ),
             SingleChildScrollView(
               // physics: ScrollPhysics(),
               child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)
                      ),
                      color: Color(0xffDF2E38),
                    ),
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/8),
                    height: MediaQuery.of(context).size.height*(1/3),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin:EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Price: ${product["price"]}/-",style: TextStyle(color: Colors.white,fontSize: 20),),
                              Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.star,color: Colors.yellow,),
                                    Icon(Icons.star,color: Colors.yellow,),
                                    Icon(Icons.star),
                                    Icon(Icons.star),
                                    Icon(Icons.star),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 200),
                            child: Text(product["detail"],style: TextStyle(fontSize: 20,color: Colors.white),)),
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context)=>ARViewScreen(itemImg: product["pic"]))
                                );
                              },
                              child: Text("Try it with your camera",style: TextStyle(color: Color(0xffDF2E38)),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffDDF7E3)
                              ),),
                            ElevatedButton(
                              onPressed: (){
                                // print(product.id);
                                // FirebaseFirestore.instance.collection("users").doc(emailid).collection("products").doc(product.id).
                                // update({
                                //   "cart":true
                                // }
                                // );
                                //   // cart.add(product);
                                //   showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return AlertDialog(
                                //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                //         backgroundColor: Color(0xffFFF4E0),
                                //         title: Text('Product Added'),
                                //         content: Text('Product added successfully to the cart.Check out the cart'),
                                //         actions: [
                                //           TextButton(
                                //             child: Text('Go to cart',style: TextStyle(color: Color(0xffDF2E38)),),
                                //             onPressed: () {
                                //               Navigator.of(context).pop();
                                //               Navigator.of(context).push(MaterialPageRoute(
                                //                   builder: (context)=>itemListScreen(email: emailid)));
                                //               // Navigator.of(context).pop();
                                //             },
                                //           ),
                                //           TextButton(
                                //             child: Text('Continue Shopping',style: TextStyle(color: Color(0xffDF2E38)),),
                                //             onPressed: () {
                                //               Navigator.of(context).pop();
                                //             },
                                //           ),
                                //         ],
                                //       );
                                //     },
                                //   );
                              },
                              child: Text("Add to cart",style: TextStyle(color: Color(0xffDF2E38)),),
                              style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffDDF7E3)
                            ),),

                          ],
                        )
                      ],
                    ),
                  ),
             ),
            ],
          ),
        ),
      ),
    );
  }
}