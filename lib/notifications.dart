import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xffF1F6F9),appBar: AppBar(title: Text('Notifications'),centerTitle: true,backgroundColor: Color(0xff394867),
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed:(){Navigator.of(context).pop(context);}),),
      body: Center(
          child: Text(
            'You have no New Notifications Yet!',
            style: TextStyle(fontSize: 16),
          )),
    );
  }
}