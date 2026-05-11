import 'package:epst_app/main.dart';
import 'package:epst_app/vues/ige/recherche_annee.dart';
import 'package:epst_app/vues/ministre/linistre_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MinistreHeader extends StatelessWidget {
  final MinistreController controller;

  const MinistreHeader({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE3E8EF)),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/LOGO-MINEPST-BON.png',
            width: 64,
            height: 64,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pilotage national',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF182235),
                  ),
                ),
                const SizedBox(height: 4),
                Obx(
                  () => Text(
                    annee.value.isEmpty
                        ? 'Toutes les annees scolaires'
                        : 'Annee scolaire ${annee.value}',
                    style: const TextStyle(
                      color: Color(0xFF607089),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton.icon(
            onPressed: () async {
              await showSearch(context: context, delegate: RechercheAnnee());
              await controller.loadAnalytics();
            },
            icon: const Icon(Icons.filter_alt_outlined, size: 18),
            label: const Text('Filtrer'),
          ),
        ],
      ),
    );
  }
}

