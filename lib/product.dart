import 'dart:math';

import 'package:flutter/material.dart';
import 'package:furniture/itemList.dart';
import 'package:furniture/models/itemModel.dart';

import 'detail.dart';
import 'models/userModel.dart';

class CatalogScreen extends StatelessWidget {
   String user;
  CatalogScreen({required this.user});
   final List<ItemModel> cart=[];
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
      'HU9 Dinner Table',
      'Beautiful Table For Dinner',
      'assets/items/watch.png',
      5500,
    ),ItemModel(
      'HU9 Dinner Table',
      'Beautiful Table For Dinner',
      'assets/items/suit.png',
      4500,
    ),ItemModel(
      'HU9 Dinner Table',
      'Beautiful Table For Dinner',
      'assets/items/dress.png',
      10000,
    ),ItemModel(
      'HU9 Dinner Table',
      'Beautiful Table For Dinner',
      'assets/items/woman-clothes.png',
      5200,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDDF7E3),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffDF2E38),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Hello ${user}"),
            IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>itemListScreen(cart: cart,)));
            },
                icon: Icon(Icons.shopping_basket_outlined))
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          products.length,
              (index) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductScreen(
                    email:user,
                    product: products[index],
                    cart: cart,
                  ),
                ),
              );
            },
            child: ProductCard(
              product: products[index],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ItemModel product;
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
          Image.asset(product.pic,width: 100,height: 100,
          ),
          Center(child: Text(product.name,style: TextStyle(fontSize: 20),)),
        ],
      ),
    );
  }
}

