import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class POSTApiDemo extends StatefulWidget {
  const POSTApiDemo({Key? key}) : super(key: key);

  @override
  State<POSTApiDemo> createState() => _POSTApiDemoState();
}

class _POSTApiDemoState extends State<POSTApiDemo> {
  var Data;
  var body = {"title": "denish"};
  bool loading = false;
  Future getData(title) async {
    setState(() {});
    loading = true;
    http.Response response = await http
        .post(Uri.parse('https://dummyjson.com/products/add'), body: body);
    if (response.statusCode == 200) {
      print("${response.body}");
      Data = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
    }
    setState(() {});
    loading = false;
    return Data;
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading == true
          ? const Center(child: CircularProgressIndicator())
          : InkResponse(
              onTap: () {
                setState(() {
                  getData(body);
                });
              },
              child: const Center(
                child: CircleAvatar(radius: 30),
              ),
            ),
    );
  }
}
