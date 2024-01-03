import 'dart:io';
import 'package:fbsocial/utils/AppColors.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final RegExp mobileRegex = RegExp(r'^(?:[+0][1-9])?[0-9]{11}$');

///
/// This method is used to show the loader.
///
showLoader() => Get.dialog(
      Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(32),
          child: const CircularProgressIndicator(
            color: Color.fromRGBO(16, 127, 60, 1),
          ),
        ),
      ),
    );

///
/// This method is used to show Alert
///
alertDialog(String mobile) => Get.dialog(Center(
      child: Material(
        elevation: 2.0,
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          width: Get.width * 0.8,
          height: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Oops!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Avenir',
                      fontSize: 15,
                      height: 1.875)),
              const SizedBox(
                height: 20,
              ),
              Text(
                  'It seems that your PAN is linked with a different mobile number:\n +91-$mobile',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Avenir',
                      fontSize: 15,
                      height: 1.875)),
              const SizedBox(
                height: 30,
              ),
              const Text(
                  'Please input this mobile number to continue this process',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Avenir',
                      fontSize: 13,
                      height: 1.875)),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                  onTap: () {
                    Get.back();
                    Get.back(result: true);
                  },
                  child: Container(
                      margin: const EdgeInsets.only(
                          top: 10, bottom: 5, left: 12, right: 12),
                      width: double.infinity,
                      height: 40.93,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0XFF4E5351)),
                      child: const Center(
                          child: Text('Continue',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16)))))
            ],
          ),
        ),
      ),
    ));

///
/// This method is used to hide the loader.
///
hideLoader() {
  if (Get.isDialogOpen != null && Get.isDialogOpen!) {
    Get.back();
  }
}

String changeDateFormat(String date) {
  var dateFormat = DateFormat("dd-MMM-yyyy").format(DateTime.parse(date));
  return dateFormat;
}

String getCurrentMonth() {
  return DateFormat("MMM,yyyy").format(DateTime.now());
}

///
/// This method is used to show the general error dialog.
///
showError(
  message,
) {
  Get.showSnackbar(
    GetSnackBar(
      animationDuration: const Duration(seconds: 1),
      titleText: const Text(
        'Error',
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
      ),
      messageText: Text(
        '$message',
        style: const TextStyle(color: Colors.black),
      ),
      duration: const Duration(seconds: 3),
      boxShadows: const [
        BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.07999999821186066),
            offset: Offset(0, 4),
            blurRadius: 25)
      ],
      borderRadius: 15,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      borderColor: Colors.red,
      borderWidth: 1,
      backgroundColor: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    ),
  );
}

///
/// This method is used to show the general error dialog.
///
showMessage(
  message,
) {
  Get.showSnackbar(
    GetSnackBar(
      messageText: Text(
        '$message',
        style: const TextStyle(color: AppColors.black48),
      ),
      duration: const Duration(seconds: 3),
      borderRadius: 4,
      margin: const EdgeInsets.fromLTRB(32, 0, 32, 80),
      // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
      borderColor: AppColors.snackbarSuccessGreenDark,
      borderWidth: 1,
      backgroundColor: AppColors.snackbarSuccessGreen,
      icon: const Icon(Icons.check_circle_outline),
      snackPosition: SnackPosition.BOTTOM,
    ),
  );
}

///
/// This method is used to show the general error dialog.
///
showMessageOnLandScape(
  message,
) {
  Get.showSnackbar(
    GetSnackBar(
      messageText: Text(
        '$message',
        style: const TextStyle(color: AppColors.black48),
      ),
      duration: const Duration(seconds: 3),
      borderRadius: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      borderColor: AppColors.snackbarSuccessGreenDark,
      borderWidth: 1,
      backgroundColor: AppColors.snackbarSuccessGreen,
      icon: const Icon(Icons.check_circle_outline),
      maxWidth: Get.width * .60,
      snackPosition: SnackPosition.BOTTOM,
    ),
  );
}

///
/// This method is used to get the color of the price.
///
getPriceColor(double? price) {
  if (price == null) {
    return AppColors.textSecondaryColor;
  } else {
    if (price.isNegative) {
      return AppColors.textRedColor;
    } else {
      return AppColors.textGreenColor;
    }
  }
}

formatTimeFromDate(String? dateTime) {
  if (dateTime == null) {
    return "00:00:00";
  } else {
    final date = DateTime.parse(dateTime).toLocal();
    return "${date.hour}:${date.minute}:${date.second}";
  }
}

containsYoutubeLink(String link) {
  if (link.contains("www.youtube.com") || link.contains("youtu.be")) {
    return true;
  } else {
    return false;
  }
}

getYoutubeImageLink(String link) {
  if (link.contains("www.youtube.com")) {
    return "https://img.youtube.com/vi/${link.split("v=")[1]}/hqdefault.jpg";
  } else if (link.contains("youtu.be")) {
    return "https://img.youtube.com/vi/${link.split("be/")[1]}/hqdefault.jpg";
  }
}

getYoutubeLinkFromString(String link) {
  if (link.contains("www.youtube.com")) {
    return "https://www.youtube.com/watch?v=${link.split("v=")[1]}";
  } else if (link.contains("youtu.be")) {
    return "https://www.youtube.com/watch?v=${link.split("be/")[1]}";
  }
}

