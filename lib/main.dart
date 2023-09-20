import 'dart:async';

import 'package:botanika/main_provider.dart';
import 'package:botanika/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MainProvider())
    ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
        return  StreamBuilder(
          stream: ThemeStream.setTheme.stream,
          initialData: false,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return FutureBuilder(
              future: mainProvider.getDarkMode(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  darkTheme: ThemeData.dark(),
                  themeMode: snapshot.data == true ? ThemeMode.dark : ThemeMode.light,
                  home: const HomePage(),
                );
              },
            );
          },
        );
  }
}

class ThemeStream{
  static StreamController<bool> setTheme = StreamController();
}

