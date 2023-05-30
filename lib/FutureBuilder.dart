import 'package:flutter/material.dart';

class futurebuilderdemo extends StatefulWidget {
  const futurebuilderdemo({Key? key}) : super(key: key);

  @override
  State<futurebuilderdemo> createState() => _futurebuilderdemoState();
}

class _futurebuilderdemoState extends State<futurebuilderdemo> {
  Future future() async {
    await Future.delayed(const Duration(seconds: 3));
    return 20;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: future(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text("${snapshot.data}");
              } else if (snapshot.hasError) {
                return const Text("Somthing went wrong");
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
