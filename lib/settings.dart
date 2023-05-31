import 'package:flutter/material.dart';
import 'package:furniture/profile.dart';
// import 'package:myshop/pages/profile_page.dart';

class SettingsPage extends StatefulWidget {
  String useraname;
  String email;
  SettingsPage({required this.useraname,required this.email});

  @override
  _SettingsPageState createState() => _SettingsPageState(username: useraname,email: email);
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;
  bool _notifications = true;
  late String username;
  late String email;
  _SettingsPageState({required this.username,required this.email});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff394867),
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              backgroundColor:Color(0xff394867),
              radius: 50,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            SizedBox(height: 10),
            Text(
              username,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone,
                  size: 16,
                ),
                Text(
                  '123-456-7890',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.email,
                  size: 16,
                ),
                Text(
                  email,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor:  Color(0xff394867)),
              onPressed: () {
Navigator.push(
context,
MaterialPageRoute(builder: (context) => UserProfilePage()),
);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 22.0,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.only(top: 20, left: 18, bottom: 10),
                child: Text(
                  'Preferences',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('English'),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text('Dark Mode'),
              trailing: Switch(
                value: _darkMode,
                onChanged: (value) {
                  setState(() {
                    _darkMode = value;
                  });
                },
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              trailing: Switch(
                activeColor: Color(0xff394867),
                value: _notifications,
                onChanged: (value) {
                  setState(() {
                    _notifications = value;
                  });
                },
              ),
            ),
            Divider(),
            Container(
              width: double.infinity,
              color: Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.only(top: 20, left: 20, bottom: 10),
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {},
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
