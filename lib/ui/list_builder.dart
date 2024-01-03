import 'dart:ffi';

import 'package:fbsocial/controller/login_controller.dart';
import 'package:fbsocial/ui/custom_tile_bar.dart';
import 'package:fbsocial/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListBuilder extends StatelessWidget {
  ListBuilder({super.key});

  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 20,
          color: HexColor.fromHex("#464646"),
        ),
        Container(
          height: Get.height - 110,
          color: HexColor.fromHex("#464646"),
          child: ListView.builder(
            itemCount: loginController.articleList.length,
            itemBuilder: (context, index) => customListTile(context, index),
          ),
        ),
      ],
    ));
  }
}
