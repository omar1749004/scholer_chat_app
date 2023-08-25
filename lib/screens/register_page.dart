import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/src/widgets/framework.dart';
import "package:flutter/material.dart";
import 'package:scholar_chat/constants.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../helper/ShowSnackBar.dart';
import '../widgets/custom_botton.dart';
import '../widgets/custome_text_failed.dart';
import 'Chat_page.dart';

class RegisterPage extends StatefulWidget {
  static String id = "RegisterPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return 
    // ModalProgressHUD(
    //   inAsyncCall: isLoading,
    //   child:
       Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formkey,
            child: ListView(children: [
              const SizedBox(
                height: 75,
              ),
              Image.asset(
                "assets/images/scholar.png",
                height: 100,
              ),
              const Center(
                child: Text(
                  "ScholarChat",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontFamily: "Pacifico"),
                ),
              ),
              const SizedBox(
                height: 75,
              ),
              const Row(
                children: [
                  Text("Register",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFailed(
                hintText: "Email",
                onchange: (data) {
                  email = data;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFailed(
                secur: true,
                hintText: "Password",
                onchange: (data) {
                  password = data;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                onTap: () async {
                  isLoading = true;
                  setState(() {});
                  if (formkey.currentState!.validate()) {
                    try {
                      await RegisreUser();
                      Navigator.pushNamed(context, ChatPage.ChatPageiId,arguments:email);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showSnackBar(
                            context, "The password provided is too weak");
                      } else if (e.code == 'email-already-in-use') {
                        showSnackBar(context,
                            "The account already exists for that email");
                      }
                    } 
                  }
                  else
                  isLoading = false;
                  setState(() {});
                },
                title: "Rigester",
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "already have an account ?",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "   Log in",
                      style: TextStyle(color: Color(0xffC7EDE7)),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
    //  ),
    );
  }

  Future<void> RegisreUser() async {
    // UserCredential user = 
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
