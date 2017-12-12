import 'package:flutter/material.dart';
import 'Horses.dart';
import 'LoadPicture.dart';

/// Main container
/// Show the title, top barred for navigate and window to show
/// Control the user flow and create/destroy selected window's
class MainContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DefaultTabController(
        length: windows.length,
        child: new Scaffold(
          appBar: new AppBar(
            centerTitle: true,
            title: const Text('My horse stable'),
            bottom: new TabBar(
              isScrollable: true,
              tabs: windows.map((Window choice) {
                return new Tab(
                  text: choice.title,
                  icon: new Image.asset(choice.icon, width: 32.0, height: 32.0),
                );
              }).toList(),
            ),
          ),
          body: new TabBarView(
            children: windows.map((Window choice) {
              return new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new WindowShower(window: choice),
              );
            }).toList(),
          ),
        ),
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
  new Window(title: 'Chevaux', icon: 'images/horse.png', widget: new Horses()),
  new Window(title: 'Professionnelles', icon: 'images/hammer.png', widget: new LoadPicture()),
  new Window(title: 'Calendrier', icon: 'images/calendar.png', widget: new Horses()),
];


/// Window container create on fly
class WindowShower extends StatelessWidget {
  const WindowShower({ Key key, this.window }) : super(key: key);
  final Window window;

  @override
  Widget build(BuildContext context) {
    return window.widget;
  }
}

void main() {
  runApp(new MainContainer());
}
