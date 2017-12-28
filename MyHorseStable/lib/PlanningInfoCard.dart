import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'HorseInfo.dart';

class PlanningInfoCard extends StatelessWidget {
  PlanningInfoCard({ Key key }): super(key: key);

  CareInfo careInfo = new CareInfo("Next", <String>['Next care 1', 'Next care 2']);

  @override
  Widget build(BuildContext context) {
    return new _PlanningInfoCard(careInfo);
  }
}

class _PlanningInfoCard extends StatefulWidget {
  _PlanningInfoCard(this.careInfo, {Key key}) : super(key: key);

  CareInfo careInfo;

  @override
  _LoaderPlanningInfoCard createState() => new _LoaderPlanningInfoCard(careInfo);
}

class _LoaderPlanningInfoCard extends State<_PlanningInfoCard> {
  _LoaderPlanningInfoCard(this.careInfo);

  CareInfo careInfo;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
          child: new ListView(
            children: careInfo.cares.map((String care) => new Text(care)).toList()
          )
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _openAddEntryDialog,
        tooltip: 'Add horse rdv',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }

  Future _openAddEntryDialog() async {
    String save = await Navigator.of(context).push(new MaterialPageRoute<String>(
        builder: (BuildContext context) {
          return new AddEntryDialog();
        },
        fullscreenDialog: true
    ));
    if (save != null) {
      print("Not save $save");
    }
  }
}

class AddEntryDialog extends StatefulWidget {
  @override
  AddEntryDialogState createState() => new AddEntryDialogState();
}

class AddEntryDialogState extends State<AddEntryDialog> {
  DateTime _rdvDate;
  String _worker;

  final List<String> _workers = ["Vétérinaire", "Marréchal ferrand"];
  final TextEditingController _note = new TextEditingController();

  void changedWorker(String worker){
    _worker = worker;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Nouveau rendez-vous'),
        actions: [
          new FlatButton(
              onPressed: () {
                print("Add element");
              },
              child: new Text('Sauvegarder',
                  style: Theme
                      .of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.white))),
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new Text("Nouveau rendez-vous"),
          new ListTile(
            leading: new Icon(Icons.today, color: Colors.grey[500]),
            title: new DateTimeItem(dateTime: _rdvDate, onChanged: (dateTime) => setState(() => _rdvDate = dateTime),),
          ),
          new _HorseWorkerListBox(initialValue: _worker, values: _workers, onChanged: changedWorker),
          new TextField(
            controller: _note,
            maxLines: 3,
            decoration: new InputDecoration(
                labelText: 'Information sur le rendez-vous',
                hintText: 'Notes sur le rendez-vous'
            ),
          )
        ]
      )
    );
  }
}


class _HorseWorkerListBox extends StatelessWidget {
  _HorseWorkerListBox({Key key, this.initialValue, this.values, this.onChanged}) : super(key: key);

  String initialValue;
  final List<String> values;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return new Row(
        children: [
          new Text(null == initialValue || initialValue.isEmpty ? "Choisir un professionel" : initialValue),
          new PopupMenuButton<String>(
          initialValue: initialValue,
          icon: const Icon(Icons.arrow_drop_down),
          onSelected: onChanged,
          itemBuilder: (BuildContext context) =>
              values.map((String value) =>
              new PopupMenuItem<String>(
                value: value,
                child: new Text(value),
              )
              ).toList()
          )
        ]
      );
  }
}


class DateTimeItem extends StatelessWidget {
  DateTimeItem({Key key, DateTime dateTime, this.onChanged})
      : assert(onChanged != null),
        date = dateTime == null
            ? new DateTime.now()
            : new DateTime(dateTime.year, dateTime.month, dateTime.day),
        time = dateTime == null
            ? new TimeOfDay(hour: 10, minute: 0)
            : new TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
        super(key: key);

  final DateTime date;
  final TimeOfDay time;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new InkWell(
            onTap: (() => _showDatePicker(context)),
            child: new Padding(
                padding: new EdgeInsets.symmetric(vertical: 8.0),
                child: new Text(new DateFormat("'Le' d/M/y 'à' H:m").format(date))),
          ),
        )
      ],
    );
  }

  Future _showDatePicker(BuildContext context) async {
    DateTime dateTimePicked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: date.subtract(const Duration(days: 20000)),
        lastDate: date.add(const Duration(days: 20000))
    );

    if (dateTimePicked != null) {
      onChanged(new DateTime(dateTimePicked.year, dateTimePicked.month,
          dateTimePicked.day, time.hour, time.minute));
    }
  }

  Future _showTimePicker(BuildContext context) async {
    TimeOfDay timeOfDay =
    await showTimePicker(context: context, initialTime: time);

    if (timeOfDay != null) {
      onChanged(new DateTime(
          date.year, date.month, date.day, timeOfDay.hour, timeOfDay.minute));
    }
  }
}