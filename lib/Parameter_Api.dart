import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class parameterdemo extends StatefulWidget {
  const parameterdemo({Key? key}) : super(key: key);

  @override
  State<parameterdemo> createState() => _parameterdemoState();
}

class _parameterdemoState extends State<parameterdemo> {
  var data;

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
                    child: Center(
                      child: InkResponse(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PARAMETERdemo(
                                    id: data[index]["id"],
                                  ),
                                ));
                          });
                        },
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          color: Colors.deepOrangeAccent.shade100,
                          child: Center(
                            child: Text("${data[index]["id"]}"),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
class PARAMETERdemo extends StatefulWidget {
  const PARAMETERdemo({Key? key, this.id}) : super(key: key);
  final id;

  @override
  State<PARAMETERdemo> createState() => _PARAMETERdemoState();
}

class _PARAMETERdemoState extends State<PARAMETERdemo> {
  Map<String, dynamic> data = {};

  Future<Map> getdata() async {
    http.Response response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/todos/${widget.id}'));
    if (response.statusCode == 200) {
      print("${response.body}");
      data = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
    }
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
      body: SafeArea(
        child: FutureBuilder<Map>(
          future: getdata(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  Text("${snapshot.data!["UserId"]}"),
                  Text("${snapshot.data!["id"]}"),
                  Text("${snapshot.data!["title"]}"),
                  Text("${snapshot.data!["completed"]}"),
                ],
              );
            } else {
              return Center(child: const CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
