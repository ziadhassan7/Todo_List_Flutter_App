import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/controller/provider/pick_date_provider.dart';
import 'package:todo_list_app/controller/provider/refresh_items_provider.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RefreshItemsProvider()),
        ChangeNotifierProvider(create: (context) => PickDateProvider(),)
      ],
      child: MaterialApp(
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
          primarySwatch: Colors.orange,
        ),
        home: HomeScreen(appTile: 'Tasker'),
      ),
    );
  }
}



/* in MaterialApp()
theme: ThemeData.dark().copyWith(
          primaryColor: Colors.orange
        )
 */
