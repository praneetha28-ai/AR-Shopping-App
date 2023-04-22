import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture/product.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginPage.dart';
class CategoryScreen extends StatefulWidget {

  String useraname;
  String email;
  CategoryScreen({required this.useraname,required this.email});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState(username: useraname,email: email);
}

class _CategoryScreenState extends State<CategoryScreen> {
  late String username;
  late String email;
  _CategoryScreenState({required this.username,required this.email});
  final PageController bannerController = PageController(initialPage: 0);
  final int bannerCount = 3;

  @override
  void initState() {
    super.initState();
    // Automatic banner scrolling
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (bannerController.page == bannerCount - 1) {
        bannerController.animateToPage(0,
            duration: const Duration(milliseconds: 50), curve: Curves.ease);
      } else {
        bannerController.nextPage(
            duration: const Duration(milliseconds: 150), curve: Curves.ease);
      }
    });
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();

  void signOutGoogle() async{
    await googleSignIn.signOut();
    final SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setBool("logged", false);
    print("User Sign Out");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: Icon(Icons.menu_sharp,color: Colors.deepPurple,),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("ARena",style: TextStyle(color: Colors.deepPurple),),
            SizedBox(width: 100,),
            Icon(Icons.notifications_active_outlined,color: Colors.deepPurple,),
            IconButton(
                onPressed: (){},
                icon: Icon(Icons.shopping_cart_outlined,color: Colors.deepPurple,)
            )
          ],
        ),
      ),
      // bottomNavigationBar:
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             UserAccountsDrawerHeader(
               decoration: BoxDecoration(
                 color: Colors.deepPurple
               ),
              accountName: Text(username),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Edit Profile'),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => UserProfilePage()),
                // );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Cart'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Orders'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SettingsPage()),
                // );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                signOutGoogle();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Login()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white70,
                    border: Border.all(color: Colors.white60),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Products',
                      border: InputBorder.none,
                      icon: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      height: 300,
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              margin: EdgeInsets.all(8),
                              width: 80,
                              height: 80,
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CatalogScreen(username: username, email: email, cat:'dress',)));
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  child: Image.asset("assets/dress/womens1.png",width: 70,height: 70,),),
                              )
                          ),
                          Text("Dress")
                        ],
                      ),
                    ),

                    Container(
                      height: 300,
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                // color: Colors.white10,
                                  borderRadius: BorderRadius.circular(40)
                              ),
                            margin: EdgeInsets.all(8),
                              width: 80,
                              height: 80,
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CatalogScreen(username: username, email: email, cat:'dress',)));
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  child: Image.asset("assets/dress/mens1.png"),),
                              )
                          ),
                          Text("Shirts")
                        ],
                      ),
                    ),

                    Container(
                      height: 300,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                // color: Colors.white10,
                              borderRadius: BorderRadius.circular(40)
                            ),
                            margin: EdgeInsets.all(8),
                              width: 80,
                              height: 80,
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CatalogScreen(username: username, email: email, cat:'chairs',)));
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  child: Image.asset("assets/chairs/class/chair1.png"),),
                              )
                          ),
                          Text("Chairs")
                        ],
                      ),
                    ),
                    Container(
                      height: 300,
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                // color: Colors.white10,
                                  borderRadius: BorderRadius.circular(40)
                              ),
                            margin: EdgeInsets.all(8),
                              width: 80,
                              height: 80,
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CatalogScreen(username: username, email: email, cat:'electronics',)));
                                },
                                child: CircleAvatar( backgroundColor:Colors.grey[200],
                                  child: Image.asset("assets/electronics/ece10.png"),),
                              )
                          ),
                          Text("Fridge")
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                // color: Colors.white10,
                                  borderRadius: BorderRadius.circular(40)
                              ),
                            margin: EdgeInsets.all(8),
                              width: 80,
                              height: 80,
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CatalogScreen(username: username, email: email, cat:'furniture',)));
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  child: Image.asset("assets/items/single_sofa.png"),),
                              )
                          ),
                          Text("Sofas")
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                // color: Colors.white10,
                                  borderRadius: BorderRadius.circular(40)
                              ),
                            margin: EdgeInsets.all(8),
                              width: 80,
                              height: 80,
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CatalogScreen(username: username, email: email, cat:'dress',)));
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  child: Image.asset("assets/dress/mens1.png"),),
                              )
                          ),
                          Text("New")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 100,),
              SizedBox(
                height: 150,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  controller: bannerController, // Add this line
                  children: [
                    Container(
                      width: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.blue,
                      ),
                      child: const Center(
                        child: Text(
                          'Banner 1',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.green,
                      ),
                      child: const Center(
                        child: Text(
                          'Banner 2',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.red,
                      ),
                      child: const Center(
                        child: Text(
                          'Banner 3',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Furniture",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                    SizedBox(width: 120,),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CatalogScreen(username: username, email: email, cat:'furniture',)));
                        },
                        child: Text("See all",style: TextStyle(color: Colors.black),)),
                    Icon(Icons.navigate_next)
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("users").doc(widget.email).collection("products").doc("categories").collection("furniture").limit(8).snapshots(),
                    builder: (context,snapshot){
                      if(!snapshot.hasData){
                        return CircularProgressIndicator();
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.size,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return DisplayItems(product: snapshot.data!.docs[index],);
                        },
                      );
                    }
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Electronics",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                    SizedBox(width: 100,),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CatalogScreen(username: username, email: email, cat:'electronics',)));
                        },
                    child: Text("See all",style: TextStyle(color: Colors.black),)),
                    Icon(Icons.navigate_next)
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("users").doc(widget.email).collection("products").doc("categories").collection("electronics").limit(8).snapshots(),
                    builder: (context,snapshot){
                      if(!snapshot.hasData){
                        return CircularProgressIndicator();
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.size,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return DisplayItems(product: snapshot.data!.docs[index],);
                        },
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DisplayItems extends StatelessWidget {
  final DocumentSnapshot product;
  DisplayItems({required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(product["pic"],width: 100,height: 100,
          ),
          Center(child: Text(product["name"],style: TextStyle(fontSize: 12),)),
        ],
      ),
    );
  }
}
