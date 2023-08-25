import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/screens/Chat_page.dart';
import 'package:scholar_chat/screens/register_page.dart';
import 'package:scholar_chat/widgets/custom_botton.dart';
import 'package:scholar_chat/widgets/custome_text_failed.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? emailAddress;

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
                  Text("Log in",
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
                  emailAddress = data;
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
                title: "Log in",
                onTap: () async {
                  if (formkey.currentState!.validate()) {
                    try {
                      isLoading = true;
                      setState(() {});
                      await loginuser();
                      Navigator.pushNamed(context, ChatPage.ChatPageiId, arguments: emailAddress);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showSnackBar(context, 'No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        showSnackBar(
                            context, 'Wrong password provided for that user.');
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  }
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "don't have an account ?",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterPage.id);
                    },
                    child: const Text(
                      "Register",
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

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future<void> loginuser() async {
    // UserCredential user = 
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress!, password: password!);
  }
}
//0xff2B475E
//'No user found for that email.'