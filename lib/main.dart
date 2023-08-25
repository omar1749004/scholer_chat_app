import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:scholar_chat/screens/Chat_page.dart';
import 'package:scholar_chat/screens/login_page.dart';
import 'package:scholar_chat/screens/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
 void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ScholarChat());
}
class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "LoginPage" :(context)=> LoginPage(),
        RegisterPage.id :(context) => RegisterPage(),
        ChatPage.ChatPageiId :(context) => ChatPage()
      },
      //initialRoute: ChatPage.id,
      
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}