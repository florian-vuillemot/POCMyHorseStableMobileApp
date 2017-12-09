import 'package:flutter/material.dart';

class Horses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final datas = data;

    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('My horse stable'),
        ),
        body:
          new ListView.builder(
            itemBuilder: (BuildContext context, int index) => new EntryItem(datas[index]),
            itemCount: datas.length,
          ),
      ),
    );
  }
}

// Care type and cares.
class CareInfo {
  const CareInfo(this.type, [this.cares = const <String>[]]);
  final String type;
  final List<String> cares;
}

// One entry in the multilevel list displayed by this app.
class HorseInfo {
  HorseInfo(this.name, [this.nextCare = const CareInfo("Next"), this.previousCare = const CareInfo("Previous")]);
  final String name;
  final CareInfo nextCare;
  final CareInfo previousCare;
}


// The entire multilevel list displayed by this app.
final List<HorseInfo> data = <HorseInfo>[
  new HorseInfo('Horse1',
    new CareInfo("Next", <String>['Next care 1', 'Next care 2']),
    new CareInfo("Previous", <String>['Previous care 1', 'Previous care 2']),
  ),
  new HorseInfo('Horse2',
    new CareInfo("Next"),
    new CareInfo("Previous",<String>['Previous care 1.1', 'Previous care 2.1', "Previous again"]),
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);
  final HorseInfo entry;

  Widget _buildCare(String care){
    return new ListTile(title: new Text(care));
  }

  Widget _buildCares(CareInfo careInfo){
    return new ExpansionTile(
        key: new PageStorageKey<CareInfo>(careInfo),
        title: new Text(careInfo.type),
        children: (careInfo.cares.isEmpty ? ["Aucun élément"] : careInfo.cares).map(_buildCare).toList()
    );
  }

  Column buildButtonColumn(BuildContext context, IconData icon, String label) {
    Color color = Theme.of(context).primaryColor;

    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Icon(icon, color: color),
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: new Text(
            label,
            style: new TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTiles(HorseInfo root, BuildContext context) {
    Widget buttonSection = new Container(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildButtonColumn(context, Icons.visibility, 'Voir l\'animal'),
            buildButtonColumn(context, Icons.add, 'Ajouter un soin'),
            buildButtonColumn(context, Icons.event, 'Planning de l\'animal'),
          ],
        )
    );

    List<Widget> widgets = [root.nextCare, root.previousCare].map(_buildCares).toList();
    widgets.add(buttonSection);

    return new ExpansionTile(
      key: new PageStorageKey<HorseInfo>(root),
      title: new Text(root.name),
      children: widgets
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry, context);
  }
}

void main() {
  runApp(new Horses());
}
