import 'package:flutter/material.dart';
import 'ListHorseInfo.dart';
import 'HorseInfo.dart';
import 'LoadPicture.dart';

class Horse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new _HorseAppBarBottomSample();
  }
}

class _HorseAppBarBottomSample extends StatefulWidget {
  @override
  _HorseAppBarBottomSampleState createState() => new _HorseAppBarBottomSampleState();
}

class _HorseAppBarBottomSampleState extends State<_HorseAppBarBottomSample> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: choices.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _nextPage(int delta) {
    final int newIndex = _tabController.index + delta;
    if (newIndex < 0 || newIndex >= _tabController.length)
      return;
    _tabController.animateTo(newIndex);
  }

  List<Widget> _toShow() {
    return choices.map((_HorseInfo choice) {
      return new Padding(
        padding: const EdgeInsets.all(3.0),
        child: choice.widget//new _HorseInfoCard(choice: choice),
      );
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          leading: new IconButton(
            tooltip: 'Previous choice',
            icon: const Icon(Icons.arrow_back),
            onPressed: () { _nextPage(-1); },
          ),
          actions: <Widget>[
            new IconButton(
              icon: const Icon(Icons.arrow_forward),
              tooltip: 'Next choice',
              onPressed: () { _nextPage(1); },
            ),
          ],
          title: new PreferredSize(
            preferredSize: const Size.fromHeight(20.0),
            child: new Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.white),
              child: new Container(
                height: 20.0,
                alignment: Alignment.center,
                child: new TabPageSelector(controller: _tabController),
              ),
            ),
          ),
        ),
        body: new TabBarView(
          controller: _tabController,
          children: _toShow()
        )
      );
  }
}

class _HorseInfo extends HorseInfo{
  _HorseInfo({ name, this.widget }): super (name: name);

  final Widget widget;
}

List<_HorseInfo> choices = <_HorseInfo>[
  new _HorseInfo(name: 'Photo cheval', widget: new _LoadPicture()),
  new _HorseInfo(name: 'Info cheval', widget: new _HorseInfoCard()),
  new _HorseInfo(name: 'Planning', widget: new _PlanningInfoCard()),
  new _HorseInfo(name: 'Pension', widget: new _PensionInfoCard()),
];


class _PensionInfoCard extends StatefulWidget {
  @override
  _PensionInfoCardState createState() => new _PensionInfoCardState();
}

class MaleOrFemale extends StatefulWidget {
  MaleOrFemale(this.title, {Key key}) : super(key: key);

  final String title;

  @override
  _MaleOrFemale createState() => new _MaleOrFemale();
}

class _MaleOrFemale extends State<MaleOrFemale> {
  _MaleOrFemale();

  bool isMal = false;

  void _handleSwitch(bool newValue) {
    setState(() {
      isMal = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Text(isMal ? "Male" : "Femelle"),
              new Switch(
                  value: isMal,
                  onChanged: _handleSwitch
              )]
        );
  }
}

class _PensionInfoCardState extends State<_PensionInfoCard> {
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

class _PlanningInfoCard extends StatelessWidget {
  _PlanningInfoCard({ Key key }) : super(key: key);

  final appointments = ["Rdv1 de 8h30", "Rdv2 de 9h40", "Cours machin"];

  @override
  Widget build(BuildContext context) {
    return new ListView(
        children: appointments.map((txt) => new Text(txt)).toList()
    );
  }
}

class _LoadPicture extends StatelessWidget {
  _LoadPicture({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return new LoadPicture("Aucune photo pour ce cheval");
  }
}

class _HorseInfoCard extends StatelessWidget {
  _HorseInfoCard({ Key key }) : super(key: key);

  final choice = [
    new DisplayHorseInfoWidget("Nom"), new DisplayHorseInfoWidget("date"),
    new MaleOrFemale("Sexe"), new DisplayHorseInfoWidget("race"), new DisplayHorseInfoWidget("nationality")
  ];

  @override
  Widget build(BuildContext context) {
    return new ListView(
          children: choice
        );
  }
}

class DisplayHorseInfoWidget extends ListHorseInfoPrimitive {
  DisplayHorseInfoWidget(this.title, {Key key}) : super(key: key);

  final String title;

  @override
  State<ListHorseInfoPrimitive> createState() {
    if (title == "race"){
      return new ListHorseInfo(
          race: null,
          races: [
            new Race(name: "Race number 1"),
            new Race(name: "Race number 2"),
          ],
          name: "Race"
      );
    }
    if (title == "nationality"){
      return new ListHorseInfo(
          race: null,
          races: [
            new Nationality(name: "Nat number 1"),
            new Nationality(name: "Nat number 2"),
          ],
          name: "Nationality"
      );
    }

    return new _DisplayHorseInfoWidget(this.title);
  }
}

/// State for [DisplayHorseInfoWidget] widgets.
class _DisplayHorseInfoWidget extends State<DisplayHorseInfoWidget> {
  _DisplayHorseInfoWidget(this.title);

  final String title;
  final TextEditingController _controller = new TextEditingController();
  DateTime birthdate;

  Widget _makeButton(){
    return new Padding(
        padding: const EdgeInsets.all(12.0),
        child: new RaisedButton(
          color: const Color(0xFF42A5F5),
          onPressed: () {
            print("push");
          },
          child: new Text('Valider'),
          )
      );
  }

  Widget _makeTextField(){
    return new TextField(
      controller: _controller,
      decoration: new InputDecoration(
          labelText: this.title,
          hintText: 'Type something'
      ),
    );
  }

  void onChanged(DateTime value) {
    setState(() {
      this.birthdate = value;
    });
  }

  Widget _datePicker(){
    final DateTime dateTime = new DateTime.now();
    final date = new DateTime(dateTime.year, dateTime.month, dateTime.day);
    final time = new TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);

    return new FlatButton(
          child: new Text(
              null == this.birthdate ? "Clicker pour entrer la date de naissance" : "Anniversaire: " + this.birthdate.day.toString() + "/" + this.birthdate.month.toString() + "/" + this.birthdate.year.toString()
          ),
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: date,
              firstDate: new DateTime(1950, 1, 1),
              lastDate: new DateTime.now()
            )
            .then((DateTime value) {
              if (null != value) {
                onChanged(new DateTime(
                    value.year, value.month, value.day, time.hour,
                    time.minute));
              }
            });
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    if (this.title == "date")
      return _datePicker();
    return this.title.isEmpty ? _makeButton() : _makeTextField();
  }
}
