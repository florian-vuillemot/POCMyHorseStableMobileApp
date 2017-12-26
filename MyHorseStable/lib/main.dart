import 'package:flutter/material.dart';
import 'Horses.dart';
import 'LoadPicture.dart';
import 'Horse.dart';

/// Main container of application
class MainContainer extends StatefulWidget {
  @override
  _MainContainerState createState() => new _MainContainerState();
}

/// Handle selected sub app choice by the user
class _MainContainerState extends State<MainContainer> {
  Window _selectedChoice = windows[0]; // The app's "state".

  void _select(Window choice) {
    setState(() { // Causes the app to rebuild with the new _selectedChoice.
      _selectedChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('My Horse Stable'),
          actions: <Widget>[
           new IconButton( // action button
              icon: new Image.asset(windows[0].icon, width: 32.0, height: 32.0),
              onPressed: () { _select(windows[0]); },
            ),
            new IconButton( // action button
              icon: new Image.asset(windows[1].icon, width: 32.0, height: 32.0),
              onPressed: () { _select(windows[1]); },
            ),
            new PopupMenuButton<Window>( // overflow menu
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return windows.map((Window choice) {
                  return new PopupMenuItem<Window>(
                    value: choice,
                    child: new Text(choice.title),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: _selectedChoice.widget
      ),
    );
  }
}

/// Different window to show with name's and icon.
/// This appear in a top barred.
/// User can navigate throw it and create window in fly
class Window {
  Window({ this.title, this.icon, this.widget });
  final String title;
  final String icon;
  StatelessWidget widget;
}

/// List of all window to show
List<Window> windows = <Window>[
  new Window(title: 'Chevaux', icon: 'images/horse.png', widget: new Horse()),
  new Window(title: 'Professionnelles', icon: 'images/hammer.png', widget: new LoadPicture("Selectionner photo")),
  new Window(title: 'Calendrier', icon: 'images/calendar.png', widget: new Horses()),
];

void main() {
  runApp(new MainContainer());
}
