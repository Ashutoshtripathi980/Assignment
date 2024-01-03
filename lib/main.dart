import 'package:fbsocial/binding/controller_binding.dart';
import 'package:fbsocial/firebase_options.dart';
import 'package:fbsocial/routes/pages.dart';
import 'package:fbsocial/ui/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:fbsocial/networking/dio_service.dart';

//https://fbauth-c0740.firebaseapp.com/__/auth/handler
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DioService().init();
  runApp(GetMaterialApp(
    initialBinding: MyControllerBindings(),
    getPages: AppPages.routes,
    debugShowCheckedModeBanner: false,
    initialRoute: AppPages.initial,
    home: const LoginPage(),
  ));
}
