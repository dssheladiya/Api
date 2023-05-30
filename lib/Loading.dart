import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LOADINGdemo extends StatefulWidget {
  const LOADINGdemo({Key? key}) : super(key: key);

  @override
  State<LOADINGdemo> createState() => _LOADINGdemoState();
}

class _LOADINGdemoState extends State<LOADINGdemo> {
  var data;
  bool loading = false;
  Future getdata() async {
    setState(() {});
    loading = true;
    http.Response response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    if (response.statusCode == 200) {
      print("${response.body}");
      data = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
    }
    setState(() {});
    loading = false;
    return data;
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading == true
          ? Center(child: const CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.blueGrey,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("${data[index]}"),
                );
              },
            ),
    );
  }
}
