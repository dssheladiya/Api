import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ApiGridviewcoll.dart';

//Categories   see all

class HOME_2 extends StatefulWidget {
  const HOME_2({Key? key}) : super(key: key);

  @override
  State<HOME_2> createState() => _HOME_2State();
}

class _HOME_2State extends State<HOME_2> {
  var data;
  Future<List> getdata() async {
    http.Response response = await http.get(
      Uri.parse("https://dummyjson.com/products/categories"),
    );
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
    return Center(
      child: FutureBuilder<List>(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Home2(send: snapshot.data![index]),
                                ));
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 120,
                          margin: const EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade300,
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: Colors.blueGrey, width: 1),
                          ),
                          child: Center(
                            child: Text(
                              '${snapshot.data![index]}',
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
            );
          } else if (snapshot.hasError) {
            return Text("wrong");
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

//////////////////////////////
class Home2 extends StatefulWidget {
  const Home2({Key? key, this.send}) : super(key: key);
  final send;
  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  var Data1;
  Future<Map> getdata1() async {
    http.Response response1 = await http.get(
        Uri.parse("https://dummyjson.com/products/category/${widget.send}"));
    if (response1.statusCode == 200) {
      print("${response1.body}");
      Data1 = jsonDecode(response1.body);
    } else {
      print("${response1.statusCode}");
    }
    return Data1;
  }

  @override
  void initState() {
    getdata1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map>(
        future: getdata1(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // crossAxisSpacing: 10,
                  // mainAxisSpacing: 10,
                  childAspectRatio: 2 / 3.1),
              itemCount: snapshot.data!["products"].length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkResponse(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Ui(
                                  code: snapshot.data!["products"][index]["id"],
                                ),
                              ));
                        });
                      },
                      child: Container(
                        height: 220,
                        width: 200,
                        color: Colors.red,
                        child: Image.network(
                            snapshot.data!["products"][index]["thumbnail"],
                            fit: BoxFit.cover),
                      ),
                    ),
                    Text(
                      "${snapshot.data!["products"][index]["title"]}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
