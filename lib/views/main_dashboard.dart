import 'package:flutter/material.dart';
import 'package:oyehanif/globles/AppColor.dart';
import 'package:oyehanif/globles/AppString.dart';
import 'package:oyehanif/globles/MyText.dart';
import 'package:oyehanif/globles/app_text_style.dart';
import 'package:oyehanif/views/ContactMe.dart';
import 'package:oyehanif/views/FooterClass.dart';
import 'package:oyehanif/views/about_me.dart';
import 'package:oyehanif/views/home_page.dart';
import 'package:oyehanif/views/my_portfolio.dart';
import 'package:oyehanif/views/my_service.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../helper_class/WidgetNotification.dart';

import 'MobileMenu.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  final onMenuHover = Matrix4.identity()..scale(1.0);

  final screenList = const [
    HomePage(),
    AboutMe(),
    MyService(),
    MyPortfolio(),
    ContactUs(),
    FooterClass()
  ];

  var menuIndex = 0;
  var hoverIndex = null;
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: menuIndex != 0 ?  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColor.themeColor),
          child: InkWell(
            onTap: () {
              setState(() {
                menuIndex = 0;
                _scrollToIndex(menuIndex);
              });
            },
            child: const Icon(
              Icons.arrow_upward,
              size: 25,
              color: Colors.black,
            ),
          ),
        ),
      ) : SizedBox(),
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        backgroundColor: AppColor.bgColor,
        toolbarHeight: 90,
        elevation: 0,
        title: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth < 768) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      print("Click!");
                      menuIndex = 0;
                      _scrollToIndex(menuIndex);
                    });
                  },
                  child: Text(
                    portfolio,
                    style: AppTextStyles.headerTextStyle(),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {

                    int? result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Mobilemenu(
                            menuIndex: menuIndex,
                          ),
                        ));

                    print("result $result");
                    if (result != null) {
                      setState(() {
                        _scrollToIndex(result);
                      });
                    }else{
                      print("else");
                    }
                  },
                  icon: const Icon(
                    Icons.menu_sharp,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: (size.width * 0.08)),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                         menuIndex = 0;
                        _scrollToIndex(menuIndex);
                      });
                    },
                    child: MyText(
                      portfolio,
                      style: AppTextStyles.headerTextStyle(),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 30,
                    child: ListView.separated(
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          setState(() {
                            menuIndex = index;
                            _scrollToIndex(menuIndex);
                          });
                        },
                        borderRadius: BorderRadius.circular(100),
                        onHover: (value) {
                          setState(() {
                            if (value) {
                              hoverIndex = index;
                            } else {
                              hoverIndex = null;
                            }
                            // if (value) {
                            //   menuIndex = index;
                            // } else {
                            //   menuIndex = 0;
                            // }
                          });
                        },
                        child: buildNavBarAnimatedContainer(index,
                            hoverIndex, menuIndex),
                      ),
                      separatorBuilder: (context, child) => const SizedBox(
                        width: 8,
                      ),
                      itemCount: menuItems.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
            );
          }
        }),
      ),
      body: NotificationListener<WidgetNotification>(
        onNotification: (notification) {
          setState(() {
            print("notification call");
            menuIndex = notification.widgetIndex;
          });
          return true;
        },
        // child: ListView.builder(
        //   controller: _scrollController,
        //   itemCount: screenList.length,
        //   itemBuilder: (context, index) {
        //     return Container(
        //       key: _itemKeys[index],
        //       child: screenList[index],
        //     );
        //   },
        // ),

        child: ScrollablePositionedList.builder(
          itemScrollController: _scrollController,
          itemCount: screenList.length,
          itemBuilder: (context, index) {
            return screenList[index];
          },
        ),
      ),
    );
  }

  void _scrollToIndex(int index) {
    // final context = _itemKeys[index].currentContext;
    // if (context != null) {
    //   Scrollable.ensureVisible(
    //     context,
    //     duration: const Duration(seconds: 1),
    //     curve: Curves.easeInOut,
    //   );
    // }
    _scrollController
        .scrollTo(
      index: index,
      duration: const Duration(milliseconds: 1000),
    )
        .then((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        print("before setState $menuIndex");
        setState(() {
          menuIndex = index;
          print("inside setState");
        });
        print("after setState $menuIndex");
      });
    });
  }

  buildNavBarAnimatedContainer(int index, int? hover, int menuIndex) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 200),
      alignment: Alignment.center,
      // width: hover ? 100 : 95,
      width: 100,
      transform: hover != null ? onMenuHover : null,
      child: Text(
        menuItems[index],
        style: AppTextStyles.headerTextStyle(
            color: (hover!=null && hover==index) || index == menuIndex
                ? AppColor.themeColor
                : AppColor.white,
            fontSize: 20),
      ),
    );
  }
}
