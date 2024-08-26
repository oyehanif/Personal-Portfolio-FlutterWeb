import 'package:flutter/material.dart';
import 'package:oyehanif/globles/AppColor.dart';
import 'package:oyehanif/globles/app_text_style.dart';

class AppButton {
  static MaterialButton buildMaterialButton({
    required String buttonName,
    required VoidCallback onTap,
  }) {
    return MaterialButton(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.all(16),
      onPressed: () {
        onTap();
      },
      color: AppColor.themeColor,
      height: 60,
      minWidth: 120,
      child: Text(
        buttonName,
        style: AppTextStyles.montserratStyle(color: AppColor.bgColor,fontSize: 15),
      ),
    );
  }
}
