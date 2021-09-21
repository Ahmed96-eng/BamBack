import 'package:flutter/material.dart';
import 'package:qattan/controller/cached_helper/key_constant.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/veiw/component_widget/common_button.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/screens/auth/log_in.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:qattan/controller/cached_helper/cached_helper.dart';
import 'package:get/get.dart';

import '../../constant.dart';

class BoardingModel {
  final String? image;
  final String? title;
  final String? body;

  BoardingModel({
    required this.title,
    required this.image,
    this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'asset/images/main_logo.png',
      title: 'Bamback',
      // body:
      //     'Lorem ipsum dolor sit amet,Consectetur adipiscing elit.IntergerMaximus accumsan erat ide facilisis. ',
    ),
    BoardingModel(
      image: 'asset/images/main_logo.png',
      title: 'Bamback',
      // body:
      //     'Lorem ipsum dolor sit amet,Consectetur adipiscing elit. IntergerMaximus accumsan erat ide facilisis.',
    ),
    BoardingModel(
      image: 'asset/images/main_logo.png',
      title: 'Bamback',
      // body:
      //     'Lorem ipsum dolor sit amet,Consectetur adipiscing elit. Interger Maximus accumsan erat ide facilisis.',
    ),
  ];

  bool isLast = false;

  void submit() {
    CachedHelper.setData(
      key: onBoardingKey,
      value: true,
    ).then((value) {
      if (value) {
        goToAndFinish(context, LogIn());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: boardController,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  CommonButton(
                      text: "skip".tr,
                      textColor: Color(0xffACBAC3),
                      width: width * 0.2,
                      height: height * 0.07,
                      onTap: () {
                        print('Skipped');
                        submit();
                      }),
                  Spacer(),
                  CommonButton(
                      text: !isLast ? "next".tr : "skip".tr,
                      containerColor: buttonColor,
                      textColor: buttonTextColor,
                      height: height * 0.07,
                      width: width * 0.3,
                      onTap: () {
                        if (isLast) {
                          submit();
                        } else {
                          boardController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }
                      }),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          // Padding(
          //   padding: EdgeInsets.all(8.0),
          //   child: Text(
          //     '${model.body}',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       fontSize: 14.0,
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 30.0,
          ),
          SmoothPageIndicator(
            controller: boardController,
            effect: ExpandingDotsEffect(
              dotColor: Color(0xffACBAC3),
              activeDotColor: mainColor,
              dotHeight: 8,
              dotWidth: 8,
              expansionFactor: 4,
              spacing: 12.0,
            ),
            count: boarding.length,
          ),
        ],
      );
}
