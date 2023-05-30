import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class POSTapiDemo_1 extends StatefulWidget {
  const POSTapiDemo_1({Key? key}) : super(key: key);

  @override
  State<POSTapiDemo_1> createState() => _POSTapiDemo_1State();
}

class _POSTapiDemo_1State extends State<POSTapiDemo_1> {
  var Data;

  bool loading = false;
  Future getData(title) async {
    var body = {"title": "$title"};
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
          : SafeArea(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 60,
                      width: 350,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black54)),
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                            hintText: "Enter data",
                            suffixIcon: Icon(Icons.search),
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkResponse(
                    onTap: () {
                      setState(() {
                        getData(controller.text);
                      });
                    },
                    child: const Center(
                      child: CircleAvatar(radius: 30),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
