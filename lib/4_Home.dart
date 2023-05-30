import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ApiGridviewcoll.dart';

// All Categories   see all

class HOME_4 extends StatefulWidget {
  const HOME_4({Key? key}) : super(key: key);

  @override
  State<HOME_4> createState() => _HOME_4State();
}

class _HOME_4State extends State<HOME_4> {
  var Data;
  Future<List> getadata() async {
    http.Response response = await http.get(
      Uri.parse("https://dummyjson.com/products/categories"),
    );
    if (response.statusCode == 200) {
      print("${response.body}");
      Data = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
    }
    return Data;
  }

  @override
  void initState() {
    getadata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List>(
          future: getadata(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        InkResponse(
                          onTap: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Icon(Icons.arrow_back, size: 30),
                        ),
                        SizedBox(width: 90),
                        Text(
                          "Categories",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    children: List.generate(
                      20,
                      (index) => InkResponse(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    categories(one: snapshot.data![index]),
                              ),
                            );
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 170,
                          decoration: BoxDecoration(
                            color: Colors.teal.shade400,
                            border:
                                Border.all(color: Colors.blueGrey, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Center(
                            child: Text(
                              "${snapshot.data![index]}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("wrong");
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

///////
class categories extends StatefulWidget {
  const categories({Key? key, this.one}) : super(key: key);
  final one;
  @override
  State<categories> createState() => _categoriesState();
}

class _categoriesState extends State<categories> {
  var Data1;
  Future<Map> getdata1() async {
    http.Response response = await http.get(
      Uri.parse('https://dummyjson.com/products/category/${widget.one}'),
    );
    if (response.statusCode == 200) {
      print("${response.body}");
      Data1 = jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
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
      body: Center(
        child: SafeArea(
          child: FutureBuilder<Map>(
            future: getdata1(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GridView.builder(
                  itemCount: snapshot.data!["products"].length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2 / 3.3),
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
                                      code: snapshot.data!['products'][index]
                                          ['id']),
                                ),
                              );
                            });
                          },
                          child: Container(
                            height: 220,
                            width: 180,
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Image.network(
                                snapshot.data!['products'][index]["thumbnail"],
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${snapshot.data!["products"][index]["title"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          "Price : ${snapshot.data!["products"][index]["price"]}.00",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
