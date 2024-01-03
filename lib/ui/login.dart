import 'package:fbsocial/controller/login_controller.dart';
import 'package:fbsocial/custom_widget/gradient_button_widget.dart';
import 'package:fbsocial/services/firebaseservices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Assignment")),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Text(
                  'Documentation says..\nFor testing facebook integration, you have to make the application live.',
                  style: TextStyle(letterSpacing: 3),
                ),
              ),
              Lottie.network(
                  "https://assets6.lottiefiles.com/private_files/lf30_jo7huq2d.json",
                  height: 350,
                  width: 350),
            ],
          ),
          GradientButton(
              onTap: () {
                signInWithFacebook();
              },
              text: "Login WIth FaceBook"),
          const SizedBox(height: 30),
          GradientButton(
              onTap: () {
                loginController.getArticle();
              },
              text: "Direct login"),
        ],
      ),
    );
  }
}
