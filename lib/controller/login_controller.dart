import 'dart:convert';

import 'package:fbsocial/model/article_model.dart';
import 'package:fbsocial/networking/api_endpoint.dart';
import 'package:fbsocial/networking/base_response.dart';
import 'package:fbsocial/networking/dio_service.dart';
import 'package:fbsocial/routes/app_routes.dart';
import 'package:fbsocial/utils/helper.dart';
import 'package:get/get.dart';

class LoginController extends GetxController with StateMixin<List<dynamic>> {
  var articleList = [].obs;

  void getArticle() {
    showLoader();
    DioService()
        .request(
            apiConfig: ApiConfigurator.basic,
            endPoint: ApiEndPoint.getService,
            method: Method.GET)
        .then(
      (res) {
        var baseRes = ArticleBaseResponse.fromJson(res.data);
        hideLoader();

        articleList.value = baseRes.articles!;

        if (baseRes.status == 'ok') {
          Get.toNamed(Routes.drawerAnimationPage);
        }
      },
      onError: (error) {
        hideLoader();
        showError(error.toString());
      },
    );
  }
}
