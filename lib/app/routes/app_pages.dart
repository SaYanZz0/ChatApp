

import 'package:chat_app_newversion/app/modules/chat_room/view/chat_room_view.dart';
import 'package:chat_app_newversion/app/modules/edit_profile/bindings/edit_binding.dart';
import 'package:chat_app_newversion/app/modules/edit_profile/view/edit_profile.dart';
import 'package:chat_app_newversion/app/modules/home/view/home_view.dart';
import 'package:chat_app_newversion/app/modules/login/view/login_view.dart';
import 'package:chat_app_newversion/app/modules/profil/view/profile_view.dart';
import 'package:chat_app_newversion/app/modules/register/view/register_view.dart';
import 'package:chat_app_newversion/app/modules/search/view/search_view.dart';
import 'package:chat_app_newversion/app/modules/update_status/view/update_status_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../modules/introduction/view/introduction_screen.dart';

class RouteClass {
  static String login = '/Login';
  static String home = '/Home';
  static String register = '/Register';
  static String profile = '/Profile';
  static String chatroom = '/Chat-room';
  static String introduction = '/Introduction';
  static String search = '/Search';
  static String updatestatus ='/UpdateStatus';
  static String editprofile = '/EditProfile';

  static String getHomeScreen() => home;
  static String getregisterScreen() => register;
  static String getloginScreen() => login;
  static String getprofileScreen() => profile;
  static String getChatRoomScreen() => chatroom;
  static String getIntroductionScreen() => introduction;
  static String getSearchScreen() => search;
  static String getUpdateStatus() => updatestatus;
  static String getEditProfileScreen() => editprofile;

  static List<GetPage> routes =[
    GetPage(name: home, page:() => const HomeView()),
    GetPage(name: login, page:() => const SignInPage()),
    GetPage(name: register, page: () => const SignUpView()),
    GetPage(name: profile, page: () => const ProfileView()),
    GetPage(name: chatroom, page: () => const ChatRoomView()),
    GetPage(name: introduction, page: () => const IntroductionView()),
    GetPage(name: search, page:() => const SearchView()),
    GetPage(name: updatestatus, page:() => const UpdateStatusView()),
    GetPage(name: editprofile, page: () => const EditProfileView() , binding: EditProfileBinding())

  ];
}