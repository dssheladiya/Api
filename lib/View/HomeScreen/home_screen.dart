import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/Constant/list_view.dart';
import 'package:untitled3/Controller/controller.dart';

import 'Widgets/common_button.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  Future<int> getData() async {
    await Future.delayed(const Duration(seconds: 2));
    return 10;
  }

  CounterController _controller = Get.put(CounterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text("${snapshot.data}");
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            const SizedBox(height: 30),
            GetBuilder<CounterController>(
              builder: (controller) => Text(controller.counter.toString()),
            ),
            commonButton('LOGIN', () {
              _controller.increment();
            }, 65),
            const SizedBox(height: 30),
            // commonButton("register", () {}, 65),
            products(),
          ],
        ),
      ),
    );
  }
}
