import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> registerAccount() async {
    const String apiUrl = "http://192.168.0.91:5555/account/register";
    final Map<String, dynamic> requestData = {
      "mobile": mobileController.text,
      "email": emailController.text,
      "password": passwordController.text,
    };
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
        body: jsonEncode(requestData),
      );
      var data = jsonDecode(response.body);
      log("==Register Account=++${response.body}");
      log("====+Register Account++++++++${response.statusCode}");
      if (response.statusCode == 200) {
        log(" Registration successful");
      } else {
        log(" Registration failed: ${response.statusCode}");
      }
    } catch (e) {
      log("Error during API call: $e");
    }
  }
}
