import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fbsocial/routes/app_routes.dart';
import 'package:fbsocial/utils/helper.dart';
import 'package:get/get.dart' as gt;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../utils/app_config.dart';
import '../utils/my_preference.dart';
import 'dart:developer' as developer;

enum Method { POST, GET, PUT, DELETE, PATCH }

enum ApiConfigurator { basic, none }

class DioService {
  Dio? _dio;
  Dio? _dioDownloader;

  static final DioService _dioService = DioService._internal();

  factory DioService() {
    return _dioService;
  }

  DioService._internal();

  Map<String, String> header = {"Content-Type": "application/json"};

  Future<DioService> init({customBaseUrl, isHeaderRequired}) async {
    _dio = Dio(
      BaseOptions(
          headers: header,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
    (_dio?.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    initInterceptors();
    _dioDownloader = Dio();
    return this;
  }

  ///
  /// this method is used to intercept the request and response.
  ///
  void initInterceptors() {
    // //print(MyPref().token.val.toString());
    _dio!.interceptors.add(PrettyDioLogger());
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          if (MyPref().token.val.isNotEmpty) {
            requestOptions.headers.putIfAbsent(
              'token',
              () => MyPref().token.val.toString(),
            );
          }
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          // final baseRes = response.data;
          // if (baseRes['code'].toString() == "401") {
          //   showError(
          //     "Session Expired!",
          //     "Your session expired! Please Login again.",
          //   );
          //   GetRoute.Get.offAllNamed(Routes.emailLogin);
          // }
          return handler.next(response);
        },
        onError: (err, handler) {
          return handler.next(err);
        },
      ),
    );
  }

