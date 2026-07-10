import 'package:flutter/material.dart';
import '../../widgets/home/home_appbar.dart';
import '../../widgets/home/home_body.dart';
import '../../widgets/home/home_bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeAppBar(),
      body: HomeBody(),
      bottomNavigationBar: HomeBottomNav(),
    );
  }
}