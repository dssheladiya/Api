// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) =>
    json.encode(data.toJson());

class RegisterResponseModel {
  String email;
  String password;
  String mobile;

  RegisterResponseModel({
    required this.email,
    required this.password,
    required this.mobile,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
        email: json["email"],
        password: json["password"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "mobile": mobile,
      };
}
