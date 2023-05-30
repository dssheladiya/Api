import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Api/ApiRoutes/api_routes.dart';
import 'Model/Response/product_response_model.dart';

class Apigridviewcolldemo extends StatefulWidget {
  const Apigridviewcolldemo({Key? key}) : super(key: key);

  @override
  State<Apigridviewcolldemo> createState() => _ApigridviewcolldemoState();
}

class _ApigridviewcolldemoState extends State<Apigridviewcolldemo> {
  var data;
  ProductResponseModel? productResponseModel;

  Future<ProductResponseModel> getdata() async {
    http.Response response = await http.get(Uri.parse('${ApiRoutes.products}'));
    if (response.statusCode == 200) {
      productResponseModel = productResponseModelFromJson(response.body);
    } else {
      print("${response.statusCode}");
    }
    return productResponseModel!;
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder<ProductResponseModel>(
            future: getdata(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GridView.builder(
                  itemCount: 30,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // crossAxisSpacing: 10,
                    // mainAxisSpacing: 10,
                    childAspectRatio: 2 / 3.1,
                  ),
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
                                        code:
                                            snapshot.data!.products[index].id),
                                  ));
                            });
                          },
                          child: Container(
                            height: 220,
                            width: 200,
                            color: Colors.red,
                            child: Image.network(
                                snapshot.data!.products[0].thumbnail,
                                fit: BoxFit.cover),
                          ),
                        ),
                        Text("${snapshot.data!.products[0].title}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 5),
                        Text("${snapshot.data!.products[0].price}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500)),
                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return const Text("wrong");
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
class Ui extends StatefulWidget {
  const Ui({Key? key, this.code}) : super(key: key);
  final code;
  @override
  State<Ui> createState() => _UiState();
}

class _UiState extends State<Ui> {
  var data1;
  Future<Map> getdata1() async {
    http.Response response1 = await http
        .get(Uri.parse('https://dummyjson.com/products/${widget.code}'));
    if (response1.statusCode == 200) {
      data1 = jsonDecode(response1.body);
    } else {
      print("${response1.statusCode}");
    }
    return data1;
  }

  @override
  void initState() {
    getdata1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder<Map>(
            future: getdata1(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 450,
                          child: PageView.builder(
                            itemCount: snapshot.data!["images"].length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 450,
                                width: 400,
                                child: Image.network(
                                    snapshot.data!['images'][index],
                                    fit: BoxFit.cover),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.data!["title"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 13),
                          Text(
                            "${snapshot.data!["description"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 13),
                          Text(
                            "Price : \$${snapshot.data!["price"]}.00",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 13),
                          Text(
                            "Discount : ${snapshot.data!["discountPercentage"]}%",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 13),
                          Text(
                            "Rating : ${snapshot.data!["rating"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 13),
                          Text(
                            "Stock In : ${snapshot.data!["stock"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 13),
                          Text(
                            "Brand : ${snapshot.data!["brand"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 13),
                          Text(
                            "Category : ${snapshot.data!["category"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return const Text("wrong");
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
