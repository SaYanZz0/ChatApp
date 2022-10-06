import 'package:chat_app_newversion/app/controllers/auth_controller.dart';
import 'package:chat_app_newversion/app/routes/app_pages.dart';
import 'package:chat_app_newversion/app/utils/constants.dart';
import 'package:chat_app_newversion/app/utils/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  final authC = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Obx(
              () => GetMaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  brightness: Brightness.light,
                  primaryColor:Colors.white,
                    appBarTheme: const AppBarTheme(
                        backgroundColor: kPrimaryColor
                    )
                ),
                darkTheme:ThemeData(
                  brightness: Brightness.dark,
                  primaryColor: Colors.black,
                  appBarTheme: const AppBarTheme(
                    backgroundColor: kPrimaryColor
                  )
                ),
                themeMode:authC.isDark.isTrue ? ThemeMode.dark : ThemeMode.light,
                initialRoute: authC.isSkipIntro.isTrue
                    ? authC.isAuth.isTrue
                        ? RouteClass.getHomeScreen()
                        : RouteClass.getloginScreen()
                    : RouteClass.getIntroductionScreen(),
                getPages: RouteClass.routes,
              ),
            );
          }
          return FutureBuilder(
            future: authC.firstInitialized(),
              builder:(context , snapshot){
              return const SplashScreen();
              }
          );
        });
  }
}
