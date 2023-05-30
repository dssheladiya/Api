import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Api/ApiRoutes/api_routes.dart';
import 'Model/Response/product_response_model.dart';

class HOME_3 extends StatefulWidget {
  const HOME_3({Key? key}) : super(key: key);

  @override
  State<HOME_3> createState() => _HOME_3State();
}

class _HOME_3State extends State<HOME_3> {
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
    return Center(
      child: FutureBuilder<ProductResponseModel>(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SizedBox(
              height: 590,
              child: GridView.builder(
                itemCount: 30,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
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
                                  builder: (context) => Home_3ui(
                                      code: snapshot.data!.products[index].id),
                                ));
                          });
                        },
                        child: Container(
                          height: 220,
                          width: 200,
                          color: Colors.red,
                          child: Image.network(
                              snapshot.data!.products[index].thumbnail,
                              fit: BoxFit.cover),
                        ),
                      ),
                      Text(snapshot.data!.products[index].title,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 5),
                      Text("${snapshot.data!.products[index].price}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                    ],
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return const Text("wrong");
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
class Home_3ui extends StatefulWidget {
  const Home_3ui({Key? key, this.code}) : super(key: key);
  final code;
  @override
  State<Home_3ui> createState() => _Home_3uiState();
}

class _Home_3uiState extends State<Home_3ui> {
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
    return Center(
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
                          return SizedBox(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${snapshot.data!["title"]}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 13),
                      Text(
                        "${snapshot.data!["description"]}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 13),
                      Text(
                        "Price : \$${snapshot.data!["price"]}.00",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 13),
                      Text(
                        "Discount : ${snapshot.data!["discountPercentage"]}%",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 13),
                      Text(
                        "Rating : ${snapshot.data!["rating"]}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 13),
                      Text(
                        "Stock In : ${snapshot.data!["stock"]}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 13),
                      Text(
                        "Brand : ${snapshot.data!["brand"]}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 13),
                      Text(
                        "Category : ${snapshot.data!["category"]}",
                        style: const TextStyle(
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
    );
  }
}
