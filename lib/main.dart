import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settyl_intern/Provider/location_provider.dart';
import 'package:settyl_intern/Screen/googlemappage.dart';
import './Screen/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => LocationProvider(),
        child: GoogleMapPage(),
      )
    ], child: MaterialApp(debugShowCheckedModeBanner: false, home: Signin()));
  }
}
