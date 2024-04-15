import 'package:flutter/material.dart';
import 'package:untitled3/1_Home.dart';
import 'package:untitled3/WebSocket.dart';

import 'ApiGridviewcoll.dart';
import 'api_textfield.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Api",
      debugShowCheckedModeBanner: false,
      home: Home_1(),
    );
  }
}
//REST APIs
//SOAP APIs
//RPC APIs
//GraphQL APIs
