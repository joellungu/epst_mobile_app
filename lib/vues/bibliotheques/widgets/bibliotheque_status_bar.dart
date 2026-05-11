import 'package:flutter/material.dart';

class BibliothequeStatusBar extends StatelessWidget {
  final bool connected;
  final String? lastUpdateLabel;

  const BibliothequeStatusBar({
    Key? key,
    required this.connected,
    required this.lastUpdateLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: connected ? Colors.green.shade50 : Colors.orange.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: connected ? Colors.green.shade100 : Colors.orange.shade100,
        ),
      ),
      child: Row(
        children: [
          Icon(
            connected ? Icons.cloud_done_outlined : Icons.cloud_off_outlined,
            color: connected ? Colors.green.shade700 : Colors.orange.shade800,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _message,
              style: TextStyle(
                color: connected ? Colors.green.shade900 : Colors.orange.shade900,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String get _message {
    final update = lastUpdateLabel == null
        ? 'Aucune synchronisation locale'
        : 'Dernière mise à jour: $lastUpdateLabel';
    return connected ? 'Connecté - $update' : 'Hors connexion - $update';
  }
}
