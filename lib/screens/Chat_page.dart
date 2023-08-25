import 'package:flutter/material.dart';
//import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:scholar_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/models/message_model.dart';
import '../widgets/chat_bubble.dart';

class ChatPage extends StatelessWidget {
   ChatPage({Key? key}) : super(key: key);
  static  String ChatPageiId ="ChatPage";
  TextEditingController controller =TextEditingController();
   CollectionReference messages = FirebaseFirestore.instance.collection(kMessgageCollection);
       final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context)!.settings.arguments.toString();
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt,descending: true).snapshots(),
      builder: (context ,snapshot){
        if (snapshot.hasData) {
          List<Message> messagesList =[];
          for(int i =0;i<snapshot.data!.docs.length;i++)
          {
             messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          
           
  return
  // ModalProgressHUD(
   // inAsyncCall: false,
    //child:
     Scaffold(
         appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Image.asset(kLogo,
    height: 50,
    ),
    Text("Chat"),
          ],) ,
          centerTitle: true,
          automaticallyImplyLeading: false,
         ),
         body: Column(
           children: [Expanded(
     child: ListView.builder(
      reverse: true,
      controller: _controller,
      itemCount: messagesList.length,
      itemBuilder: (context,index)
     {
     
         return  messagesList[index].id == id? ChatBubble(message: messagesList[index]):
         ChatBubbleForFrind(message: messagesList[index]
         )
         ;
         
     }),
           ),
     Padding(
       padding:  EdgeInsets.all(16),
       child: TextField(
        controller: controller,
        onSubmitted: (data){
           messages.add({"message": data,
           "createdAt": DateTime.now(),
           "id": id
           });
           controller.clear();
           _controller.animateTo(
      0,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
        },
          
        decoration: InputDecoration(
          hintText: "Send Message",
          suffixIcon: Icon(
            Icons.send,
            color: kPrimaryColor
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:const BorderSide(color: kPrimaryColor),
            borderRadius: BorderRadius.circular(16)
          ),
          border: OutlineInputBorder(
            borderSide:const BorderSide(color: kPrimaryColor),
            borderRadius: BorderRadius.circular(16)
          ),
        ),
       ),
     )
           ]
         )
    
      //  ),
  );
}
     else{
      return 
      // ModalProgressHUD(
      //   inAsyncCall: true,
      //   child:
         Scaffold(
          appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Image.asset(kLogo,
        height: 50,
        ),
        Text("Chat"),
          ],) ,
          centerTitle: true,
          automaticallyImplyLeading: false,
         ),
          
       // ),
      );
     }
      }
    );
  }
}

