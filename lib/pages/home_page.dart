import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:login_page/pages/main_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void signout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Vehicle'),
        actions: [
          Icon(Icons.car_rental),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          Image.asset('assets/homepage.jpg'),
          SizedBox(
            height: 50,
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return VehicleSelection();
              }));
            },
            icon: Icon(Icons.add_rounded),
            label: Text('Add Vehicle'),
          ),
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              SizedBox(
                child: Divider(),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: signout,
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                    ),
                  ),
                  IconButton(
                    onPressed: signout,
                    icon: Icon(Icons.logout),
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Setting',
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.settings),
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'My Order',
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.shopping_cart),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                child: Divider(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
