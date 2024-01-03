import 'package:fbsocial/controller/login_controller.dart';
import 'package:fbsocial/ui/article_page.dart';
import 'package:fbsocial/utils/app_assets.dart';
import 'package:fbsocial/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customListTile(BuildContext context, index) {
  final Color color1 = HexColor.fromHex('#f2f2f2');
  final LoginController loginController = Get.find();

  return InkWell(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ArticlePage(index: index)));
    },
    child: Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      80.0), // Adjust the radius as needed
                ),
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.network(
                      "${loginController.articleList[index]['urlToImage']}",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppAssets.placeHolder,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  }),
                ),
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
                      Colors.black.withOpacity(0.9), // Adjust opacity as needed
                    ],
                  ),
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
                    '${loginController.articleList[index]['content']}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: color1, fontSize: 18),
                  ),
                ),
              ),
              Positioned(
                  height: 20,
                  bottom: 10,
                  left: 10,
                  child: Text(
                    '${loginController.articleList[index]['source']['name']}',
                    style: TextStyle(
                      color: HexColor.fromHex("#bababa"),
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ))
            ],
          )
        ],
      ),
    ),
  );
}
