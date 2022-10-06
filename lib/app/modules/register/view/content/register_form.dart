
import 'package:chat_app_newversion/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import '../../../../utils/default_button.dart';
import '../../../../utils/size_config.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formkey = GlobalKey<FormState>();

  String email = '';

  String password = '';

  String username = '';

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var emailcontroller = TextEditingController();
    var passwordcontroller = TextEditingController();
    var usernamecontroller = TextEditingController();
    return Form(
        key: _formkey,
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
              key: const ValueKey('email'),
              onSaved: (val) => email = val!,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Enter your Email",
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
            TextFormField(
              validator: (val) {
                if (val!.isEmpty && val.length < 4) {
                  return 'Username must be at least 4 characters';
                }
                return null;
              },
              key: const ValueKey('username'),
              onSaved: (val) => username = val!,
              controller: usernamecontroller,
              decoration: InputDecoration(
                labelText: "Username",
                hintText: "Enter your Username",
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
              validator: (val) {
                if (val!.isEmpty && val.length < 7) {
                  return 'Password must be at least 7 characters';
                }
                return null;
              },
              key: const ValueKey('password'),
              onSaved: (val) => password = val!,
              obscureText: true,
              controller: passwordcontroller,
              decoration: InputDecoration(
                labelText: " Password",
                hintText: "Enter your password",
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
            DefaultButton(
                text: 'Sign Up',
                press: () async {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    await AuthController().SignUp(emailcontroller.text.trim(), passwordcontroller.text.trim(), usernamecontroller.text.trim());
                  }
                },
                width: double.infinity)
          ],
        ));
  }
}
