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
    return topNavBar();
  }

  // Top Nav Bar
  int selected = 0;
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
                selected = index;
              });
            },
          ),
        ),
        body: Center(
          child: Text("Selected page index is $selected"),
        ),
      ),
    );
  }
}
