import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PUTApidemo extends StatefulWidget {
  const PUTApidemo({Key? key}) : super(key: key);

  @override
  State<PUTApidemo> createState() => _PUTApidemoState();
}

class _PUTApidemoState extends State<PUTApidemo> {
  bool loading = false;
  var body = {"title": "soni", "price": "250", "stock": "200"};

  Future getData(title) async {
    setState(() {
      loading = true;
    });
    http.Response response = await http
        .put(Uri.parse("https://dummyjson.com/products/1"), body: title);
    if (response.statusCode == 200) {
      print("${response.body}");
    } else {
      print("${response.statusCode}");
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Put Api"))),
      body: loading == true
          ? Center(child: const CircularProgressIndicator())
          : InkResponse(
              onTap: () {
                setState(() {
                  getData(body);
                });
              },
              child: const Center(
                child: CircleAvatar(
                  radius: 35,
                ),
              ),
            ),
    );
  }
}