/*preventScreenshot() {
  if (Platform.isAndroid) {
    FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  } else {
    ScreenProtector.preventScreenshotOn();
  }
}

removeScreenshotPrevention() {
  if (Platform.isAndroid) {
    FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  } else {
    ScreenProtector.preventScreenshotOff();
  }
}*/

/*///
/// This method is used for purchase course screen to show the icons
/// based on the status of the course.
///
getCourseTypeImage(String status) {
  if (status.toLowerCase().trim().replaceAll(" ", "") == 'recommended') {
    return AppAssets.icRecommended;
  } else if (status.toLowerCase().trim().replaceAll(" ", "") ==
      'mostpurchased') {
    return AppAssets.icMostPurchased;
  } else {
    return '';
  }
}*/

///
/// This method is used for purchase course screen to show the colors
/// based on the status of the course.
///
getCourseTypeColor(String status) {
  if (status.toLowerCase().trim().replaceAll(" ", "") == 'recommended') {
    return AppColors.recommendedColor;
  } else if (status.toLowerCase().trim().replaceAll(" ", "") ==
      'mostpurchased') {
    return AppColors.mostPurchasedColor;
  } else {
    return AppColors.colorAccent;
  }
}

bool getEmailId(String email) {
  final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  return emailValid;
}

String getRoundedBalance(String value, {bool isInt = false}) {
  if (value == "null") {
    value = "0";
  }
  if (value == "") {
    return value;
  }
  var currentValue = isInt
      ? int.parse(value.length >= 3 ? removeCommaSeparate(value) : value)
      : double.parse(value);
  if (isInt) {
    if (value.length <= 3) {
      return currentValue.toString();
    }
  } else {
    final decimal = value.split(".");
    if (decimal.isNotEmpty) {
      var firstHalf = decimal[0];
      if (firstHalf.length <= 3) {
        return currentValue.toString();
      }
    }
  }
  return isInt
      ? numberFormatterInt(int.parse(currentValue.toString()))
      : numberFormatter(double.parse(currentValue.toStringAsFixed(2)));
}

String removeCommaSeparate(String value) {
  return value.replaceAll(',', '');
}

String convertDoubleToInt(String input) {
  var data = double.parse(input);

  return data.toInt().toString();
}

String numberFormatter(double value) {
  var formatter = NumberFormat('#,##,##,000');

  return formatter.format(value);
}

String numberFormatterInt(int value) {
  var formatter = NumberFormat('#,##,##,000');

  return formatter.format(value);
}

// String getName(int index) {
//   final namesList = MyPref().user.fullName?.trim().split(" ");
//   if (index == 2 && (namesList?.length ?? 1) == 3) {
//     return namesList![index];
//   } else if (index == 2) {
//     if (index > (namesList?.length ?? 1)) {
//       return "";
//     }
//     return namesList![index - 1];
//   } else if (index == 1 && (namesList?.length ?? 1) < 3) {
//     return "";
//   } else {
//     return namesList![index];
//   }
// }

String getProductImage(int productId) {
  var productIcon = "assets/images/gold_loan.png";
  if (productId == 1) {
    productIcon = "assets/images/loan_personal.png";
  } else if (productId == 6) {
    productIcon = "assets/images/business_loan.png";
  } else if (productId == 2) {
    productIcon = "assets/images/credit_card.png";
  } else if (productId == 3) {
    productIcon = "assets/images/home_loan.png";
  } else if (productId == 4) {
    productIcon = "assets/images/unsecured_loan.png";
  } else if (productId == 5) {
    productIcon = "assets/images/loan.png";
  }else if (productId == 8) {
    productIcon = "assets/images/home_loan.png";
  }else if (productId == 9) {
    productIcon = "assets/images/loan.png";
  }

  return productIcon;
}

String getProductName(int productId) {
  var productName = "Gold Loan";
  if (productId == 1) {
    productName = "Personal Loan";
  } else if (productId == 6) {
    productName = "Business Loan";
  } else if (productId == 2) {
    productName = "Credit Card";
  } else if (productId == 3) {
    productName = "Home Loan";
  } else if (productId == 4) {
    productName = "Unsecured Overdraft";
  } else if (productId == 5) {
    productName = "Loan Against Property";
  }else if (productId == 5) {
    productName = "Loan Against Property";
  }else if (productId == 8) {
    productName = "Home Loan BT";
  }else if (productId == 9) {
    productName = "Loan Against Property BT";
  }

  return productName;
}

String getExtensionName(String url) {
  var list = url.split(".");
  if (list.isNotEmpty) {
    return list[list.length - 1];
  } else {
    return "";
  }
}

void modalErrorBottomSheet() {
  Get.bottomSheet(
    Container(
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40.0),
          topLeft: Radius.circular(40.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "   Hey!!!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18),
                ),
                IconButton(
                    onPressed: () {
                     // Navigator.of().pop();
                      Get.back(closeOverlays: true);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFF2D9670),
                    )),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
              child: Center(
                child: Text(
                  "Already Applied for the loan,\nPlease check loan Status on the Dashboard",
                  style: TextStyle(color: Color(0xFF2D9670), fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              height: 42,
              child: InkWell(
                  onTap: () {
                   
                  },
                  child: Container(
                      margin: const EdgeInsets.only(
                          top: 0, bottom: 0, left: 24, right: 24),
                      width: double.infinity,
                      height: 40.93,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0XFF4E5351)),
                      child: const Center(
                          child: Text('Track Application',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16))))),
            )
          ],
        ),
      ),
    ),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40.0),
    ),
  );
}
