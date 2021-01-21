import 'package:flutter/material.dart';
import 'package:userprefence/src/pages/home_page.dart';
import 'package:userprefence/src/pages/setting_page.dart';

class MenuWidget extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/menu-img.jpg"),
                fit: BoxFit.cover,
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.home, color: Colors.blue),
              title: Text("Home"),
              onTap: () => Navigator.pushReplacementNamed(context, HomePage.routeName),
            ),

            ListTile(
              leading: Icon(Icons.people, color: Colors.blue),
              title: Text("people"),
              onTap: (){},
            ),

            ListTile(
              leading: Icon(Icons.pages, color: Colors.blue),
              title: Text("Pages"),
              onTap: (){},
            ),

            ListTile(
              leading: Icon(Icons.mobile_friendly, color: Colors.blue),
              title: Text("Movile"),
              onTap: (){},
            ),

            ListTile(
              leading: Icon(Icons.apartment, color: Colors.blue),
              title: Text("apartment"),
              onTap: (){},
            ),

            ListTile(
              leading: Icon(Icons.settings, color: Colors.blue),
              title: Text("Settings"),
              onTap: () => Navigator.pushReplacementNamed(context, SettingPage.routeName),
            ),
        ],
      ),
    );
  }
}