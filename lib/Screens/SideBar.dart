import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool _isOpen = false;

  void _toggleSidebar() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('John Doe'), // Replace with the profile name
            accountEmail: null, // You can add an email here if needed
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/profile_image.png'), // Replace with the path to your profile image
            ),
          ),
          ListView(
            shrinkWrap: true, // Added this line to allow the ListView to take only the required space
            children: <Widget>[
              ListTile(
                title: Text('Home'),
                onTap: () {
                  // Handle home navigation
                },
              ),
              ListTile(
                title: Text('Profile'),
                onTap: () {
                  // Handle profile navigation
                },
              ),
              // Add more list tiles for additional sidebar options
            ],
          ),
        ],
      ),
    );
  }
}
