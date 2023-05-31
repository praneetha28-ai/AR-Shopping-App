import 'dart:io';
import 'package:flutter/material.dart';
import 'package:furniture/product.dart';

class CategoryPage extends StatelessWidget {

  final String username;
  final String email;
  CategoryPage({required this.username,required this.email});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F6F9),
      appBar: AppBar(
        backgroundColor: Color(0xff394867),
        centerTitle: true,
        title: Text('Categories'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        physics: BouncingScrollPhysics(),
        children: [
          _buildCategoryCard(
            context,
            "Tables",
            "assets/images/pngimg.com - table_PNG7006.png",
            Colors.blueGrey.withOpacity(0.2),
          ),
          _buildCategoryCard(
            context,
            "Chairs",
            "assets/images/pngimg.com - chair_PNG6901.png",
            Colors.amber.withOpacity(0.2),
          ),
          _buildCategoryCard(
            context,
            "Sofas",
            "assets/images/pngimg.com - armchair_PNG7025.png",
            Colors.deepPurple.withOpacity(0.2),
          ),
          _buildCategoryCard(
            context,
            "Electronics",
            "assets/images/pngimg.com - headphones_PNG101983.png",
            Colors.green.withOpacity(0.2),
          ),
          _buildCategoryCard(
            context,
            "Shirts",
            "assets/images/pngimg.com - dress_shirt_PNG8081.png",
            Colors.redAccent.withOpacity(0.2),
          ),
          _buildCategoryCard(
            context,
            "T-Shirts",
            "assets/images/pngimg.com - tshirt_PNG5451.png",
            Colors.indigo.withOpacity(0.2),
          ),
          _buildCategoryCard(
            context,
            "Hoodies",
            "assets/images/pngimg.com - hoodie_PNG30.png",
            Colors.brown.withOpacity(0.7),
          ),
          _buildCategoryCard(
            context,
            "Suits",
            "assets/images/pngimg.com - suit_PNG93222.png",
            Colors.teal.withOpacity(0.7),
          ),
          _buildCategoryCard(
            context,
            "Footwear",
            "assets/images/pngimg.com - men_shoes_PNG7475.png",
            Colors.redAccent.withOpacity(0.7),
          ),
          _buildCategoryCard(
            context,
            "Women",
            "assets/dress/womens9.png",
            Colors.deepPurple.withOpacity(0.7),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext ctx,String name, String image, Color overlayColor) {

    return InkWell(
      onTap: (){
        print(name);
        if(name=='Sofas'||name=='Tables'){
          Navigator.of(ctx).push(MaterialPageRoute(builder: (context)=>CatalogScreen(username: username, email: email, cat: 'furniture')));
        }else if(name=='Shirts'||name=='Hoodies'||name=='T-Shirts'||name=='Suits'){
          Navigator.of(ctx).push(MaterialPageRoute(builder: (context)=>CatalogScreen(username: username, email: email, cat: 'men')));
        }else if (name=='Chairs'){
          Navigator.of(ctx).push(MaterialPageRoute(builder: (context)=>CatalogScreen(username: username, email: email, cat: 'chairs')));
        }else if(name=='Electronics'){
          Navigator.of(ctx).push(MaterialPageRoute(builder: (context)=>CatalogScreen(username: username, email: email, cat: 'electronics')));
        }else{Navigator.of(ctx).push(MaterialPageRoute(builder: (context)=>CatalogScreen(username: username, email: email, cat: 'women')));}
      },
      child: Container(
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[400],
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              overlayColor,
              BlendMode.overlay,
            ),
          ),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}