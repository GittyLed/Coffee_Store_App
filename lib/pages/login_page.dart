import 'dart:math';
import 'package:coffee_store_app/components/my_text_field.dart';
import 'package:coffee_store_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../const.dart';
import '../services/user_service.dart';
import '../services/email_service.dart';

class LoginPage extends StatefulWidget {
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  int selectedIndex = 0;
  bool isCodeSent = false;
  final List options = ["מייל", "טלפון"];
  late String code;

  TextEditingController phone = TextEditingController(text: "+972 - ");
  TextEditingController email = TextEditingController();
  TextEditingController codeController = TextEditingController();
  late TextEditingController controller;

  FocusNode myFocusNode = FocusNode();
  final UserService userService = UserService();

  String generateCode() {
  var rng = Random();
  int randomNumber = 100000 + rng.nextInt(900000);
  return randomNumber.toString();
}

  void navigateButtonBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget signInButton(void Function(int)? onTabChange) {
    return Container(
      margin: EdgeInsets.all(25),
      child: GNav(
        onTabChange: onTabChange,
        color: Colors.grey[400],
        activeColor: Colors.grey[700],
        tabBorderRadius: 24,
        tabBackgroundColor: Colors.grey.shade300,
        tabActiveBorder: Border.all(color: Colors.white),
        gap: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        tabs: [
          GButton(icon: Icons.email),
          GButton(icon: Icons.phone),
        ],
      ),
    );
  }

  Widget displayVerificationButtons(int index) {
    String myOption = options[index];
    String text;
    if (myOption == "מייל") {
      text = ' שלחו לי קוד אימות למייל';
      controller = email;
    } else {
      text = 'שלחו לי קוד אימות';
      controller = phone;
    }
    return Column(
      children: [
        MyTextField(
          controller: controller,
          labelText: options[index],
          obscureText: false,
          focusNode: myFocusNode,
        ),
        SizedBox(
          height: 10,
        ),
        isCodeSent
            ? Text("we sent you a code to your email.")
            : GestureDetector(
                onTap: () {
                  setState(() {
                    isCodeSent = true;
                  });
                  code = generateCode();
                  sendVerificationCode(controller.text, code);
                },
                child: Container(
                  padding: EdgeInsets.all(25),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.brown[700],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                )),
      ],
    );
  }

  Widget codeInput() {
    return Column(
      children: [
        MyTextField(
          controller: codeController,
          labelText: "הכנס קוד",
          obscureText: false,
          focusNode: myFocusNode,
        ),
        SizedBox(height: 15,),
        GestureDetector(
        onTap: () {
          verify()
          ? {Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(email: controller.text),)
          ), userService.addUser(controller.text)}
          : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Invalid Code",
                              ),
                            ),);
          
        },
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(horizontal: 25),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.brown[700],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            "Verify",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ))
      ],
    );
  }

  bool verify(){
    return codeController.text == code;
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/images/latte.png", height: 100),

            // Padding(
            //   padding: EdgeInsets.all(25),
            //   child: Image.asset("lib/images/latte.png", height: 100),
            // ),
            SizedBox(
              height: 24,
            ),
            Text(
              'היי, ברוכים הבאים',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.brown[700]),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              'הזינו את מספר הטלפון או המייל על מנת להכנס.',
              style: TextStyle(color: Colors.brown, fontSize: 16),
            ),
            signInButton(navigateButtonBar),
            displayVerificationButtons(selectedIndex),
            SizedBox(
              height: 20,
            ),
            isCodeSent ? codeInput() : Container(),
          ],
        ),
      ),
    );
  }
}
