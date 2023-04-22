import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:furniture/arView.dart';
import 'package:furniture/categories.dart';
import 'package:furniture/product.dart';
import 'package:furniture/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  print('ARCORE IS AVAILABLE?');
  print(await ArCoreController.checkArCoreAvailability());
  print('\nAR SERVICES INSTALLED?');
  print(await ArCoreController.checkIsArCoreInstalled());
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool loggedIn = prefs.getBool("logged")??false;
  final String uname=prefs.getString("username")??"";
  final String email = prefs.getString("email")??"";
  await Firebase.initializeApp();
  runApp( MyApp(isLogged: loggedIn,username: uname,email: email,));
}

class MyApp extends StatelessWidget {
  late bool isLogged;
  late String username;
  late String email;
  MyApp({super.key,required this.isLogged,required this.username,required this.email});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(username);
    print(email);
    return MaterialApp(
      title: 'Arena',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  isLogged?CategoryScreen(useraname: username, email: email):AnimatedSplashScreen(
          splash: Image.asset(
            'assets/images/logo.png',
            width: 200,
            height: 200,
          ),
          animationDuration: Duration(seconds: 3),
          splashTransition: SplashTransition.scaleTransition,
          nextScreen: MyliquidSwipe()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>(ARViewScreen(itemImg: 'assets/items/chair2.png',)))
              );
            },
                child: Text("Show ar"))
          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
