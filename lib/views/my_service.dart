import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../helper_class/WidgetNotification.dart';
import 'package:oyehanif/globles/AppColor.dart';
import 'package:oyehanif/globles/app_button.dart';
import 'package:oyehanif/globles/app_images.dart';
import 'package:oyehanif/helper_class/helper_class.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../globles/AppString.dart';
import '../globles/app_text_style.dart';

class MyService extends StatefulWidget {
  const MyService({super.key});

  @override
  State<MyService> createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  bool isApp = false;
  bool isUI = false;
  bool isDA = false;

  int hoverIndex = -1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return VisibilityDetector(
      key: const Key('service-key'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction > 0.50) {
          WidgetNotification(2).dispatch(context);
        }
      },
      child: HelperClass(
          mobile: Column(
            children: [
              buildMyServiceText(),
              const SizedBox(height: 60),
              for (int i = 0; i < serviceList.length; i++) ...[
                InkWell(
                  onTap: () {},
                  onHover: (value) {
                    setState(() {
                      //  hoverStates[i] = value;
                      hoverIndex = value ? i : -1;
                    });
                  },
                  child: MyServiceCard(
                    serviceItem: serviceList[i],
                    isHover: hoverIndex == i,
                  ),
                ),
                const SizedBox(height: 18),
              ],
            ],
          ),
          tablet: MyServiceList(),
          desktop: MyServiceList(),
          paddingWidth: size.width * 0.04,
          bgColor: AppColor.bgColor),
    );
  }

  FadeInDown buildMyServiceText() {
    return FadeInDown(
      child: RichText(
        text: TextSpan(
          text: 'My',
          style: AppTextStyles.headerTextStyle(fontSize: 30),
          children: [
            TextSpan(
              text: 'Service',
              style: AppTextStyles.headerTextStyle(
                  fontSize: 30, color: AppColor.robinEdgeBlue),
            ),
          ],
        ),
      ),
    );
  }
}

class MyServiceList extends StatefulWidget {
  final Axis direction;

  const MyServiceList({super.key, this.direction = Axis.horizontal});

  @override
  MyServiceListState createState() => MyServiceListState();
}

class MyServiceListState extends State<MyServiceList> {
  int hoverIndex = -1; // -1 indicates no hover

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildMyServiceText(),
        const SizedBox(
          height: 50,
        ),
        Container(
          // height: MediaQuery.of(context).size.height * 0.6,
          height: 420,
          child: ListView.builder(
            scrollDirection: widget.direction,
            shrinkWrap: true,
            itemCount: serviceList.length,
            itemBuilder: (context, index) {
              final serviceItem = serviceList[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
                child: InkWell(
                  onTap: () {},
                  onHover: (value) {
                    setState(() {
                      hoverIndex = value ? index : -1;
                    });
                  },
                  child: MyServiceCard(
                    serviceItem: serviceItem,
                    isHover: hoverIndex == index,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  FadeInDown buildMyServiceText() {
    return FadeInDown(
      child: RichText(
        text: TextSpan(
          text: 'My',
          style: AppTextStyles.headerTextStyle(fontSize: 30),
          children: [
            TextSpan(
              text: 'Service',
              style: AppTextStyles.headerTextStyle(
                  fontSize: 30, color: AppColor.robinEdgeBlue),
            ),
          ],
        ),
      ),
    );
  }
}

class MyServiceCard extends StatelessWidget {
  final service serviceItem;
  final bool isHover;
  final double hoverWidth;
  final double width;

  const MyServiceCard({
    super.key,
    required this.serviceItem,
    required this.isHover,
    this.width = 350,
    this.hoverWidth = 360,
  });

  @override
  Widget build(BuildContext context) {
    final onHoverActivity = Matrix4.identity()..translate(0, -10, 0);
    final onHoverRemove = Matrix4.identity()..translate(0, 0, 0);

    return Container(
      height: 425,
      width: hoverWidth,
      child: AnimatedContainer(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
        decoration: BoxDecoration(
            color: AppColor.bgColor2,
            borderRadius: BorderRadius.circular(30),
            border:
                isHover ? Border.all(color: AppColor.themeColor, width: 2) : null,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black54,
                  spreadRadius: 4,
                  blurRadius: 4.5,
                  offset: Offset(4, 3.5))
            ]),
        width: isHover ? hoverWidth : width,
        height: isHover ? 420 : 415,
        duration: const Duration(microseconds: 600),
        transform: isHover ? onHoverActivity : onHoverRemove,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset(
                  serviceItem.imageUrl ?? '',
                  height: 100,
                  width: 100,
                  color: AppColor.themeColor,
                ),
                const SizedBox(
                  height: 28,
                ),
                Text(
                  serviceItem.title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.montserratStyle(fontSize: 22),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  serviceItem.decs,
                  style: AppTextStyles.normalStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            AppButton.buildMaterialButton(buttonName: 'Read More', onTap: () {})
          ],
        ),
      ),
    );
  }
}
