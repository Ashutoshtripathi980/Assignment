import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(height: 40),
          const ListTile(
            title: Text(
              'FLUTTER \nASSIGNMENT',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          const ListTile(
            leading: Icon(Icons.home, color: Colors.white),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
          ),
          InkWell(
            onTap: () => Get.back(),
            child: const ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text(
                'Log Out',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
