import 'package:get_storage/get_storage.dart';

class MyPref {
  static final MyPref _myPref = MyPref._internal();

  factory MyPref() {
    return _myPref;
  }

  MyPref._internal();


  final isLogin = false.val('isLogin');
  final isPartner = false.val('isPartner');
  final wifi = false.val('wifi');
  final mobileNetwork = false.val('mobileNetwork');
  final isBatchEnrolled = false.val('isBatchEnrolled');
  final token = ''.val("token");
  final userDetail = ''.val("userDetail");
  final userId = ''.val('userId');


  void logout() {
    // FirebaseAnalytics.instance.logEvent(name: "click_profile_logout");
    isLogin.val = false;
    token.val = '';
    userDetail.val = '';
  }
}
