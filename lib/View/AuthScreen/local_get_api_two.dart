import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'local_get_api_one.dart';

class GetApiTwo extends StatefulWidget {
  const GetApiTwo({Key? key}) : super(key: key);
  @override
  State<GetApiTwo> createState() => _GetApiTwoState();
}

class _GetApiTwoState extends State<GetApiTwo> {
  final ApiController controller = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Call and Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                controller.filterData(value);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Search Name...',
                suffixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.dataListApi.length,
                itemBuilder: (context, index) {
                  final obj = controller.dataListApi[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(color: Colors.amber, spreadRadius: 2)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Row(children: [
                            const Text("Id :", style: TextStyle(fontSize: 18)),
                            Text(' ${obj['id'] ?? "--"}',
                                style: buildTextStyle()),
                          ]),
                          const SizedBox(height: 8),
                          Row(children: [
                            const Text("Name :",
                                style: TextStyle(fontSize: 18)),
                            Text(' ${obj['name'] ?? "--"}',
                                style: buildTextStyle()),
                          ]),
                          const SizedBox(height: 8),
                          Row(children: [
                            const Text("Email :",
                                style: TextStyle(fontSize: 18)),
                            Text(' ${obj['email'] ?? "--"}',
                                style: buildTextStyle()),
                          ]),
                          const SizedBox(height: 8),
                          Row(children: [
                            const Text("Department :",
                                style: TextStyle(fontSize: 18)),
                            Text(' ${obj['department'] ?? "--"}',
                                style: buildTextStyle()),
                          ]),
                          const SizedBox(height: 8),
                          Row(children: [
                            const Text("Salary :",
                                style: TextStyle(fontSize: 18)),
                            Text(' ${obj['salary'] ?? "--"}',
                                style: buildTextStyle()),
                          ]),
                          const SizedBox(height: 8),
                          Row(children: [
                            const Text("Location :",
                                style: TextStyle(fontSize: 18)),
                            Text(' ${obj['location'] ?? "--"}',
                                style: buildTextStyle()),
                          ]),
                          const SizedBox(height: 8),
                          Row(children: [
                            const Text("Dob :", style: TextStyle(fontSize: 18)),
                            Text(' ${obj['dob'] ?? "--"}',
                                style: buildTextStyle()),
                          ]),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle buildTextStyle() {
    return const TextStyle(fontSize: 18, color: Colors.deepOrange);
  }
}
