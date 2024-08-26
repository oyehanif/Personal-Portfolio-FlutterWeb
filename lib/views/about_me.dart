import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../helper_class/WidgetNotification.dart';
import 'package:oyehanif/globles/AppColor.dart';
import 'package:oyehanif/globles/AppString.dart';
import 'package:oyehanif/globles/app_button.dart';
import 'package:oyehanif/globles/app_images.dart';
import 'package:oyehanif/globles/app_text_style.dart';
import 'package:oyehanif/helper_class/helper_class.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return VisibilityDetector(
        key: const Key('about-key'),
        onVisibilityChanged: (VisibilityInfo info) {
          if (info.visibleFraction > 0.50) {
            WidgetNotification(1).dispatch(context);
          }
        },
        child: HelperClass(
          mobile: Column(
            children: [
              buildProfilePicture(size: 300),
              const SizedBox(
                height: 35,
              ),
              buildAboutMeContent(),
            ],
          ),
          tablet: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildProfilePicture(),
              const SizedBox(
                width: 25,
              ),
              Expanded(child: buildAboutMeContent())
            ],
          ),
          desktop: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildProfilePicture(),
              const SizedBox(
                width: 25,
              ),
              Expanded(child: buildAboutMeContent())
            ],
          ),
          paddingWidth: size.width * 0.1,
          bgColor: AppColor.bgColor2,
        ));
  }

  FadeInRight buildProfilePicture({double size = 450}) {
    return FadeInRight(
      duration: const Duration(milliseconds: 1200),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage(AppImages.profile2)),
          borderRadius: const BorderRadius.all(Radius.circular(450)),
          // color: Colors.redAccent,
        ),
      ),
    );
  }

  Column buildAboutMeContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInRight(
          duration: Duration(milliseconds: 1200),
          child: RichText(
            text: TextSpan(
              text: about,
              style: AppTextStyles.headerTextStyle(fontSize: 30),
              children: [
                TextSpan(
                  text: me,
                  style: AppTextStyles.headerTextStyle(
                      fontSize: 30, color: AppColor.themeColor),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          skillTitle,
          style: AppTextStyles.montserratStyle(color: Colors.white),
        ),
        const SizedBox(height: 8.0),
        Text(
          descAbout,
          maxLines: 10,
          style: AppTextStyles.normalStyle(fontSize: 12),
        ),
        const SizedBox(height: 15.0),
        AppButton.buildMaterialButton(buttonName: "Read More", onTap: () {})
      ],
    );
  }
}
