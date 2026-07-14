import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart'; // <--- NHỚ IMPORT FILE NÀY

import 'screens/home/home_screen.dart';

void main() {
  runApp(const ClothingShopApp());
}

class ClothingShopApp extends StatelessWidget {
  const ClothingShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
        ChangeNotifierProvider<OrderProvider>(create: (_) => OrderProvider()),
        // <--- THÊM DÒNG NÀY VÀO
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clothing Shop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}