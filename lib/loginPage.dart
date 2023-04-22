import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture/product.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SignupPage.dart';
import 'categories.dart';
import 'models/itemModel.dart';


class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);
  @override
  _Login createState()=>_Login();
}
class _Login extends State<Login>{
  final _formKey = GlobalKey<FormState>();
  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  // function to implement the google signin

  List<ItemModel> classChairs=[
    ItemModel("Chair 1", "Blue chair", 'assets/chairs/class/chair1.png', 800),
    ItemModel("Chair 2", "Blue chair", 'assets/chairs/class/chair2.png', 800),
    ItemModel("Chair 3", "Blue chair", 'assets/chairs/class/chair3.png', 800),
    ItemModel("Chair 4", "Blue chair", 'assets/chairs/class/chair4.png', 800),
    ItemModel("Chair 5", "Blue chair", 'assets/chairs/class/chair5.png', 800),
    ItemModel("Chair 6", "Blue chair", 'assets/chairs/class/chair6.png', 800),
    ItemModel("Chair 7", "Blue chair", 'assets/chairs/class/chair7.png', 800),
    ItemModel("Chair 8", "Blue chair", 'assets/chairs/class/chair8.png', 800),
    ItemModel("Chair 9", "Blue chair", 'assets/chairs/class/chair9.png', 800),
    ItemModel("Chair 10", "Blue chair", 'assets/chairs/class/chair10.png', 800),
  ];
  List<ItemModel> officeChairs=[
    ItemModel("Office Chair 1", "Best office chair", 'assets/chairs/office/chair11.png', 750),
    ItemModel("Office Chair 1", "Best office chair", 'assets/chairs/office/chair12.png', 750),
    ItemModel("Office Chair 1", "Best office chair", 'assets/chairs/office/chair13.png', 750),
    ItemModel("Office Chair 1", "Best office chair", 'assets/chairs/office/chair14.png', 750),
    ItemModel("Office Chair 1", "Best office chair", 'assets/chairs/office/chair15.png', 750),
    ItemModel("Office Chair 1", "Best office chair", 'assets/chairs/office/chair16.png', 750),
    ItemModel("Office Chair 1", "Best office chair", 'assets/chairs/office/chair17.png', 750),
    ItemModel("Office Chair 1", "Best office chair", 'assets/chairs/office/chair18.png', 750),
    ItemModel("Office Chair 1", "Best office chair", 'assets/chairs/office/chair19.png', 750),
    ItemModel("Office Chair 1", "Best office chair", 'assets/chairs/office/chair20.png', 750),
  ];
  List<ItemModel> dress=[
    ItemModel("Men's dress", "This is stylish shirt", 'assets/dress/mens1.png', 850),
    ItemModel("Men's dress", "This is stylish shirt", 'assets/dress/mens2.png', 850),
    ItemModel("Men's dress", "This is stylish shirt", 'assets/dress/mens3.png', 850),
    ItemModel("Men's dress", "This is stylish shirt", 'assets/dress/mens4.png', 850),
    ItemModel("Men's dress", "This is stylish shirt", 'assets/dress/mens5.png', 850),
    ItemModel("Men's dress", "This is stylish shirt", 'assets/dress/mens6.png', 850),
    ItemModel("Men's dress", "This is stylish shirt", 'assets/dress/mens7.png', 850),
    ItemModel("Men's dress", "This is stylish shirt", 'assets/dress/mens8.png', 850),
    ItemModel("Men's dress", "This is stylish shirt", 'assets/dress/mens9.png', 850),
    ItemModel("Men's dress", "This is stylish shirt", 'assets/dress/mens10.png', 850),
    ItemModel("Women's dress", "This is stylish frock", 'assets/dress/womens1.png', 850),
    ItemModel("Women's dress", "This is stylish frock", 'assets/dress/womens2.png', 850),
    ItemModel("Women's dress", "This is stylish frock", 'assets/dress/womens3.png', 850),
    ItemModel("Women's dress", "This is stylish frock", 'assets/dress/womens4.png', 850),
    ItemModel("Women's dress", "This is stylish frock", 'assets/dress/womens5.png', 850),
    ItemModel("Women's dress", "This is stylish frock", 'assets/dress/womens6.png', 850),
    ItemModel("Women's dress", "This is stylish frock", 'assets/dress/womens7.png', 850),
    ItemModel("Women's dress", "This is stylish frock", 'assets/dress/womens8.png', 850),
    ItemModel("Women's dress", "This is stylish frock", 'assets/dress/womens9.png', 850),
    ItemModel("Women's dress", "This is stylish frock", 'assets/dress/womens10.png', 850),
  ];

