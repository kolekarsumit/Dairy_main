
import 'package:dairy/Screens/front.dart';
import 'package:flutter/material.dart';

import 'Admin/Admin_pannel/Admin_View.dart';
import 'Admin/Background/BackgroundScreen.dart';
import 'Admin/Background/image_change.dart';

import 'Screens/thanks.dart';
import 'Screens/third.dart';
import 'Widgets/waterfillanimation.dart';
import 'bluetooth_service/services/blue_services.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
BlueServices blueServices=BlueServices();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Front_(),
    );
  }
}

