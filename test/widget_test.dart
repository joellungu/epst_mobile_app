import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspecteur_cours_distant/inspecteur_cours_distant.dart'
    as inspecteur_cours_distant;

void main() {
  testWidgets('shows sernafor inspector distance courses module', (
    WidgetTester tester,
  ) async {
    const assignments = [
      inspecteur_cours_distant.InspecteurCoursAssignment(
        id: 1,
        idInspecteur: 19,
        course: inspecteur_cours_distant.CourseInfo(
          id: 10,
          title: 'Pedagogie',
          branch: '',
          notion: '',
          type: '',
          classId: 'classe-1',
        ),
        classes: [
          inspecteur_cours_distant.ClasseInfo(
            id: 'classe-1',
            label: '1ere primaire',
            details: 'Education de base',
          ),
        ],
      ),
    ];

    await tester.pumpWidget(
      const MaterialApp(
        home: inspecteur_cours_distant.Accueil(
          {
            'id': 19,
            'role': 19,
            'matricule': 'INS-19',
            'nom': 'Inspecteur',
            'postnom': 'Sernafor',
          },
          initialAssignments: assignments,
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Cours affectes'), findsOneWidget);
    expect(find.text('Pedagogie'), findsOneWidget);
    expect(find.text('1ere primaire'), findsOneWidget);
  });
}
