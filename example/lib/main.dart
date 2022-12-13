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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: size.height - (MediaQuery.of(context).padding.top * 2),
                width: size.width * 0.85,
                child: AppMenu(
                  exit: IconButton(
                    icon: const Icon(
                      Icons.close,
                    ),
                    onPressed: () {},
                  ),
                  logout: MenuAction.text(
                    text: 'logout',
                    onTap: (context) {},
                    icon: Icons.logout,
                    textStyle: Theme.of(context).textTheme.headline3!,
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
                      textStyle: Theme.of(context).textTheme.headline3!,
                    ),
                    MenuAction.divider(),
                    MenuAction.text(
                      text: 'List',
                      onTap: (context) {},
                      icon: Icons.list,
                      textStyle: Theme.of(context).textTheme.headline3!,
                    ),
                    MenuAction.text(
                      text: 'settings',
                      onTap: (context) {},
                      textStyle: Theme.of(context).textTheme.headline3!,
                    ),
                  ],
                  child: Container(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
