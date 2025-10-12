import 'package:flutter/material.dart';
import '../widgets/app_colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LOGO + NOMBRE
            Center(
              child: Column(
                children: [
                  Image.asset(
                    "assets/image/logo.png", // <-- tu logo principal
                    height: 80,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "mas que un amigo",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 23, 18, 31),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // TITULO
            const Text(
              "Sobre Nosotros",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            // ITEM 1
            _InfoItem(
              icon: Icons.directions_bus,
              color: Colors.orange,
              title: "Transporte que cuida de ti y de familia",
              description:
                  "Con La Perla de Alto Mayo, no solo te llevamos a tu destino, "
                  "te llevamos con seguridad, compromiso y tecnología de punta. "
                  "Con más de 10 años de experiencia en el sector, somos una empresa 100% peruana.",
            ),

            // ITEM 2
            _InfoItem(
              icon: Icons.shield,
              color: Colors.blue,
              title: "Seguridad en cada ruta",
              description:
                  "Nuestros buses están equipados con sistemas de geolocalización "
                  "en tiempo real, sensores de emergencia y comunicación directa con supervisores.",
            ),

            // ITEM 3
            _InfoItem(
              icon: Icons.phone_android,
              color: Colors.deepPurple,
              title: "Tecnología pensada en ti",
              description:
                  "Desde nuestra app puedes seguir tu bus, recibir alertas y reportes de incidencias al instante.",
            ),

            // ITEM 4
            _InfoItem(
              icon: Icons.people,
              color: Colors.purple,
              title: "Un equipo humano, una misión clara",
              description:
                  "Conductores capacitados, personal atento y un sistema de soporte "
                  "activo 24/7. Porque tu confianza es nuestro motor.",
            ),

            // ITEM 5 (Visión)
            _InfoItem(
              icon: Icons.visibility,
              color: Colors.deepPurple,
              title: "Nuestra visión",
              description:
                  "Ser la empresa líder en transporte inteligente y seguro en el norte del Perú. "
                  "Más que mover personas, moveremos sueños.",
            ),

            const SizedBox(height: 20),
            const Text(
              "Gracias por confiar en La Perla de Alto Mayo.",
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

// Widget Reutilizable
class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _InfoItem({
    required this.icon,
    required this.title,
    required this.description,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 40), // ícono grande
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}