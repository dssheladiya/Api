import 'dart:async';

import 'package:flutter/material.dart';

class streambuilredemo extends StatefulWidget {
  const streambuilredemo({Key? key}) : super(key: key);

  @override
  State<streambuilredemo> createState() => _streambuilredemoState();
}

class _streambuilredemoState extends State<streambuilredemo> {
  StreamController<int> counte = StreamController();

  int Data = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counte.sink.add(1);
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: StreamBuilder(
              stream: counte.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Data = Data + snapshot.data!;
                  return Text("$Data");
                } else if (snapshot.hasError) {
                  return const Text("invalid");
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
