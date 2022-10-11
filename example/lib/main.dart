import 'package:flutter/material.dart';
import 'package:flutter_menu/flutter_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: AppMenu(
            actions: [
              MenuAction.custom(
                builder: (context) => const Text('test'),
              ),
              MenuAction.divider(),
              MenuAction.search(onSearch: (context, val) {
                debugPrint('on search with $val');
              }),
              MenuAction.spacer(),
              MenuAction.text(
                text: 'text',
                onTap: (context) {
                  debugPrint('on tap text action');
                },
              ),
            ],
            child: Container(),
          ),
        ),
      ),
    );
  }
}
