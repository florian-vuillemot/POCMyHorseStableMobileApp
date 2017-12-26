import 'package:flutter/material.dart';

class PlanningInfoCard extends StatelessWidget {
  PlanningInfoCard({ Key key }) : super(key: key);

  final appointments = ["Rdv1 de 8h30", "Rdv2 de 9h40", "Cours machin"];

  @override
  Widget build(BuildContext context) {
    return new ListView(
        children: appointments.map((txt) => new Text(txt)).toList()
    );
  }
}