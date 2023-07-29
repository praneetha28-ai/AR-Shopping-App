import 'payments.dart';
import 'package:flutter/material.dart';

class Netbanking extends StatefulWidget {
  const Netbanking({super.key});

  @override
  State<Netbanking> createState() => _NetbankingState();
}

class _NetbankingState extends State<Netbanking> {
  @override
  Widget build(BuildContext context) {
    String value = "group";
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 154, 184, 155),
      appBar: AppBar(
        title: Text('Select bank'),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => payment()));
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          ListTile(
              leading: Radio(
                activeColor: Colors.red,
                  value: 'xyz',
                  groupValue:value,
                  onChanged: (xyz) {
                    value=xyz!;
                  }),
              title: Text("HDFC")),
          ListTile(
              leading: Radio(

                  activeColor: Colors.red,
                  value: 'xyz',
                  groupValue: 'groupValue',
                  onChanged: (xyz) {
                    setState(() {});
                  }),
              title: Text("SBI")),
          ListTile(
              leading: Radio(
                  value: 'xyz',
                  groupValue: 'groupValue',
                  onChanged: (xyz) {
                    setState(() {});
                  }),
              title: Text("ICICI")),
          ListTile(
              leading: Radio(
                  value: 'xyz',
                  groupValue: 'groupValue',
                  onChanged: (xyz) {
                    setState(() {});
                  }),
              title: Text("Kotak")),
        ],
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Text('Pay'),
        backgroundColor: Colors.red,
        onPressed: () {
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
                    child: Center(
                     child:
                        Image.asset(
                          'assets/items/done.jfif',
                          height: 50,
                        ),

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
    );
  }
}
