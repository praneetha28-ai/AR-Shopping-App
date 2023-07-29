import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String _name = 'MyName';
  String _phone = '9848012233';
  String _email = 'abc@gmail.com';
  String _address = '123 Main St, Anytown USA';

  Future<void> _editName() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => EditFieldPage(
          fieldTitle: 'Edit Name',
          initialValue: _name,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _name = result;
      });
    }
  }

  Future<void> _editPhone() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => EditFieldPage(
          fieldTitle: 'Edit Phone',
          initialValue: _phone,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _phone = result;
      });
    }
  }

  Future<void> _editEmail() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => EditFieldPage(
          fieldTitle: 'Edit Email',
          initialValue: _email,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _email = result;
      });
    }
  }

  Future<void> _editAddress() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => EditFieldPage(
          fieldTitle: 'Edit Address',
          initialValue: _address,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _address = result;
      });
    }
  }

  Widget _buildProfilePicture() {
    return Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 60.0,
// backgroundImage: AssetImage('assets/images/small_gani.jpg'),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {
// TODO: Add camera icon onPressed functionality
            },
            child: Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                Icons.camera_alt,
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff394867),
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Color(0xff394867),
                    radius: 75.0,
// backgroundImage:
//     AssetImage('assets/images/profile_image.jpg'),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    child: IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
// Add logic to handle camera icon press
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ListTile(
              title: Text(
                'Name:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Container(
                margin: EdgeInsets.only(top: 8.0),
                child: Text(_name),
              ),
              trailing: InkWell(
                onTap: _editName,
                child: Icon(Icons.edit, color: Colors.grey[600]),
              ),
            ),
            SizedBox(height: 16.0),
            ListTile(
              title: Text(
                'Phone:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Container(
                margin: EdgeInsets.only(top: 8.0),
                child: Text(_phone),
              ),
              trailing: InkWell(
                onTap: _editPhone,
                child: Icon(Icons.edit, color: Colors.grey[600]),
              ),
            ),
            ListTile(
              title: Text(
                'Email:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Container(
                margin: EdgeInsets.only(top: 8.0),
                child: Text(_email),
              ),
              trailing: InkWell(
                onTap: _editEmail,
                child: Icon(Icons.edit, color: Colors.grey[600]),
              ),
            ),
            ListTile(
              title: Text(
                'Address:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Container(
                margin: EdgeInsets.only(top: 8.0),
                child: Text(_address),
              ),
              trailing: InkWell(
                onTap: _editAddress,
                child: Icon(Icons.edit, color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditFieldPage extends StatefulWidget {
  final String fieldTitle;
  final String initialValue;

  EditFieldPage({required this.fieldTitle, required this.initialValue});

  @override
  _EditFieldPageState createState() => _EditFieldPageState();
}

class _EditFieldPageState extends State<EditFieldPage> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fieldTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Enter ${widget.fieldTitle}',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop<String>(context, _textEditingController.text);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
