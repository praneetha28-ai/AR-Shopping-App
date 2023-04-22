import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:furniture/loginPage.dart';
import 'package:furniture/product.dart';
import 'package:furniture/signupPage.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:flutter/src/material/icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'categories.dart';

class MyliquidSwipe extends StatefulWidget {

  @override
  State<MyliquidSwipe> createState() => _MyliquidSwipeState();
}

class _MyliquidSwipeState extends State<MyliquidSwipe> {
  late bool isLogged;
  late String name;
  late String email;
  @override
  void initState(){
    super.initState();
    prefer();
  }
  void prefer() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isLogged = preferences.getBool("logged")??false;
    name = preferences.getString("username")!;
    email = preferences.getString("email")!;
  }

  late User user;
  @override
  Widget build(BuildContext context) {
    final page = [
      Container(
        color: Colors.red,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/items/augmented-reality.png",),
              SizedBox(height: 50,),
              Container(
                margin: EdgeInsets.all(8),
                child: AnimatedTextKit(
                  repeatForever: false,
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TyperAnimatedText("Revolutionize your shopping experience with AR!",textStyle: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.w600),)
                  ],),
              ),
            ],
          )

      ),
      Container(
        color: Colors.green,
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [

                  Container(
                    // color: Colors.blue,
                      height: MediaQuery.of(context).size.height/2,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset("assets/items/shop.webp",width: MediaQuery.of(context).size.width,)),
                  SizedBox(height: 50,),
                  AnimatedTextKit(
                    isRepeatingAnimation: false,
                      animatedTexts:[
                        TypewriterAnimatedText(
                          "Go CRAZY with our AR Shopping !!",
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 25
                          )
                          )

                      ]
                  ),
            ]
            ),

        ),
      ),
      Container(
          color: Colors.yellow,
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Image.asset("assets/items/ar4.webp",),
                    SizedBox(height: 50,),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        "Experience the Augmented Reality by selecting the product and clicking on try with the camera button.Rotate your mobile to locate the object.",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
              ]),
          )
    )
    ];
    return  Scaffold(
        body:
            LiquidSwipe(
              enableLoop: false,
              pages: page,
              slideIconWidget: Icon(Icons.arrow_back_ios),
            ),
           floatingActionButton: FloatingActionButton(
             backgroundColor: Colors.blue[100],
             onPressed: (){
               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>isLogged?CategoryScreen(useraname: name,email: email,):Login()));
             },
             child: Icon(Icons.skip_next,color: Colors.black,),
           ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
  }
}