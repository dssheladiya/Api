import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '2_Home.dart';
import '3_Home.dart';
import '4_Home.dart';

class Home_1 extends StatefulWidget {
  const Home_1({Key? key}) : super(key: key);

  @override
  State<Home_1> createState() => _Home_1State();
}

class _Home_1State extends State<Home_1> {
  var Data;
  bool loading = false;
  bool isSearching = false;

  Future getData() async {
    setState(() {
      loading = true;
    });
    http.Response response = await http.get(Uri.parse(
        "https://dummyjson.com/products/categories/search?q=${Details.text}"));
    if (response.statusCode == 200) {
      print("${response.body}");
      Data = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  TextEditingController Details = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (isSearching) {
          isSearching = false;
          setState(() {});
          return Future(() => false);
        } else {
          return Future(() => true);
        }
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Center(
                  child: TextField(
                    onTap: () {
                      isSearching = true;
                      setState(() {});
                    },
                    controller: Details,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      constraints: BoxConstraints(maxWidth: 350),
                      hintText: "Search Product..",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Colors.blueGrey, width: 1.5)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Colors.blueGrey, width: 1.5)),
                      suffixIcon: IconButton(
                        onPressed: () {
                          getData();
                        },
                        icon: Icon(Icons.search, size: 30),
                      ),
                    ),
                  ),
                ),
                isSearching
                    ? Data != null
                        ? loading
                            ? CircularProgressIndicator()
                            : GridView.builder(
                                scrollDirection: Axis.vertical,
                                physics: BouncingScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2 / 3.5,
                                  // crossAxisSpacing: 10,
                                  //mainAxisSpacing: 10,
                                ),
                                shrinkWrap: true,
                                itemCount: Data["products"].length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Home_3ui(
                                                    code: Data["products"]
                                                        [index]["id"]),
                                              ),
                                            );
                                          });
                                        },
                                        child: Container(
                                          height: 200,
                                          width: 180,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 20),
                                          child: Image.network(
                                            Data["products"][index]
                                                ["thumbnail"],
                                            fit: BoxFit.cover
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${Data["products"][index]["title"]}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "Price : \$${Data["products"][index]["price"]}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ],
                                  );
                                },
                              )
                        : const Center(
                            child: Center(child: Text('Data not found')),
                          )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Text(
                                  "Categories",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HOME_4(),
                                      ),
                                    );
                                  });
                                },
                                child: const Text(
                                  "See all",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black38),
                                ),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                          const SizedBox(height: 10),
                          HOME_2(),
                          const SizedBox(height: 30),
                          HOME_3(),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
