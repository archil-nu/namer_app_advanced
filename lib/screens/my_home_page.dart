import 'package:flutter/material.dart';

import 'package:namer_app_advanced/screens/generator_page.dart';
import 'package:namer_app_advanced/screens/favorites_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => MyHomePageStateful();
}

class MyHomePageStateful extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
      case 1:
        page = FavoritesPage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // The container for the current page, with its background color
    // and subtle switching animation.
    var mainArea = ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    var narrowLayout = Column(
      children: [
        Expanded(child: mainArea),
        SafeArea(
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
            ],
            currentIndex: selectedIndex,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
          ),
        )
      ],
    );

    var wideLayout = Row(
      children: [
        SafeArea(
          child: NavigationRail(
            extended: true,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite),
                label: Text('Favorites'),
              ),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
          ),
        ),
        Expanded(child: mainArea),
      ],
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) =>
            ((constraints.maxWidth < 450) ? narrowLayout : wideLayout),
      ),
    );
  }
}
