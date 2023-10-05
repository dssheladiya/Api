import 'package:flutter/material.dart';
import 'package:untitled3/GetApi.dart';
import 'package:untitled3/PostApi_Demo.dart';
import 'package:untitled3/View/AuthScreen/local_register_post_two.dart';

import '1_Home.dart';
import 'LoadingShimmer.dart';
import 'View/AuthScreen/local_get_api_two.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Api",
      debugShowCheckedModeBanner: false,
      home: MyHomage(),
    );
  }
}
//REST APIs
//SOAP APIs
//RPC APIs
//GraphQL APIs
