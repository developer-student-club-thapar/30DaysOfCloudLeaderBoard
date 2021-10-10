import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcloud_leaderboard/Models/auth.dart';
import 'package:gcloud_leaderboard/Models/user.dart';
import 'package:gcloud_leaderboard/UI/Screens/homescreen.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserData()),
        ChangeNotifierProvider.value(value: Auth())
      ],
      child: MaterialApp(
       
        home: HomeScreen(),
      ),
    );
  }
}

