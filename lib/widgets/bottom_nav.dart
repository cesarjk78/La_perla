import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.house),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Rutas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.warning),
          label: 'Emergencia',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'Nosotros',
        ),
      ],
    );
  }
}
