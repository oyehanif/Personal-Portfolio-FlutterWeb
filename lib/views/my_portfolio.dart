import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../helper_class/WidgetNotification.dart';
import 'package:oyehanif/globles/AppString.dart';
import 'package:oyehanif/globles/app_images.dart';
import 'package:oyehanif/helper_class/helper_class.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:js' as js;
import '../globles/AppColor.dart';
import '../globles/app_text_style.dart';

class MyPortfolio extends StatefulWidget {
  const MyPortfolio({super.key});

  @override
  State<MyPortfolio> createState() => _MyPortfolioState();
}

class _MyPortfolioState extends State<MyPortfolio> {
  var isHover;
  var onHoverEffect = Matrix4.identity()
    ..scale(1.0);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return VisibilityDetector(
      key: const Key('portfolio-key'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction > 0.50) {
          WidgetNotification(3).dispatch(context);
        }
      },
      child:
      HelperClass(
        mobile: Column(
          children: [
            buildProjectText(),
            const SizedBox(
              height: 60,
            ),
            buildProjectGridView(crossAxisCount: 1),
          ],
        ),
        tablet: Column(
          children: [
            buildProjectText(),
            const SizedBox(
              height: 60,
            ),
            buildProjectGridView(),
          ],
        ),
        desktop: Column(
          children: [
            buildProjectText(),
            const SizedBox(
              height: 60,
            ),
            buildProjectGridView(crossAxisCount: workList.length == 4 ? 2 : 3),
          ],
        ),
        paddingWidth: size.width * 0.1,
        bgColor: AppColor.bgColor2),);
  }

  GridView buildProjectGridView({int crossAxisCount = 2}) {
    return GridView.builder(
      itemCount: workList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisExtent: 270,
          mainAxisSpacing: 24,
          crossAxisSpacing: 24),
      itemBuilder: (context, index) {
        var item = workList[index];
        return FadeInUpBig(
          duration: const Duration(microseconds: 1600),
          child: InkWell(
            onTap: () {},
            onHover: (value) {
              setState(() {
                if (value) {
                  isHover = index;
                } else {
                  isHover = null;
                }
              });
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage(item.imagePath), fit: BoxFit.fill),
                  ),
                ),
                Visibility(
                  visible: isHover == index,
                  child: AnimatedContainer(
                    curve: Curves.easeIn,
                    duration: Duration(microseconds: 200),
                    transform: index == isHover ? onHoverEffect : null,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          colors: [
                            AppColor.themeColor.withOpacity(1),
                            AppColor.themeColor.withOpacity(0.9),
                            AppColor.themeColor.withOpacity(0.8),
                            AppColor.themeColor.withOpacity(0.6),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter),
                    ),
                    child: Column(
                      children: [
                        Text(
                          item.title,
                          style: AppTextStyles.montserratStyle(
                              fontSize: 20, color: Colors.black87),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          item.desc,
                          style:
                          AppTextStyles.normalStyle(color: Colors.black87),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CircleAvatar(
                            maxRadius: 25,
                            backgroundColor: AppColor.white,
                            child: InkWell(
                              onTap: () {
                                openNewTab(item.link);
                              },
                              child: Image.asset(
                                AppImages.share,
                                width: 25,
                                height: 25,
                                fit: BoxFit.fill,
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  FadeInDown buildProjectText() {
    return FadeInDown(
      child: RichText(
        text: TextSpan(
          text: 'Latest ',
          style: AppTextStyles.headerTextStyle(fontSize: 30),
          children: [
            TextSpan(
              text: 'Projects',
              style: AppTextStyles.headerTextStyle(
                  fontSize: 30, color: AppColor.robinEdgeBlue),
            ),
          ],
        ),
      ),
    );
  }
}


void openNewTab(String url) {
  js.context.callMethod('open', [url]);
}