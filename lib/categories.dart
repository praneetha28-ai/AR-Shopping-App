import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture/categoryPage.dart';
import 'package:furniture/itemList.dart';
import 'package:furniture/product.dart';
import 'package:furniture/profile.dart';
import 'package:furniture/settings.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detail.dart';
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
  final List<String> images=[
    'assets/images/banner1.jfif',
    'assets/images/banner2.jfif',
    'assets/images/banner3.jfif',
  ];
  int currentPage = 0;
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
    // print(email);
    return Scaffold(
      backgroundColor: Color(0xffF1F6F9),
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Color(0xff394867),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu_sharp,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title:
            Text("ARena",style: TextStyle(color: Colors.white),),centerTitle: true,

          actions: [Icon(Icons.notifications_active_outlined,color: Colors.white,),
        IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>itemListScreen(email: email)));
            },
            icon: Icon(Icons.shopping_cart_outlined,color: Colors.white,)
        )],
      ),
      // bottomNavigationBar:
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             UserAccountsDrawerHeader(
               decoration: BoxDecoration(
                 color: Color(0xff394867)
               ),
              accountName: Text(username),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person,color: Color(0xff394867)),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person,color: Color(0xff394867),),
              title: const Text('Edit Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart,color: Color(0xff394867)),
              title: const Text('Cart'),
              onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>itemListScreen(email: email)));},
            ),
            ListTile(
              leading: const Icon(Icons.assignment,color: Color(0xff394867)),
              title: const Text('Categories'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CategoryPage(username: username,email: email,)));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings,color: Color(0xff394867)),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage(useraname: username,email: email,)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout,color: Color(0xff394867)),
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
                    border: Border.all(color: Colors.blueGrey),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Products',
                      border: InputBorder.none,
                      icon: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.search,color: Color(0xff394867),),
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
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CatalogScreen(username: username, email: email, cat:'women',)));
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
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CatalogScreen(username: username, email: email, cat:'men',)));
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
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context)=>
                                          CatalogScreen(username: username, email: email, cat:'chairs',)
                                      )
                                  );
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
                                  borderRadius: BorderRadius.circular(40),

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
              SizedBox(height: 15,),
              SizedBox(
                height: 200.0,
                child: PageView.builder(
                  controller: bannerController,
                  itemCount: images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  onPageChanged: (int index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                ),
              ),
              // SizedBox(
              //   height: 150,
              //   child: PageView(
              //     scrollDirection: Axis.horizontal,
              //     controller: bannerController, // Add this line
              //     children: [
              //       Container(
              //         width: 200,
              //         margin: const EdgeInsets.symmetric(horizontal: 8),
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(16),
              //           // color: Colors.blue,
              //         ),
              //         child: Center(
              //           child: Image.asset(
              //             "assets/images/banner3.jfif",fit: BoxFit.cover,
              //           )
              //         ),
              //       ),
              //       Container(
              //         width: 200,
              //         margin: const EdgeInsets.symmetric(horizontal: 8),
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(16),
              //           // color: Colors.green,
              //         ),
              //         child: Center(
              //           child: Image.asset(
              //             "assets/images/banner1.jfif",fit: BoxFit.cover,
              //           )
              //         ),
              //       ),
              //       Container(
              //         width: 200,
              //         margin: const EdgeInsets.symmetric(horizontal: 8),
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(16),
              //           // color: Colors.red,
              //         ),
              //         child:  Center(
              //           child: Image.asset("assets/images/banner2.jfif",fit: BoxFit.cover,)
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15,top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Recently Added",
                        style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        TextButton(
                          child: Text("All",style: TextStyle(color: Colors.grey)),
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=>CatalogScreen(username: username, email: email, cat: "chairs")));
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 16,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,

                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("users").doc(email).collection("products").doc("categories").collection("furniture").limit(8).snapshots(),
                    builder: (context,snapshot){
                      if(!snapshot.hasData){
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.size,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return DisplayItems(product: snapshot.data!.docs[index],email: email,);
                        },
                      );
                    }
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15,top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Popular Products",
                        style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        TextButton(
                          child: Text("All",style: TextStyle(color: Colors.grey)),
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=>CatalogScreen(username: username, email: email, cat: "chairs")));
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 16,
                        )
                      ],
                    )
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
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.size,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return DisplayItems(product: snapshot.data!.docs[index],email: email,);
                        },
                      );
                    }
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15,top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Recommended for you",
                        style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        TextButton(
                          child: Text("All",style: TextStyle(color: Colors.grey)),
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CatalogScreen(username: username, email: email, cat: "men")));
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 16,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("users").doc(widget.email).collection("products").doc("categories").collection("men").limit(8).snapshots(),
                    builder: (context,snapshot){
                      if(!snapshot.hasData){
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.size,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return DisplayItems(product: snapshot.data!.docs[index],email: email,);
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
  final String email;
  DisplayItems({required this.product,required this.email});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context)=>ProductScreen(product: product,emailid: email,))
        );
      },
      child: Container(
        width: 120,
        height: 120,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5.0,
                  offset: Offset(0,3),
                  spreadRadius: 0
              )
            ]
        ),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(product["pic"],width: 100,height: 100,
            ),
            Center(child: Text(product["name"],style: TextStyle(fontSize: 12),)),
            Center(child: Text("Price:${product["price"].toString()}/-",style: TextStyle(fontSize: 12,color: Colors.grey),)),

          ],
        ),
      ),
    );
  }
}
