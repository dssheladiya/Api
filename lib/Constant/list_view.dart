import 'package:flutter/cupertino.dart';
import 'package:untitled3/Constant/color_helper.dart';

Expanded products() {
  return Expanded(
    child: ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          margin: EdgeInsets.all(10),
          color: kred,
        );
      },
    ),
  );
}
