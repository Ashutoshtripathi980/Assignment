import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {Key? key,
      required this.text,
      this.isExpanded = false,
      this.paddingHorizontal,
      this.paddingVertical,
      this.onTap,
      this.width,
      this.height,
      this.elevation})
      : super(key: key);

  final String text;
  final bool isExpanded;
  final Function()? onTap;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final double? width;
  final double? height;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary:Colors.green,
        fixedSize: isExpanded ? Size(width ?? Get.width, height ?? 56) : null,
        elevation: elevation ?? 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical != null
              ? paddingVertical!
              : (height != null && height! > 56)
                  ? 16
                  : 10,
          horizontal: paddingHorizontal != null ? paddingHorizontal! : 24,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
