import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class CategoryName extends StatefulWidget {
  const CategoryName({Key? key}) : super(key: key);

  @override
  State<CategoryName> createState() => _CategoryNameState();
}

class _CategoryNameState extends State<CategoryName> {
  Future<dynamic> getData() async {
    http.Response response = await http.get(Uri.parse(
      "https://lokdayro.in/AndroidClass/user/get_all_events.php?",
    ));
    if (response.statusCode == 200) {
      log(response.body);
      var data = jsonDecode(response.body);
      return data;
    } else {
      log('${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<dynamic>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final data = snapshot.data;
                return Center(
                  child: Column(
                    children: List.generate(1, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          height: 460,
                          width: 380,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xffFFB600),
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.02,
                                      horizontal: width * 0.05),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(data['all_event'][0]['categoryname'],
                                          style: FontTestStyle.kBlack18Bold),
                                      Text(
                                          data['all_event'][0]
                                              ['event_name_hindi'],
                                          style: FontTestStyle.kBlack18Bold),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: width * 0.06,
                                    left: width * 0.06,
                                    top: height * 0.02),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xffEEF3F7),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: height * 0.02),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                            data['all_event'][0]
                                                ['organized_event_date'],
                                            style: FontTestStyle.kGrey18Bold),
                                        Text(
                                            data['all_event'][0]
                                                ['organized_event_time'],
                                            style: FontTestStyle.kGrey18Bold),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                      data['all_event'][0]['all_artiest']
                                          .length, (index) {
                                    return Column(
                                      children: [
                                        InkResponse(
                                          onTap: () {
                                            // Get.to();
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            height: 170,
                                            width: 170,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                  data['all_event'][0]
                                                          ['all_artiest'][index]
                                                      ['artiest_image'],
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: height * 0.01),
                                        Text(
                                            data['all_event'][0]['all_artiest']
                                                    [index]
                                                ['artiest_name_gujarati'],
                                            style: FontTestStyle.kBlack18Bold),
                                        Text(
                                            data['all_event'][0]['all_artiest']
                                                [index]['artist_type'],
                                            style: FontTestStyle.kGrey18Bold),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                              const Spacer(),
                              Center(
                                child: Container(
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffFFB600),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                        data['all_event'][0]
                                            ['organized_event_address'],
                                        style: FontTestStyle.kBlack18Bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}

class FontTestStyle {
  static const TextStyle kBlack18Bold = TextStyle(
    color: Colors.black,
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle kGrey18Bold = TextStyle(
    color: Color(0xff6B6C6E),
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}
