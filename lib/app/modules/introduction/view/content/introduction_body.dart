import 'package:chat_app_newversion/app/controllers/auth_controller.dart';
import 'package:chat_app_newversion/app/modules/introduction/view/content/splash_content.dart';
import 'package:chat_app_newversion/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/default_button.dart';
import '../../../../utils/size_config.dart';

class IntroductionBody extends StatefulWidget {
  const IntroductionBody({Key? key}) : super(key: key);

  @override
  State<IntroductionBody> createState() => _IntroductionBodyState();
}

class _IntroductionBodyState extends State<IntroductionBody> {
  int currentpage = 0;
  final authC = Get.find<AuthController>();
  var SplashData = [
    {
      'text': ' Welcome To Freedom \nWhere you can buy Anything!',
      'image': 'assets/images/chat1.png'
    },
    {
      'text': 'We Help People to make Shopping \nall around all The World!',
      'image': 'assets/images/chat2.png'
    },
    {
      'text': 'We Show The Easy Way to Shop.\nJust Stay At Home with Us!',
      'image': 'assets/images/chat3.png'
    }
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentpage = value;
                    });
                  },
                  itemCount: SplashData.length,
                  itemBuilder: (context, index) {
                    return SplashContent(
                      image: SplashData[index]['image'],
                      text: SplashData[index]['text'],
                    );
                  }),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(SplashData.length,
                            (index) => BuildDot(index: index))),
                    const Spacer(
                      flex: 2,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: DefaultButton(
                          width: double.infinity,
                          text: 'Continue',
                          press: () {
                            authC.isSkipIntro.value = true;
                            print(authC.isSkipIntro);
                            Get.offAllNamed(RouteClass.getregisterScreen());
                          }),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget BuildDot({required int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: index == currentpage ? 20 : 6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: index == currentpage ? kPrimaryColor : Colors.grey),
    );
  }
}
