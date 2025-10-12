import 'package:flutter/material.dart';
import '../widgets/app_colors.dart';
import '../widgets/bottom_nav.dart'; // ✅ Importamos nuestro BottomNav
import 'bus_search_screen.dart';

class SnacksScreen extends StatefulWidget {
  const SnacksScreen({super.key});

  @override
  State<SnacksScreen> createState() => _SnacksScreenState();
}

class _SnacksScreenState extends State<SnacksScreen> {
  int _currentIndex = 0;

  void _onNavTap(int index) {
    setState(() => _currentIndex = index);

    // ✅ Navegación según el índice
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BusSearchScreen()),
        );
        break;
      // 👉 Aquí puedes agregar más casos para Rutas, Emergencia, Nosotros
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            // ✅ Usamos pop para regresar sin duplicar navbars
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Snacks",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),

      // ✅ Contenido principal
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          SnackCard(
            icon: Icons.local_pizza_outlined,
            title: "Papitas",
            description: "Bolsa de papas fritas crocantes",
            price: "S/. 9.00",
          ),
          SnackCard(
            icon: Icons.local_drink_outlined,
            title: "Gaseosa",
            description: "Bebida refrescante en lata",
            price: "S/. 6.00",
          ),
          SnackCard(
            icon: Icons.water_drop_outlined,
            title: "Agua Mineral",
            description: "Botella de agua fría",
            price: "S/. 4.00",
          ),
          SnackCard(
            icon: Icons.icecream_outlined,
            title: "Chocolate",
            description: "Barra de chocolate dulce",
            price: "S/. 7.50",
          ),
        ],
      ),

      // ✅ Agregamos BottomNav una sola vez
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

class SnackCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String price;

  const SnackCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Icono
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 32, color: Colors.deepPurple),
            ),
            const SizedBox(width: 16),
            // Texto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(description,
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 14)),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      price,
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
