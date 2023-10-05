import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class apiDemo extends StatefulWidget {
  const apiDemo({Key? key}) : super(key: key);

  @override
  State<apiDemo> createState() => _apiDemoState();
}

class _apiDemoState extends State<apiDemo> {
  Future getdeta() async {
    http.Response response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/todos/'),
    );
    if (response.statusCode == 200) {
      print("Api response${response.body}");
    } else {
      print("${response.statusCode}");
    }
  }

  @override
  void initState() {
    getdeta();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const Column(children: []);
          } else {
            return const CircularProgressIndicator();
          }
        }, future: null,
      ),
    );
  }
}
