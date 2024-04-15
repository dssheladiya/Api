// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
//
// class ShimmerDemo extends StatefulWidget {
//   const ShimmerDemo({Key? key}) : super(key: key);
//
//   @override
//   State<ShimmerDemo> createState() => _ShimmerDemoState();
// }
//
// class _ShimmerDemoState extends State<ShimmerDemo> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(
//             width: 200.0,
//             height: 100.0,
//             child: Shimmer.fromColors(
//               baseColor: Colors.red,
//               highlightColor: Colors.yellow,
//               child: const Text(
//                 'Shimmer',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'a.dart';
import 'b.dart';

class MyHomage extends StatefulWidget {
  const MyHomage({super.key});

  @override
  State<MyHomage> createState() => _MyHomageState();
}

class _MyHomageState extends State<MyHomage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: const Text('Loading List'),
              onTap: () {
                Get.to(LoadingListPage());
              },
            ),
            ListTile(
              title: const Text('Slide To Unlock'),
              onTap: () {
                Get.to(SlideToUnlockPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
