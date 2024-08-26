// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oyehanif/globles/AppColor.dart';
import 'package:oyehanif/globles/AppString.dart';
import 'package:oyehanif/globles/MyText.dart';
import 'package:oyehanif/globles/app_button.dart';
import 'package:oyehanif/globles/app_images.dart';
import 'package:oyehanif/globles/app_text_style.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({Key? key}) : super(key: key);

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

Color themeColor = const Color(0xFF43D19E);

class _ThankYouPageState extends State<ThankYouPage> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: AppColor.bgColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 350,
                padding: EdgeInsets.all(35),

                // child: Lottie.asset(AppImages.thankyou),
                child: Lottie.network('https://lottie.host/33644add-2788-4910-a4f6-3fb99d03bf03/OD18RmeX4L.json'),
              ),
              SizedBox(height: screenHeight * 0.1),
              Text(
                "Thank You!",
                style: TextStyle(
                  color: themeColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 36,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              MyText(
                connectingText,
                style: AppTextStyles.montserratStyle(fontSize: 22),
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: screenHeight * 0.035),
                child: Center(
                  child: MyText(
                    connectingText1,
                    style: AppTextStyles.montserratStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.06),
              Flexible(
                child: AppButton.buildMaterialButton(
                    buttonName: "Take Me Home",
                    onTap: () {
                      Navigator.pop(context);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
