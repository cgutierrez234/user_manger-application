import 'package:flutter/material.dart';

import 'package:user_manager/screens/home_screen.dart';
import 'package:user_manager/screens/add_user_screen.dart';
import 'package:user_manager/screens/edit_user_screen.dart';
import 'package:user_manager/screens/profile_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/add': (context) => const AddUserScreen(),
        '/edit': (context) => const EditUserScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}