import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/pages/homePage.dart';
import 'package:labs_technical_test/provider/repoProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: RepoProvider()),
        ],
        child: MaterialApp(
          title: '390 labs test',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage(),
        ));
  }
}
