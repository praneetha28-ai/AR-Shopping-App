import 'package:flutter/material.dart';
import 'package:furniture/HomeScreen/categories.dart';
import 'package:furniture/CatalogScreen/categoryPage.dart';
import 'package:furniture/ExtraScreens/notifications.dart';
import 'package:furniture/ExtraScreens/whishlist.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:myshop/pages/category.dart';
// import 'package:myshop/pages/home_page.dart';
//
// import 'notifications.dart';
// import 'wishlist.dart';

class MainScreen extends StatefulWidget {
  final String username;
  final String email;
   MainScreen({required this.username,required this.email});

  @override
  State<MainScreen> createState() => _MainScreenState(username: username,email: email);
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final String username;
  final String email;
  late List<Widget> _pages;

  _MainScreenState({required this.username, required this.email}) {
    _pages = [
      CategoryScreen(useraname: username, email: email),
      CategoryPage(username: username,email: email,),
      NotificationsPage(),
      WishlistPage()
    ];
  }

   // void initState(){
   //   super.initState();
   //   setState(() {
   //     uname=username;
   //     emailId=email;
   //   });
   // }
  @override
  Widget build(BuildContext context) {
     print(username);
    return Scaffold(
      body: _pages[_selectedIndex],
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
          child: GNav(
            backgroundColor: Colors.white70,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Color(0xff394867),
            gap: 6,
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
                iconColor: Colors.black,
              ),
              GButton(
                icon: Icons.category,
                text: 'Categories',
                iconColor: Colors.black,
              ),
              GButton(
                icon: Icons.notifications,
                text: 'Notifications',
                iconColor: Colors.black,
              ),
              GButton(
                icon: Icons.favorite_sharp,
                text: 'Wishlist',
                iconColor: Colors.black,
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
