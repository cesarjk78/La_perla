import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import 'bus_search_screen.dart';
import 'route_screen.dart';
import 'emergency_screen.dart';
import 'about_screen.dart';
import '../widgets/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  final screens = const [
    BusSearchScreen(),
    RouteScreen(),
    EmergencyScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('La Perla de Alto Mayo')),
      body: screens[index],
      bottomNavigationBar: BottomNav(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // <--- aquí lo usas
      body: CustomScrollView(
        slivers: [
          // tu contenido
        ],
      ),
    );
  }
