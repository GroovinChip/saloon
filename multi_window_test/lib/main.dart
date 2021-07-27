import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multi_window/multi_widget.dart';
import 'package:multi_window/multi_window.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isMacOS) {
    MultiWindow.init(args);
    await MultiWindow.current.setTitle(MultiWindow.current.key);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Platform.isMacOS ? MultiWidget(
        {
          'settings_screen': SettingsScreen(),
        },
        fallback: HomeScreen(),
      ) : HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              if (Platform.isMacOS) {
                final window = await MultiWindow.create(
                  'settings_screen',
                  size: Size(300, 300),
                );
              }
              if (Platform.isIOS || Platform.isAndroid) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => SettingsScreen()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Screen'),
      ),
      body: Center(
        child: Text('Settings screen'),
      ),
    );
  }
}
