import 'package:flutter/material.dart';

import 'package:user_manager/screens/home_screen.dart';
import 'package:user_manager/screens/add_user_screen.dart';
import 'package:user_manager/screens/edit_user_screen.dart';
import 'package:user_manager/screens/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      theme: ThemeData(
        useMaterial3: true, // Enables Material You styling (cleaner + modern)
        colorSchemeSeed: Colors.indigo, // All colors derive from this base hue
        scaffoldBackgroundColor:
            Colors.grey[50], // Soft background for all screens

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.red,
          centerTitle: true,
          elevation: 3,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.red,
        ),
      ),

      routes: {
        '/home': (context) => const HomeScreen(),
        '/add': (context) => const AddUserScreen(),
        '/edit': (context) => const EditUserScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
