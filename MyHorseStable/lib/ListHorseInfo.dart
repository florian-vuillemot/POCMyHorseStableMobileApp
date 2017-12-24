import 'package:flutter/material.dart';

class HorseInfoListable{
  const HorseInfoListable({this.name});

  final String name;
}

abstract class ListHorseInfoPrimitive extends StatefulWidget{
  ListHorseInfoPrimitive({Key key}): super(key: key);

  State<ListHorseInfoPrimitive> createState();
}

class ListHorseInfo<T extends HorseInfoListable> extends State<ListHorseInfoPrimitive>
{
  ListHorseInfo({this.race, this.races, this.name});

  T race;
  final List<T> races;
  final String name;

  void _handleState(T result){
    setState((){
      race = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
        children: [
          new Text(name),
          new _RaceListBox(race: race, races: races, onChanged: _handleState),
          new Text(null == race ? "" : race.name),
        ]
    );
  }
}

class _RaceListBox<T extends HorseInfoListable> extends StatelessWidget {
  _RaceListBox({Key key, this.race, this.races, this.onChanged}) : super(key: key);

  final T race;
  final List<T> races;
  final ValueChanged<T> onChanged;

  void _handleState(T race){
    onChanged(race);
  }

  @override
  Widget build(BuildContext context) {
    return new PopupMenuButton<T>(
        icon: const Icon(Icons.arrow_drop_down),
        onSelected: _handleState,
        itemBuilder: (BuildContext context) =>
            races.map((T r) =>
            new PopupMenuItem<T>(
              value: r,
              child: new Text(r.name),
            )
            ).toList()
    );
  }
}
