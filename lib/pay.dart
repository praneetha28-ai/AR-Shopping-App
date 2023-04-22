import 'package:flutter/material.dart';
import 'package:furniture/success.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDDF7E3),
      appBar: AppBar(title: Text("Payment Gateway"),backgroundColor: Colors.red,),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Success()));
              },
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Net Banking"),
                    Image.asset("assets/items/paycard.png",width: 100,height: 100,)
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Success()));},
              child: Card(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Credit Card"),
                    Image.asset("assets/items/paycard.png",width: 100,height: 100,)
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Success()));
              },
              child: Card(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Debit Card"),
                    Image.asset("assets/items/paycard.png",width: 100,height: 100,)
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Success()));
              },
              child: Card(

                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Wallet Pay"),
                    Image.asset("assets/items/paycard.png",width: 100,height: 100,)
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
