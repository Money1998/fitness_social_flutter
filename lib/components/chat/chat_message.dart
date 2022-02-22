// import 'package:flutter/material.dart';
// import 'package:montage/components/chat/message.dart';
// import 'package:montage/components/chat/user_icon.dart';

// class ChatList extends StatefulWidget {
//   final bool isLeft;
//   final int index;
//   final dynamic data;

//   ChatList({
//     this.data,
//     this.isLeft,
//     this.index,
//   });
//   _ChatListState createState() => _ChatListState();
// }

// class _ChatListState extends State<ChatList> {
//   @override
//   Widget build(BuildContext context) {
//     Widget row = Container();
//     if (widget.data['messageType'] == 1) {
     
//       row = Cmessage(
//         message: widget.data['message'],
//         messageId: widget.data['messageId'],
//         isLeft: widget.data['isLeft'],
//         time: widget.data['time'],
//         index: widget.index,
//         likes: widget.data['liked'],
//       );
//     }
//     return Row(
//       children: <Widget>[
//         // user photo
//         ChatUserIcon(
//                 userId: widget.data['userId'],
//                 userName: widget.data['userName'],
//                 isLeft: widget.data['isLeft']),
//         GestureDetector(
//           child: row,
//         )
//       ],
//     );
//   }
// }
