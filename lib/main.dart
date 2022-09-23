import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return sideNavBar();
  }

  // Top Nav Bar
  int _selectedIndex = 0;
  Widget topNavBar() {
    Widget tabButton(String title) {
      return Tab(
        child: Text(
          title,
        ),
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          bottom: TabBar(
            tabs: [
              /* 0 */ tabButton("Option 1"),
              /* 1 */ tabButton("Option β"),
              /* 2 */ tabButton("Option C"),
            ],
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
        body: Center(
          child: Text("Selected page index is $_selectedIndex"),
        ),
      ),
    );
  }

  // Side Nav Bar
  bool _extended = true;
  NavigationRailLabelType _labelType = NavigationRailLabelType.none;
  Widget sideNavBar() {
    Widget tabButton(String title) {
      return Tab(
        child: Text(
          title,
        ),
      );
    }

    void toggleExtended() {
      _extended = !_extended;
      _labelType = _extended
          ? NavigationRailLabelType.none
          : NavigationRailLabelType.all;
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Row(
          children: [
            NavigationRail(
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.add_box),
                  label: Text('Option 1'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.check_box),
                  label: Text('Option β'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.account_box),
                  label: Text('Option C'),
                ),
              ],
              selectedIndex: _selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              labelType: _labelType,
              trailing: Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          toggleExtended();
                        });
                      },
                      icon: const Icon(Icons.more_horiz_rounded),
                    ),
                  ),
                ),
              ),
              extended: _extended,
              minExtendedWidth: 200,
              elevation: 10,
            ),
            Expanded(
              child: Center(
                child: Text("Selected page index is $_selectedIndex"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
