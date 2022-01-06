import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_provider/provider/user_state.dart';
import 'screens/userpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: MultiProvider(
          providers: [ChangeNotifierProvider(create: (ctx) => UserState())],
          builder: (context, child) => const Userpage(),
        ));
  }
}
