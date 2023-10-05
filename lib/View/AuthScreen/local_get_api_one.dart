import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiController extends GetxController {
  RxList<dynamic> dataList = [].obs;
  RxList<dynamic> dataListApi = [].obs;

  //RxList<dynamic> daList = ['email', 'name', 'department', 'location'].obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.0.91:5555/account/select_details'),
      );
      if (response.statusCode == 200) {
        dataList.value = json.decode(response.body);
        dataListApi.value = dataList;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void filterData(String searchText) {
    dataListApi.value = dataList
        .where((item) => item['email'].toString().contains(searchText))
        .toList();
  }

// List<String> abc = ['email', 'name', 'department', 'location'];
// Iterable<String> filteredStrings = abc.where((item) {
//   return item.length == 3;
// });
}
