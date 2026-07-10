import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(const ClothingShopApp());
}

class ClothingShopApp extends StatelessWidget {
  const ClothingShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clothing Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}