  ///
  /// This method is used to request the data using
  /// base url + endpoint and configuration provided.
  ///
  Future<dynamic> uploadDocuments(
      {required ApiConfigurator apiConfig,
      required String endPoint,
      required Method method,
      Map<String, dynamic>? params,
      required File file}) async {
    String url = "";
    switch (apiConfig) {
      case ApiConfigurator.basic:
        url = AppConfig().baseUrl + endPoint;
        break;
      case ApiConfigurator.none:
        url = endPoint;
        break;
    }
    Response response;
    String fileName = file.path.split('/').last;
    var extension = getExtensionName(fileName);
    //print(fileName);
    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(file.path,
            filename: fileName,
            contentType: extension == "pdf"
                ? MediaType('file', 'pdf')
                : MediaType('image', 'jpg')),
        "application_id": params!["application_id"],
        "document_id": params["document_id"],
        "product_id": params["product_id"],
        "employment_id": params['employment_id'],
        "doc_password": params['doc_password']
      });
      response = await _dio!.post(url, data: formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else if (response.statusCode == 401) {
        MyPref().logout();
        gt.Get.toNamed(Routes.login);
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else if (response.statusCode == 400) {
        return response;
      } else {
        throw Exception("Something does went wrong");
      }
    } on SocketException catch (_) {
      throw Exception("No Internet Connection");
    } on FormatException catch (_) {
      throw Exception("Bad response format");
    } on DioError catch (e) {
      if (e is Response) {
        final error = json.decode(e.response.toString());
        throw Exception(error['message']);
      } else if (e.error is SocketException) {
        throw Exception("No Internet connection!");
      } else {
        throw Exception("Something went wrong! Please try again.");
      }
    } catch (e) {
      throw Exception("Something went wrong!");
    }
  }

  ///
  /// This method is used to request the data using
  /// base url + endpoint and configuration provided.
  ///
  Future<dynamic> uploadImagesSupport(
      {required ApiConfigurator apiConfig,
      required String endPoint,
      required Method method,
      required String fileOnePath,
      required String fileTwoPath,
      required String fileThreePath,
      required String description,
      required String natureOfQuery}) async {
    String url = "";
    switch (apiConfig) {
      case ApiConfigurator.basic:
        url = AppConfig().baseUrl + "/" + endPoint;
        break;
      case ApiConfigurator.none:
        url = endPoint;
        break;
    }
    Response response;
    var map = <String, dynamic>{
      "description": description,
      "nature_of_query": natureOfQuery
    };
    if (fileOnePath != "") {
      File? fileOne = File(fileOnePath);
      String? fileNameOne = fileOne.path.split('/').last;
      map["image_1"] = await MultipartFile.fromFile(fileOne.path,
          filename: fileNameOne, contentType: MediaType('image', 'jpg'));
    }
    if (fileTwoPath != "") {
      File? fileTwo = File(fileTwoPath);
      String? fileNameTwo = fileTwo.path.split('/').last;
      map['image_2'] = await MultipartFile.fromFile(fileTwo.path,
          filename: fileNameTwo, contentType: MediaType('image', 'jpg'));
    }
    if (fileThreePath != "") {
      File? fileThree = File(fileThreePath);
      String? fileNameThree = fileThree.path.split('/').last;
      map['image_3'] = await MultipartFile.fromFile(fileThree.path,
          filename: fileNameThree, contentType: MediaType('image', 'jpg'));
    }
    try {
      FormData formData = FormData.fromMap(map);
      response = await _dio!.post(url, data: formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else if (response.statusCode == 401) {
        MyPref().logout();
        gt.Get.toNamed(Routes.login);
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else if (response.statusCode == 400) {
        return response;
      } else {
        throw Exception("Something does went wrong");
      }
    } on SocketException catch (_) {
      throw Exception("No Internet Connection");
    } on FormatException catch (_) {
      throw Exception("Bad response format");
    } on DioError catch (e) {
      if (e is Response) {
        final error = json.decode(e.response.toString());
        throw Exception(error['message']);
      } else if (e.error is SocketException) {
        throw Exception("No Internet connection!");
      } else {
        throw Exception("Something went wrong! Please try again.");
      }
    } catch (e) {
      //print(e.toString());
      throw Exception("Something went wrong!");
    }
  }

  ///
  /// This method is used to request the data using
  /// base url + endpoint and configuration provided.
  ///
  Future<dynamic> uploadImages(
      {required ApiConfigurator apiConfig,
      required String endPoint,
      required Method method,
      required File? file}) async {
    String url = "";
    switch (apiConfig) {
      case ApiConfigurator.basic:
        url = AppConfig().baseUrl + "/" + endPoint;
        break;
      case ApiConfigurator.none:
        url = endPoint;
        break;
    }
    Response response;
    String? fileName = file?.path.split('/').last;
    //print(fileName);
    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(file?.path ?? "",
            filename: fileName, contentType: MediaType('image', 'jpg')),
      });
      response = await _dio!.post(url, data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else if (response.statusCode == 401) {
        MyPref().logout();
        gt.Get.toNamed(Routes.login);
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else if (response.statusCode == 400) {
        return response;
      } else {
        throw Exception("Something does went wrong");
      }
    } on SocketException catch (_) {
      throw Exception("No Internet Connection");
    } on FormatException catch (_) {
      throw Exception("Bad response format");
    } on DioError catch (e) {
      if (e is Response) {
        final error = json.decode(e.response.toString());
        throw Exception(error['message']);
      } else if (e.error is SocketException) {
        throw Exception("No Internet connection!");
      } else {
        throw Exception("Something went wrong! Please try again.");
      }
    } catch (e) {
      //print(e.toString());
      throw Exception("Something went wrong!");
    }
  }

  ///
  /// This method is used to request the data using
  /// base url + endpoint and configuration provided.
  ///
  Future<dynamic> request({
    required ApiConfigurator apiConfig,
    required String endPoint,
    required Method method,
    dynamic params,
  }) async {
    String url = "";
    switch (apiConfig) {
      case ApiConfigurator.basic:
        url = AppConfig().baseUrl + endPoint;
        break;
      case ApiConfigurator.none:
        url = endPoint;
        break;
    }
    Response response;
    //print(params);
    developer.log(params.toString(), name: "Error");
    try {
      if (method == Method.POST) {
        response = await _dio!.post(url, data: params,
            options: Options(validateStatus: (status) {
          return status! < 500;
        }));
      } else if (method == Method.DELETE) {
        response = await _dio!.delete(url);
      } else if (method == Method.PATCH) {
        response = await _dio!.patch(url);
      } else {
        response = await _dio!.get(url, queryParameters: params);
      }

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 400 ||
          response.statusCode == 422) {
        return response;
      } else if (response.statusCode == 401) {
        MyPref().logout();
        gt.Get.toNamed(Routes.login);
        throw Exception(response.data['message']);
      } else if (response.statusCode == 500) {
        throw Exception(response.data['message']);
      } else {
        throw Exception(response.data['message']);
      }
    } on SocketException catch (_) {
      throw Exception("No Internet Connection");
    } on FormatException catch (_) {
      throw Exception("Bad response format");
    } on DioError catch (e) {
      if (e is Response) {
        final error = json.decode(e.response.toString());
        // if (error['code'] == '401' && MyPref().isLogin.val) {
        // MyPref().logout();
        // GetRoute.Get.offAllNamed(Routes.emailLogin);
        // GetRoute.Get.find<SocketController>().dispose();
        // showError(
        //   "Session Expired",
        //   "Your current session expired! Please login again!",
        // );
        // }
        throw Exception(error['message']);
      } else if (e.error is SocketException) {
        throw Exception("No Internet connection!");
      } else {
        throw Exception("Something went wrong! Please try again.");
      }
    } catch (e) {
      throw Exception("Something went wrong!");
    }
  }

  ///
  /// This method is used to download the file.
  ///
  downloadFile(String url, String fileName) async {
    try {
      CancelToken cancelToken = CancelToken();
      var dir = await getApplicationDocumentsDirectory();
      await _dioDownloader?.download(url, "${dir.path}/$fileName",
          cancelToken: cancelToken, onReceiveProgress: (rec, total) {
        //print("DOWNLOADING: $rec , Total: $total");
      });
    } catch (e) {
      //print("ERROR:${e}");
    }
  }
}
