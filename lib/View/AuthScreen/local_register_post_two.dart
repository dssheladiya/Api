import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'local_register_post_one.dart';

class RegisterPostApiTwo extends StatefulWidget {
  const RegisterPostApiTwo({Key? key}) : super(key: key);

  @override
  State<RegisterPostApiTwo> createState() => _RegisterPostApiTwoState();
}

class _RegisterPostApiTwoState extends State<RegisterPostApiTwo> {
  RegisterController registerController = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register ")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: registerController.mobileController,
              decoration: const InputDecoration(labelText: "Mobile"),
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: registerController.emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              controller: registerController.passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              // obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => registerController.registerAccount(),
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
