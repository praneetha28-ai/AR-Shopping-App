import 'package:flutter/material.dart';
import 'package:furniture/arView.dart';
import 'package:furniture/itemList.dart';
import 'models/itemModel.dart';

class ProductScreen extends StatelessWidget {
  final ItemModel product;
  late List<ItemModel> cart;
  late String email;
  ProductScreen({required this.product, required this.cart, required String email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffDF2E38),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(product.name),
            IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ARViewScreen(itemImg: product.pic)));
            }, icon: Icon(Icons.camera)),
            IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>itemListScreen(cart: cart)));
            }, icon: Icon(Icons.shopping_basket_outlined)),
          ],
        ),
      ),
      body: Container(
        color: Color(0xffDDF7E3),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              color: Color(0xffDDF7E3),
              height: MediaQuery.of(context).size.height*(2/3),
              child: Image.asset(product.pic),
            ),
           SingleChildScrollView(
             physics: ScrollPhysics(),
             child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)
                    ),
                    color: Color(0xffDF2E38),
                  ),
                  height: MediaQuery.of(context).size.height*(1/4.355),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin:EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Price: ${product.price}/-",style: TextStyle(color: Colors.white,fontSize: 20),),
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
                        margin: EdgeInsets.only(right: 275),
                          child: Text(product.name,style: TextStyle(fontSize: 20,color: Colors.white),)),
                      ElevatedButton(
                        onPressed: (){
                            cart.add(product);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Product Added'),
                                  content: Text('Product added successfully to the cart.Check out the cart'),
                                  actions: [
                                    TextButton(
                                      child: Text('OK',style: TextStyle(color: Color(0xffDF2E38)),),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                        },
                        child: Text("Add to cart",style: TextStyle(color: Color(0xffDF2E38)),),style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffDDF7E3)
                      ),)
                    ],
                  ),
                ),
           ),


          ],
        ),
      ),
    );
  }
}