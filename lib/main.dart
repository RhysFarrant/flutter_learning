import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() {
  runApp(const MyApp());

  // For Custom Title Bar
  doWhenWindowReady(() {
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
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
    return customTitleBar(
      Expanded(
        child: Center(
          child: sideNavBar(),
        ),
      ),
    );
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
  bool _extended = false;
  NavigationRailLabelType _labelType = NavigationRailLabelType.none;
  Widget sideNavBar() {
    NavigationRailDestination tabButton(Icon icon, String label) {
      return NavigationRailDestination(
        icon: icon,
        label: Text(label),
      );
    }

    void toggleExtended() {
      _extended = !_extended;
      // _labelType = _extended
      //     ? NavigationRailLabelType.none
      //     : NavigationRailLabelType.all;
    }

    return Stack(
      children: [
        mainBody(),
        Row(
          children: [
            MouseRegion(
              onEnter: (_) => setState(() => toggleExtended()),
              onExit: (_) => setState(() => toggleExtended()),
              child: NavigationRail(
                backgroundColor: Theme.of(context).primaryColor,
                destinations: [
                  tabButton(
                    const Icon(Icons.add_box),
                    'Option 1',
                  ),
                  tabButton(
                    const Icon(Icons.check_box),
                    'Option β',
                  ),
                  tabButton(
                    const Icon(Icons.account_box),
                    'Option C',
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
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: const Icon(Icons.more_horiz_rounded),
                      ),
                    ),
                  ),
                ),
                extended: _extended,
                minExtendedWidth: 200,
                minWidth: 64,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Body Generation
  bool _numberDropdown = false;
  bool _letterDropdown = false;
  Widget mainBody() {
    return Row(
      children: [
        Expanded(
          child: ListView(
            children: [
              Center(
                child: Text(
                  "Selected page index is $_selectedIndex",
                ),
              ),
              dropdownList("Number", ["1", "2", "3", "4", "5", "6", "7", "8"]),
              dropdownList("Letter", ["A", "B", "C", "D", "E", "F", "G", "H"]),
              highlightCard(),
            ],
          ),
        ),
      ],
    );
  }

  // Card to highlight on hover
  bool _isHover = false;
  Widget highlightCard() {
    return Column(
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _isHover = true),
          onExit: (_) => setState(() => _isHover = false),
          child: SizedBox(
            width: 600,
            height: 50,
            child: Card(
              shape: _isHover
                  ? RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).indicatorColor,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(4)))
                  : null,
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  "This is some Text",
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Dropdown list items
  Widget dropdownList(String title, List<String> items) {
    Widget itemList = Column(
      children: items
          .map((e) => Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: SizedBox(
                  width: 600 - 16,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        e,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              if (title == "Number") {
                _numberDropdown = !_numberDropdown;
              } else {
                _letterDropdown = !_letterDropdown;
              }
            });
          },
          child: SizedBox(
            width: 600,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title),
                    title == "Number"
                        ? _numberDropdown
                            ? const Icon(Icons.arrow_drop_up_outlined)
                            : const Icon(Icons.arrow_drop_down_outlined)
                        : title == "Letter"
                            ? _letterDropdown
                                ? const Icon(Icons.arrow_drop_up_outlined)
                                : const Icon(Icons.arrow_drop_down_outlined)
                            : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
        title == "Number"
            ? _numberDropdown
                ? itemList
                : Container()
            : title == "Letter"
                ? _letterDropdown
                    ? itemList
                    : Container()
                : Container()
      ],
    );
  }

  // Custom Title Bar
  /*
    In windows\runner\main.cpp:

    #include <bitsdojo_window_windows/bitsdojo_window_plugin.h>
    auto bdw = bitsdojo_window_configure(BDW_CUSTOM_FRAME | BDW_HIDE_ON_STARTUP);
  */
  Widget customTitleBar(Widget body) {
    return Scaffold(
      body: Column(
        children: [
          // App bar
          Column(
            children: [
              WindowTitleBarBox(
                child: Container(
                  color: Theme.of(context).cardColor,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 13, top: 8),
                          child: MoveWindow(
                            child: const Text(
                              "Flutter Learning",
                            ),
                          ),
                        ),
                      ),
                      const WindowButtons(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          body,
        ],
      ),
    );
  }
}

// For Custom Title Bar
class WindowTitleBarBox extends StatelessWidget {
  final Widget? child;
  const WindowTitleBarBox({Key? key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Container();
    }
    final titlebarHeight = appWindow.titleBarHeight;
    return SizedBox(height: titlebarHeight, child: child ?? Container());
  }
}

final buttonColors = WindowButtonColors(
  iconNormal: Colors.white,
  mouseOver: const Color.fromRGBO(217, 217, 217, 1),
  mouseDown: const Color.fromRGBO(122, 122, 122, 1),
  iconMouseOver: const Color.fromRGBO(122, 122, 122, 1),
  iconMouseDown: const Color.fromRGBO(217, 217, 217, 1),
);

final closeButtonColors = WindowButtonColors(
  mouseOver: const Color(0xFFD32F2F),
  mouseDown: const Color(0xFFB71C1C),
  iconNormal: Colors.white,
  iconMouseOver: Colors.white,
);

class WindowButtons extends StatefulWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  WindowButtonsState createState() => WindowButtonsState();
}

class WindowButtonsState extends State<WindowButtons> {
  void maximizeOrRestore() {
    setState(() {
      appWindow.maximizeOrRestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        appWindow.isMaximized
            ? RestoreWindowButton(
                colors: buttonColors,
                onPressed: maximizeOrRestore,
              )
            : MaximizeWindowButton(
                colors: buttonColors,
                onPressed: maximizeOrRestore,
              ),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
