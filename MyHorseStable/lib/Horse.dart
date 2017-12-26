import 'package:flutter/material.dart';
import 'HorseInfoCard.dart';
import 'HorseInfo.dart';
import 'LoadPictureCard.dart';
import 'PensionInfoCard.dart';
import 'PlanningInfoCard.dart';

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
        child: choice.widget
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
  new _HorseInfo(name: 'Photo cheval', widget: new LoadPictureCard()),
  new _HorseInfo(name: 'Info cheval', widget: new HorseInfoCard()),
  new _HorseInfo(name: 'Planning', widget: new PlanningInfoCard()),
  new _HorseInfo(name: 'Pension', widget: new PensionInfoCard()),
];
