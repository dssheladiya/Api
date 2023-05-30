import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DELETEApidemo extends StatefulWidget {
  const DELETEApidemo({Key? key}) : super(key: key);

  @override
  State<DELETEApidemo> createState() => _DELETEApidemoState();
}

class _DELETEApidemoState extends State<DELETEApidemo> {
  bool lodding = false;
  var body = {"title": "Nikuj", "price": "deep", "stock": "jaydeep"};
  var data;

  Future getdata(title) async {
    setState(() {
      lodding = true;
    });
    http.Response response = await http.delete(Uri.parse(
      'https://dummyjson.com/products/1',
    ));
    if (response.statusCode == 200) {
      print("${response.body}");
      data = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
    }
    setState(() {
      lodding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: lodding == true
            ? Center(child: CircularProgressIndicator())
            : InkResponse(
                onTap: () {
                  setState(() {
                    getdata(body);
                  });
                },
                child: CircleAvatar(radius: 35),
              ),
      ),
    );
  }
}