  List<ItemModel> furniture= [
    ItemModel('Double Bed', 'Double Bed with 2 Lamps', 'assets/items/bed.png', 1200,),
    ItemModel('Single Sofa T55', 'White Sofa For Your Home', 'assets/items/sofa_white.png', 16000,),
    ItemModel('Double Sofa ', 'Three Seater Branded Sofa', 'assets/items/sofa_yellow.png', 10000,),
    ItemModel('Chair Brown ', 'A Small Chair For Your Backyard ', 'assets/items/pc_table.png', 6500,),
    ItemModel('G78 Single Sofa', 'Branded Single Yellow Sofa', 'assets/items/single_sofa.png', 8500,),
    ItemModel('Dinner Table', 'Beautiful Dinner Table For Family', 'assets/items/dinner_table.png', 1100,),
    ItemModel('Branded Pc Table', 'Wooden Branded UK Table', 'assets/items/pc_table2.png', 1000,),
    ItemModel('Chair Short', 'A Small Cheap Chair', 'assets/items/chair2.png', 1100,),
    ItemModel('Wooden Table', 'Wooden Branded UK Table', 'assets/items/table.png', 1650,),
    ItemModel('Thai Double Bed', 'Branded Double Bed With Locker ', 'assets/items/bed_double.png', 1200,),
    ItemModel('Rotatable Chair', 'A Brand New Rotatable Chair', 'assets/items/rot_chair.png', 5000,),
    ItemModel('UK5 Sofa', 'Brand New Single Sofa', 'assets/items/sofa_uk.png', 1500,),
    ItemModel('T80 Dinner Table', 'Beautiful table for Dinner', 'assets/items/dinner_table2.png', 1950,),
    ItemModel('2 Seat Sofa', 'This is branded new Double sofa', 'assets/items/sofa_yellow.png', 1568,),
    ItemModel('Grey Sofa', 'This is a 2 seater and Brand new double sofa', 'assets/items/sofa_grey.png', 1569,),
    ItemModel('Brown Chair Y9', 'A Beautiful chair for sitting', 'assets/items/chair1.png', 3650,),
    ItemModel('HU9 Dinner Table', 'Beautiful Table For Dinner', 'assets/items/dinner_table3.png', 2250,),
    ItemModel('HU9 Dinner Table', 'Beautiful Table For Dinner', 'assets/items/bed1.png', 2250,),
    ItemModel('HU9 Dinner Table', 'Beautiful Table For Dinner', 'assets/items/bed2.png', 2250,),
    ItemModel('HU9 Dinner Table', 'Beautiful Table For Dinner', 'assets/items/bed3.png', 2250,),
    ItemModel('HU9 Dinner Table', 'Beautiful Table For Dinner', 'assets/items/bookshelf.png', 2250,),
    ItemModel('HU9 Dinner Table', 'Beautiful Table For Dinner', 'assets/items/bookshelf1.png', 2250,),
  ];
  List<ItemModel> electronics=[
    ItemModel("Electronics", "Electronics", 'assets/electronics/ece1.png', 550),
    ItemModel("Electronics", "Electronics", 'assets/electronics/ece2.png', 550),
    ItemModel("Electronics", "Electronics", 'assets/electronics/ac3.png', 550),
    ItemModel("Electronics", "Electronics", 'assets/electronics/ece4.png', 550),
    ItemModel("Electronics", "Electronics", 'assets/electronics/ece5.png', 550),
    ItemModel("Electronics", "Electronics", 'assets/electronics/ece6.png', 550),
    ItemModel("Electronics", "Electronics", 'assets/electronics/ece7.png', 550),
    ItemModel("Electronics", "Electronics", 'assets/electronics/ece8.png', 550),
    ItemModel("Electronics", "Electronics", 'assets/electronics/ece9.png', 550),
    ItemModel("Electronics", "Electronics", 'assets/electronics/ece10.png', 550),
    ItemModel("Electronics", "Electronics", 'assets/electronics/ece11.png', 550),
    ItemModel("Electronics", "Electronics", 'assets/electronics/ece12.png', 550),
    ItemModel("Electronics", "Electronics", 'assets/electronics/ece13.png', 550),
    ItemModel("Electronics", "Electronics", 'assets/electronics/ece14.png', 550),
    ItemModel("Electronics", "Electronics", 'assets/electronics/ece15.png', 550),
    ItemModel("Electronics", "Electronics", 'assets/electronics/ece16.png', 550),
    ItemModel("Electronics", "Electronics", 'assets/electronics/ece17.png', 550),
    ItemModel("Electronics", "Electronics", 'assets/electronics/ece18.png', 550),
    ItemModel("Electronics", "Electronics", 'assets/electronics/ece19.png', 550),
    ItemModel("Electronics", "Electronics", 'assets/electronics/ece20.png', 550),
  ];
// creating firebase instance
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signup(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User user = result.user!;

      if (result != null) {
        preferences.setString("username", user.displayName!);
        preferences.setBool("logged", true);
        preferences.setString("email", user.email!);
        FirebaseFirestore path = FirebaseFirestore.instance;


        classChairs.forEach((element) async {
          await path.collection("users").doc(user.email).collection(
              "products").doc("categories").collection("chairs").add({
            'name': element.name,
            'detail': element.detail,
            'pic': element.pic,
            'price': element.price,
            'cart': false
          }).then((value) => print("added"));
        });
          furniture.forEach((prod) async {
            await path.collection("users").doc(user.email).collection(
                "products").doc("categories").collection("furniture").add({
              'name': prod.name,
              'detail': prod.detail,
              'pic': prod.pic,
              'price': prod.price,
              'cart': false
            }).then((value) => print("added"));
          });
          dress.forEach((prod) async {
            await path.collection("users").doc(user.email).collection(
                "products").doc("categories").collection("dress").add({
              'name': prod.name,
              'detail': prod.detail,
              'pic': prod.pic,
              'price': prod.price,
              'cart': false
            }).then((value) => print("added"));
          });
        electronics.forEach((prod) async {
          await path.collection("users").doc(user.email).collection(
              "products").doc("categories").collection("electronics").add({
            'name': prod.name,
            'detail': prod.detail,
            'pic': prod.pic,
            'price': prod.price,
            'cart': false
          }).then((value) => print("added"));
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CategoryScreen(useraname: user.displayName!,email: user.email!,)));

      } // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
    );

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.red,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            // signIn(emailController.text, passwordController.text);
          },
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Color(0xffDDF7E3),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Color(0xffDDF7E3),
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 200,
                        child: Image.asset(
                          "assets/items/login.jfif",
                          fit: BoxFit.contain,
                        )),
                    SizedBox(height: 45),
                    emailField,
                    SizedBox(height: 25),
                    passwordField,
                    SizedBox(height: 35),
                    loginButton,
                    SizedBox(height: 15),
                    Text("Or"),
                    InkWell(
                      onTap: (){
                        signup(context);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: MediaQuery.of(context).size.height/14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/items/google.png",width: 20,height: 20,),
                            SizedBox(width: 10,),
                            Text("Continue with Google")
                          ],
                        ),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Signup()));
                            },
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // login function
  // void signIn(String email, String password) async {
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       String fileName;
  //       await _auth
  //           .signInWithEmailAndPassword(email: email, password: password)
  //           .then((firstname) async => {
  //             print(firstname.toString()),
  //         Fluttertoast.showToast(msg: "Login Successful"),
  //         await FirebaseFirestore.instance.collection(email).add({}),
  //         // fileName = FirebaseFirestore.instance.collection("users").where("email",isEqualTo: email).,
  //         // print(fileName),
  //         Navigator.of(context).pushReplacement(
  //             MaterialPageRoute(builder: (context) => CatalogScreen(user: user,))
  //         ),
  //       });
  //     } on FirebaseAuthException catch (error) {
  //       switch (error.code) {
  //         case "invalid-email":
  //           errorMessage = "Your email address appears to be malformed.";
  //           break;
  //         case "wrong-password":
  //           errorMessage = "Your password is wrong.";
  //           break;
  //         case "user-not-found":
  //           errorMessage = "User with this email doesn't exist.";
  //           break;
  //         case "user-disabled":
  //           errorMessage = "User with this email has been disabled.";
  //           break;
  //         case "too-many-requests":
  //           errorMessage = "Too many requests";
  //           break;
  //         case "operation-not-allowed":
  //           errorMessage = "Signing in with Email and Password is not enabled.";
  //           break;
  //         default:
  //           errorMessage = "An undefined Error happened.";
  //       }
  //       Fluttertoast.showToast(msg: errorMessage!);
  //       print(error.code);
  //     }
  //   }
  // }
}
