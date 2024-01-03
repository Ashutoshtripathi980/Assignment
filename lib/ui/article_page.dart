import 'package:fbsocial/controller/login_controller.dart';
import 'package:fbsocial/utils/app_assets.dart';
import 'package:fbsocial/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticlePage extends StatelessWidget {
  final int index;
  ArticlePage({super.key, required this.index});

  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Color color1 = HexColor.fromHex('#f2f2f2');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: Get.height - 110,
                  child: Image.network(
                      "${loginController.articleList[index]['urlToImage']}",
                      fit: BoxFit.fill,
                      scale: 2, errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppAssets.placeHolder,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  }),
                ),
                Positioned.fill(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black
                            .withOpacity(0.9), // Adjust opacity as needed
                      ],
                    ),
                  ),
                )),
                Positioned(
                  height: 300,
                  bottom: 10,
                  left: 10,
                  child: SizedBox(
                    width: Get.width - 80,
                    height: 150.0,
                    child: Text(
                      softWrap: false,
                      '${loginController.articleList[index]['content']}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: color1, fontSize: 24),
                    ),
                  ),
                ),
                Positioned(
                    height: 140,
                    bottom: 10,
                    left: 10,
                    child: Text(
                      '${loginController.articleList[index]['source']['name']}',
                      style: TextStyle(
                        color: HexColor.fromHex("#bababa"),
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    )),
                Positioned(
                  height: 100,
                  bottom: 10,
                  left: 10,
                  child: SizedBox(
                    width: Get.width - 80,
                    height: 150.0,
                    child: Text(
                      softWrap: false,
                      '${loginController.articleList[index]['description']}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: color1,
                          fontSize: 16,
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
