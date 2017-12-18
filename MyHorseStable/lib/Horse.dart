import 'package:flutter/material.dart';

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
        child: new _HorseInfoCard(choice: choice),
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

class _HorseInfo {
  const _HorseInfo({ this.title, this.icon });
  final String title;
  final IconData icon;
}

const List<_HorseInfo> choices = const <_HorseInfo>[
  const _HorseInfo(title: 'Info cheval', icon: Icons.directions_car),
  const _HorseInfo(title: 'Planning', icon: Icons.directions_bike),
  const _HorseInfo(title: 'Futur rdv', icon: Icons.directions_boat),
  const _HorseInfo(title: 'Ancien rdv', icon: Icons.directions_bus),
  const _HorseInfo(title: 'Pension', icon: Icons.directions_railway),
];

const List<_HorseInfo> ex = const <_HorseInfo>[
  const _HorseInfo(title: 'Info cheval', icon: Icons.directions_car),
  const _HorseInfo(title: 'Planning', icon: Icons.directions_bike),
  const _HorseInfo(title: 'Futur rdv', icon: Icons.directions_boat),
  const _HorseInfo(title: 'Ancien rdv', icon: Icons.directions_bus),
  const _HorseInfo(title: 'Pension', icon: Icons.directions_railway),
  const _HorseInfo(title: '', icon: Icons.directions_railway),
];


class _HorseInfoCard extends StatelessWidget {
  const _HorseInfoCard({ Key key, this.choice }) : super(key: key);

  final _HorseInfo choice;

  @override
  Widget build(BuildContext context) {
    return new ListView(
          children: ex.map((e) => new ExampleWidget(e.title)).toList()
        );
  }
}

class ExampleWidget extends StatefulWidget {
  ExampleWidget(this.title, {Key key}) : super(key: key);

  final String title;

  @override
  _ExampleWidgetState createState() => new _ExampleWidgetState(this.title);
}

/// State for [ExampleWidget] widgets.
class _ExampleWidgetState extends State<ExampleWidget> {
  _ExampleWidgetState(this.title);

  final String title;
  final TextEditingController _controller = new TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return this.title.isEmpty ? _makeButton() : _makeTextField();
  }
}