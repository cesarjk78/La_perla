import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/app_colors.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  // Función para realizar llamada
  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      debugPrint('No se pudo realizar la llamada a $phoneNumber');
    }
  }

  Widget _buildEmergencyAction({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.redAccent),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.symmetric(vertical: 18),
        alignment: Alignment.centerLeft,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.orangeAccent),
        ),
      ),
    );
  }

  Widget _buildEmergencyNumber({
    required String title,
    required String number,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(title),
        subtitle: Text(number),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Disponible",
              style: TextStyle(color: Colors.green, fontSize: 13),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: () => _makePhoneCall(number),
              icon: const Icon(Icons.phone, size: 18),
              label: const Text("Llamar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                side: const BorderSide(color: Colors.black26),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Emergencias y Reportes",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Mantente seguro durante tu viaje",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 24),

                  // 🔴 Acciones de Emergencia
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.warning, color: Colors.red),
                            SizedBox(width: 8),
                            Text(
                              "Acciones de Emergencia",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildEmergencyAction(
                          icon: Icons.description,
                          text: "-  Presentar Reporte de Incidente    ",
                          onTap: () {},
                        ),
                        const SizedBox(height: 12),
                        _buildEmergencyAction(
                          icon: Icons.dangerous,
                          text: "-  Informar Desastre Natural             ",
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 📞 Números de emergencia
                  const Row(
                    children: [
                      Icon(Icons.phone, color: Colors.black87),
                      SizedBox(width: 8),
                      Text(
                        "Números de Emergencia",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  _buildEmergencyNumber(
                    title: "Emergencias Policiales",
                    number: "105",
                  ),
                  _buildEmergencyNumber(
                    title: "Bomberos",
                    number: "116",
                  ),
                  _buildEmergencyNumber(
                    title: "SAMU (Emergencias Médicas)",
                    number: "106",
                  ),
                  _buildEmergencyNumber(
                    title: "Central La Perla del Altomayo",
                    number: "(01) 234-5678",
                  ),

                  const SizedBox(height: 24),

                  // ✅ Consejos de Seguridad
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info, color: Colors.blue),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "En caso de emergencia, mantén la calma y sigue las instrucciones del conductor",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
