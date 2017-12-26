import 'package:flutter/material.dart';

class PensionInfoCard extends StatefulWidget {
  @override
  _PensionInfoCardState createState() => new _PensionInfoCardState();
}

class _PensionInfoCardState extends State<PensionInfoCard> {
  _PensionInfoCardState();

  bool hasPaid = false;

  void _handleSwitch(bool newValue) {
    setState(() {
      hasPaid = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> infos = [
      new Text("Entrée le: 28/08/2016"), new Text("Pension classique au foin"),
    ];

    infos.add(
        new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Text(hasPaid ? "La pension fut payé" : "La pension ne fut pas payé"),
              new Switch(
                  value: hasPaid,
                  activeColor: Colors.green,
                  activeThumbImage: new AssetImage("images/done.png"),
                  inactiveThumbImage: new AssetImage("images/cancel.png"),
                  onChanged: _handleSwitch
              )]
        )
    );

    return new ListView(
        children: infos
    );
  }
}