// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

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
        textTheme: const TextTheme(
          displaySmall: TextStyle(fontSize: 18),
        ),
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
    final GlobalKey<ScaffoldState> key = GlobalKey();

    return Scaffold(
      key: key,
      drawer: const MenuDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => key.currentState?.openDrawer(),
      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return SafeArea(
      child: Container(
        color: theme.colorScheme.surface,
        width: size.width * 0.6,
        child: Center(
          child: AppMenu(
            exit: IconButton(
              icon: const Icon(
                Icons.close,
              ),
              onPressed: () => Scaffold.of(context).closeDrawer(),
            ),
            logout: MenuAction.text(
              text: 'logout',
              onTap: (context) {},
              icon: Icons.logout,
              textStyle: Theme.of(context).textTheme.displaySmall!,
            ),
            actions: [
              MenuAction.custom(
                builder: ((_) => const CircleAvatar(
                      radius: 50,
                      child: Center(
                        child: Text('JD'),
                      ),
                    )),
              ),
              MenuAction.text(
                text: 'dashboard',
                onTap: (context) {},
                icon: Icons.dashboard,
                textStyle: Theme.of(context).textTheme.displaySmall!,
              ),
              MenuAction.divider(
                indent: 16,
                endIndent: 16,
              ),
              MenuAction.text(
                text: 'List',
                onTap: (context) {},
                icon: Icons.list,
                textStyle: Theme.of(context).textTheme.displaySmall!,
              ),
              MenuAction.text(
                text: 'settings',
                onTap: (context) {},
                textStyle: Theme.of(context).textTheme.displaySmall!,
              ),
            ],
            child: Container(),
          ),
        ),
      ),
    );
  }
}
