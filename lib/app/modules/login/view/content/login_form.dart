
import 'package:chat_app_newversion/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/default_button.dart';
import '../../../../utils/size_config.dart';
import '../../../register/view/register_view.dart';

class SignInForm extends StatelessWidget {
  SignInForm({
    Key? key,
  }) : super(key: key);
  final formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    var emailcontroller = TextEditingController();
    var passwordcontroller = TextEditingController();
    return Form(
        key: formkey,
        child: Column(
          children: [
            TextFormField(
              controller: emailcontroller,
              validator: (val) {
                if (val!.isEmpty && !val.contains('@')) {
                  return 'Email is Not Valid';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              onSaved: (val) => email = val!,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Enter your Email",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: const Icon(Icons.lock),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20), gapPadding: 5),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20), gapPadding: 5),
              ),
            ),
            SizedBox(
              height: getProportionateScreenWidth(20),
            ),
            TextFormField(
              obscureText: true,
              validator: (val) {
                if (val!.isEmpty && val.length < 7) {
                  return 'Password must be at least 7 characters';
                }
                return null;
              },
              onSaved: (val) => password = val!,
              controller: passwordcontroller,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter your password",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: const Icon(Icons.email_outlined),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20), gapPadding: 5),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20), gapPadding: 5),
              ),
            ),
            SizedBox(
              height: getProportionateScreenWidth(20),
            ),
            DefaultButton(
                text: 'Sign In',
                press: () {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState!.save();
                    AuthController().Login(emailcontroller.text.trim(), passwordcontroller.text.trim());
                  }
                },
                width: double.infinity),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't Have an account ? ",
                  style: TextStyle(),
                ),
                TextButton(
                    onPressed: () {
                      Get.to(const SignUpView());
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: kPrimaryColor),
                    ))
              ],
            )
          ],
        ));
  }
}
