import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final bool compact; // nuevo flag

  const InfoItem({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    this.compact = false, // por defecto false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: compact ? 100 : 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: compact ? 20 : 28,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color, size: compact ? 24 : 32),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: compact ? 12 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
