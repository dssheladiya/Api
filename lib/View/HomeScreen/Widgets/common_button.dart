import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/Constant/text_style.dart';

Widget commonButton(String title, Function() onTap, double height) {
  return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.blueGrey.shade200),
        child: Center(
            child: Text(
          title,
          style: Kred22w700,
        )),
      ));
}
