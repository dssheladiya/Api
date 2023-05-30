import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class simpledemo extends StatefulWidget {
  const simpledemo({Key? key}) : super(key: key);

  @override
  State<simpledemo> createState() => _simpledemoState();
}

class _simpledemoState extends State<simpledemo> {
  // Future getdata() async {
  //   http.Response response =
  //       await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
  //   if (response.statusCode == 200) {
  //     data = jsonDecode(response.body);
  //     return data;
  //   } else {
  //     print("${response.statusCode}");
  //   }
  // }
  Future getdata() async {
    http.Response response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      print("${response.statusCode}");
    }
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  var data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getdata(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      color: Colors.deepOrangeAccent.shade100,
                      child: Column(
                        children: [
                          Text("${data[index]}"),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
