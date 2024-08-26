import 'package:flutter/material.dart';
import 'package:oyehanif/globles/AppColor.dart';
import 'package:oyehanif/globles/AppString.dart';

import '../globles/MyText.dart';
import '../globles/app_text_style.dart';

class Mobilemenu extends StatefulWidget {
  const Mobilemenu({super.key,required this.menuIndex});
  final int menuIndex;

  @override
  State<Mobilemenu> createState() => _MobilemenuState();
}

class _MobilemenuState extends State<Mobilemenu> {
  final onMenuHover = Matrix4.identity()..scale(1.0);
  var menuIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuIndex = widget.menuIndex;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(color: AppColor.bgColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    'Menu',
                    style: AppTextStyles.montserratStyle(fontSize: 50),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context,menuIndex);
                      },
                      icon: Icon(
                        Icons.close,
                        size: 40,
                        color: AppColor.bgColor2,
                      ))
                ],
              ),
              ListView.separated(
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.pop(context,index);
                    print("!@#");
                  },
                  borderRadius: BorderRadius.circular(100),
                  onHover: (value) {
                    setState(() {
                      if (value) {
                        menuIndex = index;
                      } else {
                        menuIndex = 0;
                      }
                    });
                  },
                  child: buildNavBarAnimatedContainer(
                      index, menuIndex == index ? true : false),
                ),
                separatorBuilder: (context, child) => const SizedBox(
                  width: 8,
                ),
                itemCount: menuItems.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
              )
            ],
          ),
        ),
      ),
    );
  }

  buildNavBarAnimatedContainer(int index, bool hover) {
    return InkWell(
        onTap: () {
          Navigator.pop(context,index);
          print("!@# $index");
        },
      child: AnimatedContainer(
        duration: const Duration(microseconds: 200),
        alignment: Alignment.center,
        width: hover ? 100 : 95,
        transform: hover ? onMenuHover : null,
        child: Text(
          menuItems[index],
          style: AppTextStyles.headerTextStyle(
              color: hover ? AppColor.themeColor : AppColor.white, fontSize: 40),
        ),
      ),
    );
  }
}
