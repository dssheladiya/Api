import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/Controller/categorie_controller.dart';

class m extends StatefulWidget {
  const m({super.key});

  @override
  State<m> createState() => _mState();
}

class _mState extends State<m> {
  CategoriesController cat = Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    //print("+++++++++++++${cat.data}");
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40),
            SizedBox(
              height: 40,
              child: ListView.builder(
                itemCount: cat.data.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  print("======data======${cat.data}");
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 120,
                      margin: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade300,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blueGrey, width: 1),
                      ),
                      child: Center(
                        child: Text(
                          '${cat.data[index]}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
