import 'package:flutter/material.dart';
import 'package:furniture/ExtraScreens/success.dart';
import 'package:furniture/PaymentScreen/thanku_page.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F6F9),appBar: AppBar(title: Text('Select Payment Method'),centerTitle: true,backgroundColor: Color(0xff394867),
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed:(){Navigator.of(context).pop(context);}),),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ThankYouPage(title: 'ThankYou')));
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
              onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ThankYouPage(title: 'ThankYou')));},
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ThankYouPage(title: 'ThankYou')));
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ThankYouPage(title: 'ThankYou')));
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
