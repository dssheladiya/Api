import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CategoriesController extends GetxController {
  String apiUrl = "https://dummyjson.com/products/categories";
  var isLoading = false.obs;
  var data;

  Future onInit() async {
    super.onInit();
    fetchData();
  }

  fetchData() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        log("===========body===========${response.body}");
        data = jsonDecode(response.body);
        log("===========data===========${data}");
      } else {
        log("===========Code===========${response.statusCode}");
      }
    } catch (e) {
      log('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }
}
