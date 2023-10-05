import 'dart:convert';
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
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        print(" Registration successful");
      } else {
        print(" Registration failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Error during API call: $e");
    }
  }
}
