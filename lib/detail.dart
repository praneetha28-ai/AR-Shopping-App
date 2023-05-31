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
        backgroundColor: Color(0xff394867),
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        },icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,),),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(product["name"],style: TextStyle(color: Colors.white),),
            IconButton(
                onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>itemListScreen(email: emailid,)));
            }, icon: Icon(Icons.shopping_cart_outlined,color: Colors.white,)),
          ],
        ),
      ),
      body: Container(
        color: Color(0xffF1F6F9),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color(0xffF1F6F9),
                height: MediaQuery.of(context).size.height*(1/2),
                child: Image.asset(product["pic"],width: 290,height: 290,),
              ),
             SingleChildScrollView(
               physics: ScrollPhysics(),
               child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),

                      ),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.5),
                      //     blurRadius: 0.5,
                      //     spreadRadius: 0,
                      //     offset: Offset(0,3)
                      //   )
                      // ],
                      color: Color(0xff394867),
                    ),
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/12),
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
                              Text("Price: ${product["price"]}/-",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
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
                          margin: EdgeInsets.only(right: 100),
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
                              child: Text("Try it with your camera",style: TextStyle(color: Color(0xff394867)),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffF1F6F9)
                              ),),
                            ElevatedButton(
                              onPressed: (){
                                FirebaseFirestore.instance.collection("users").doc(emailid).collection("products").doc("categories").collection("chairs").doc(product.id).
                                update(
                                    {
                                      'cart':true
                                    });
                                if(product["cart"]!=true){
                                  FirebaseFirestore.instance.collection("users").doc(emailid).collection("products").
                                  doc("categories").collection("cart").add(
                                      {
                                        'name': product["name"],
                                        'detail': product["detail"],
                                        'pic': product["pic"],
                                        'price': product["price"],
                                        'cart': true
                                      }
                                  ).then((value) => print("added"));
                                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Color(0xffF1F6F9),
                          title: Text('Product Added'),
                          content: Text('Product added successfully to the cart.Check out the cart'),
                          actions: [
                            TextButton(
                              child: Text('Go to cart',style: TextStyle(color: Color(0xff394867)),),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context)=>itemListScreen(email: emailid)));
                                // Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Continue Shopping',style: TextStyle(color: Color(0xff394867)),),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                                }
                                else{
                                  print("product already added");
                                }
                                // print(product.id);
                                // FirebaseFirestore.instance.collection("users").doc(emailid).collection("products").doc(product.id).
                                // update({
                                //   "cart":true
                                // }
                                // );
                                //   // cart.add(product);

                              },
                              child: Text("Add to cart",style: TextStyle(color: Color(0xff394867)),),
                              style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffF1F6F9)
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





//
// class ProductScreen extends StatefulWidget {
//   final String emailid;
//   final DocumentSnapshot product;
//   ProductScreen({required this.product,required this.emailid});
//
//   @override
//   State<ProductScreen> createState() => _ProductScreenState(emailid: emailid,product: product);
// }
//
// class _ProductScreenState extends State<ProductScreen> {
//
//   final String emailid;
//   final DocumentSnapshot product;
//   _ProductScreenState({required this.product,required this.emailid});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white12,
//         elevation: 0,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(product["name"],style: TextStyle(color: Colors.black),),
//             Icon(Icons.favorite_border_outlined, color: Colors.black),
//           ],
//         ),
//         leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: Icon(
//               Icons.arrow_back_ios_new,
//               color: Colors.black,
//             )),
//         // actions: [
//         //   Icon(Icons.favorite_border_outlined, color: Colors.black),
//         // ],
//       ),
//       body: Center(
//         child: Container(
//           margin: EdgeInsets.all(15),
//           child: Column(
//             children: [
//               Container(
//                 height: 400,
//                 width: 300,
//                 // child: Text('Product'),
//                 child: Image.asset(
//                   product["pic"],
//                   height: 40,
//                   width: 40,
//                 ),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   // color: Colors.green,
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     product["name"],
//                     style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
//                   ),
//                   // SizedBox(width: 300),
//                   Text(product["price"].toString(),
//                       style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10))
//                 ],
//               ),
//               Text(
//                 product["detail"]
//                   ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                       onPressed: () {}, child: Text('Try with camera')),
//                   ElevatedButton(
//                       onPressed: () {
//                     FirebaseFirestore.instance.collection("users").doc(emailid).collection("products").doc("categories").collection("chairs").doc(product.id).
//                     update(
//                         {
//                           'cart':true
//                         });
//                     if(product["cart"]!=true){
//                       FirebaseFirestore.instance.collection("users").doc(emailid).collection("products").
//                       doc("categories").collection("cart").add(
//                           {
//                             'name': product["name"],
//                             'detail': product["detail"],
//                             'pic': product["pic"],
//                             'price': product["price"],
//                             'cart': true
//                           }
//                       ).then((value) => print("added"));
//
//                     }
//                     else{
//                       print("product already added");
//                     }
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                           backgroundColor: Color(0xffFFF4E0),
//                           title: Text('Product Added'),
//                           content: Text('Product added successfully to the cart.Check out the cart'),
//                           actions: [
//                             TextButton(
//                               child: Text('Go to cart',style: TextStyle(color: Color(0xffDF2E38)),),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context)=>itemListScreen(email: emailid)));
//                                 // Navigator.of(context).pop();
//                               },
//                             ),
//                             TextButton(
//                               child: Text('Continue Shopping',style: TextStyle(color: Color(0xffDF2E38)),),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   }, child: Text('Add to Cart'))
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
