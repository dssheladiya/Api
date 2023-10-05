// To parse this JSON data, do
//
//     final selectDetailsrResponseModel = selectDetailsrResponseModelFromJson(jsonString);

import 'dart:convert';

List<SelectDetailsrResponseModel> selectDetailsrResponseModelFromJson(
        String str) =>
    List<SelectDetailsrResponseModel>.from(
        json.decode(str).map((x) => SelectDetailsrResponseModel.fromJson(x)));

String selectDetailsrResponseModelToJson(
        List<SelectDetailsrResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SelectDetailsrResponseModel {
  int id;
  Name? name;
  String email;
  Department? department;
  String? salary;
  Location? location;
  Dob? dob;

  SelectDetailsrResponseModel({
    required this.id,
    this.name,
    required this.email,
    this.department,
    this.salary,
    this.location,
    this.dob,
  });

  factory SelectDetailsrResponseModel.fromJson(Map<String, dynamic> json) =>
      SelectDetailsrResponseModel(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        email: json["email"],
        department: departmentValues.map[json["department"]]!,
        salary: json["salary"],
        location: locationValues.map[json["location"]]!,
        dob: dobValues.map[json["dob"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "email": email,
        "department": departmentValues.reverse[department],
        "salary": salary,
        "location": locationValues.reverse[location],
        "dob": dobValues.reverse[dob],
      };
}

enum Department { DB, PYTHON, REACT, UIUX }

final departmentValues = EnumValues({
  "db": Department.DB,
  "python": Department.PYTHON,
  "react": Department.REACT,
  "uiux": Department.UIUX
});

enum Dob { THE_1252022, THE_2621895 }

final dobValues =
    EnumValues({"12-5-2022": Dob.THE_1252022, "26-2-1895": Dob.THE_2621895});

enum Location { SURAT }

final locationValues = EnumValues({"surat": Location.SURAT});

enum Name {
  ADMIN,
  BENJAMIN,
  ELIJAH,
  HENRY,
  JAMES,
  JOHN,
  LUCAS,
  NOAH,
  OLIVER,
  THEODORE,
  WILLIAM
}

final nameValues = EnumValues({
  "admin": Name.ADMIN,
  "Benjamin": Name.BENJAMIN,
  "Elijah": Name.ELIJAH,
  "Henry": Name.HENRY,
  "James": Name.JAMES,
  "John": Name.JOHN,
  "Lucas": Name.LUCAS,
  "Noah": Name.NOAH,
  "Oliver": Name.OLIVER,
  "Theodore": Name.THEODORE,
  "William": Name.WILLIAM
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
