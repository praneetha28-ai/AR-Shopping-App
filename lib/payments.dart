import 'package:flutter/material.dart';

import 'bank.dart';

class payment extends StatefulWidget {
  const payment({super.key});

  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 166, 211, 167),
      appBar: AppBar(

        title: Text('Select Payment Option'),
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Net Banking",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                height: 50,
                width: 500,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Netbanking()));
            },
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Debit/Credit Card",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                height: 50,
                width: 500,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Netbanking()));
            },
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "UPI",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                height: 50,
                width: 500,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Netbanking()));
            },
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Wallet",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                height: 50,
                width: 500,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Netbanking()));
            },
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Cash on Delivery",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                height: 50,
                width: 500,
              ),
            ),
            onTap: () {
              showGeneralDialog(
                context: context,
                barrierLabel: "Barrier",
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.5),
                transitionDuration: Duration(milliseconds: 700),
                pageBuilder: (_, __, ___) {
                  return Center(
                    child: Container(
                      height: 240,
                      child: SizedBox.expand(
                        child: Column(
                          children: [
                            Image.asset(
                              'sssets/items/done.jfif',
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40)),
                    ),
                  );
                },
                transitionBuilder: (_, anim, __, child) {
                  Tween<Offset> tween;
                  if (anim.status == AnimationStatus.reverse) {
                    tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
                  } else {
                    tween = Tween(begin: Offset(1, 0), end: Offset.zero);
                  }

                  return SlideTransition(
                    position: tween.animate(anim),
                    child: FadeTransition(
                      opacity: anim,
                      child: child,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // Netbanking() {
  //   return Scaffold(
  //     backgroundColor: const Color.fromARGB(255, 152, 194, 154),
  //     body: Column(
  //       children: [
  //         ListTile(
  //           leading: Radio(
  //               value: 'xyz',
  //               groupValue: 'groupValue',
  //               onChanged: (xyz) {
  //                 setState(() {});
  //               }),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
