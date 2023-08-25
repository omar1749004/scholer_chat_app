import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/models/message_model.dart';

import '../constants.dart';

class ChatBubble extends StatelessWidget {
   ChatBubble({
    required this.message
  }) ;
 final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
       padding: EdgeInsets.only(left: 16,top: 20,bottom: 20,right: 16),
       margin:const  EdgeInsets.symmetric(horizontal: 16,vertical: 8),
       decoration:const  BoxDecoration(
         borderRadius: BorderRadius.only(
           topLeft: Radius.circular(32),
           topRight:  Radius.circular(32),
           bottomRight: Radius.circular(32)
         ),
         color: kPrimaryColor
       ),
       child: Text(message.message,
       style: TextStyle(
         color: Colors.white,
         fontSize: 16
       ),),
       
      ),
    );
  }
}
class ChatBubbleForFrind extends StatelessWidget {
   ChatBubbleForFrind({
    required this.message
  }) ;
 final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
       padding: EdgeInsets.only(left: 16,top: 20,bottom: 20,right: 16),
       margin:const  EdgeInsets.symmetric(horizontal: 16,vertical: 8),
       decoration:const  BoxDecoration(
         borderRadius: BorderRadius.only(
           topLeft: Radius.circular(32),
           topRight:  Radius.circular(32),
           bottomLeft: Radius.circular(32)
         ),
         color: Colors.blue
       ),
       child: Text(message.message,
       style: TextStyle(
         color: Colors.white,
         fontSize: 16
       ),),
       
      ),
    );
  }
}
//Color.fromARGB(255, 43, 160, 255)