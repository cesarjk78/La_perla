import 'package:flutter/material.dart';

class RouteScreen extends StatelessWidget {
  const RouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mapa de la ruta (Imagen)
        Container(
          height: 300,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFFE8F5E9), // Un color de fondo suave similar al de la imagen
            image: DecorationImage(
              image: AssetImage('assets/image/ruta_mapa.png'), // Tu imagen descargada
              fit: BoxFit.cover, // Para que la imagen cubra todo el espacio
            ),
          ),
          child: const Center(
            child: Text(""), // Si quieres puedes quitar este Text si la imagen siempre carga
          ),
        ),

        const SizedBox(height: 16),

        // Título "Ruta del Viaje"
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Ruta del Viaje",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),

        const SizedBox(height: 16),

        // Lista de la ruta
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: const [
              // Estación 1: Completada
              RouteItem(
                city: "Lima - Terminal Norte",
                time: "06:00",
                status: "Completado",
                isCompleted: true,
              ),
              // Estación 2: Actual
              RouteItem(
                city: "Huancayo - Terminal Sur",
                time: "14:30",
                status: "Actual",
                isActive: true,
              ),
              // Estación 3: Pendiente
              RouteItem(
                city: "Ayacucho - Terminal Central",
                time: "18:45",
                status: "Pendiente",
              ),
              // Estación 4: Pendiente
              RouteItem(
                city: "Andahuaylas - Terminal",
                time: "22:30",
                status: "Pendiente",
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Botón "Verificar Ruta"
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Verificar Ruta"),
            ),
          ),
        ),
      ],
    );
  }
}

// Widget para cada item de la ruta (Estación)
class RouteItem extends StatelessWidget {
  final String city;
  final String time;
  final String status;
  final bool isCompleted;
  final bool isActive;

  const RouteItem({
    super.key,
    required this.city,
    required this.time,
    required this.status,
    this.isCompleted = false,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    if (isCompleted) {
      statusColor = Colors.green;
    } else if (isActive) {
      statusColor = Colors.blue;
    } else {
      statusColor = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isActive ? Colors.blue.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: isActive ? Border.all(color: Colors.blue) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icono del estado
            Icon(
              isCompleted ? Icons.check_circle : Icons.circle,
              color: statusColor,
              size: 20,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Hora: $time",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}