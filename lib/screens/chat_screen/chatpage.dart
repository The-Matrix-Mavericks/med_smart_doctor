import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/constants/color.dart';
import 'package:demo_app/screens/chat_screen/comps/styles.dart';
import 'package:demo_app/screens/chat_screen/comps/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_samples/screens/chat_page/comps/styles.dart';
// import 'package:flutter_samples/screens/chat_page/comps/widgets.dart';
// import 'package:image/comps/styles.dart';
// import 'package:image/comps/widgets.dart';
import 'package:intl/intl.dart';
import 'package:demo_app/screens/chat_screen/vediocall.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatPage extends StatefulWidget {
  final String id;
  final String name;
  final int index;
  const ChatPage(
      {Key? key, required this.id, required this.name, required this.index})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var roomId;
  // final callIDTextCtrl = TextEditingController(text: "testCallID");
  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: primaryColor,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[700],
              backgroundImage: AssetImage(docImages[widget.index]),
              // child: Image.asset(
              //   docImages[widget.index],
              //   fit: BoxFit.cover,
              // ),
            ),
            8.widthBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: Styles.h1()
                      .copyWith(color: Colors.white, fontFamily: 'Poppins'),
                ),
                0.heightBox,
                StreamBuilder(
                    stream:
                        firestore.collection('user').doc(widget.id).snapshots(),
                    builder: (context,
                        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                            snapshot) {
                      return !snapshot.hasData
                          ? Container()
                          : Text(
                              'last seen today at ' +
                                  DateFormat('h:mm a').format(
                                      snapshot.data!['date_time'].toDate()),
                              style: Styles.h1().copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white70),
                            );
                    }),
                // StreamBuilder(
                //     stream: firestore
                //         .collection('doctor')
                //         .doc(widget.id)
                //         .snapshots(),
                //     builder: (context,
                //         AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                //             snapshot) {
                //       return !snapshot.hasData
                //           ? Container()
                //           : Text(
                //               'last seen today at ' +
                //                   DateFormat('h:mm a').format(
                //                       snapshot.data!['date_time'].toDate()),
                //               style: Styles.h1().copyWith(
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.normal,
                //                   color: Colors.white70),
                //             );
                //     }),
              ],
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(right: 0.0),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
                size: 20,
              )),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CallPage(callID: roomId.toString());
                  }));
                },
                icon: const Icon(
                  FontAwesomeIcons.video,
                  color: Colors.white,
                  size: 20,
                )),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(18.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Text(
          //         'Chats',
          //         style: Styles.h1(),
          //       ),
          //       const Spacer(),
          //       StreamBuilder(
          //           stream:
          //               firestore.collection('user').doc(widget.id).snapshots(),
          //           builder: (context,
          //               AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
          //                   snapshot) {
          //             return !snapshot.hasData
          //                 ? Container()
          //                 : Text(
          //                     'Last seen : ' +
          //                         DateFormat('hh:mm a').format(
          //                             snapshot.data!['date_time'].toDate()),
          //                     style: Styles.h1().copyWith(
          //                         fontSize: 12,
          //                         fontWeight: FontWeight.normal,
          //                         color: Colors.white70),
          //                   );
          //           }),
          //       const Spacer(),
          //       const SizedBox(
          //         width: 50,
          //       )
          //     ],
          //   ),
          // ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.green[50]),
              child: StreamBuilder(
                  stream: firestore.collection('Rooms').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isNotEmpty) {
                        List<QueryDocumentSnapshot?> allData = snapshot
                            .data!.docs
                            .where((element) =>
                                element['users'].contains(widget.id) &&
                                element['users'].contains(
                                    FirebaseAuth.instance.currentUser!.uid))
                            .toList();
                        QueryDocumentSnapshot? data =
                            allData.isNotEmpty ? allData.first : null;
                        if (data != null) {
                          roomId = data.id;
                        }
                        return data == null
                            ? Container()
                            : StreamBuilder(
                                stream: data.reference
                                    .collection('messages')
                                    .orderBy('datetime', descending: true)
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snap) {
                                  return !snap.hasData
                                      ? Container()
                                      : ListView.builder(
                                          itemCount: snap.data!.docs.length,
                                          reverse: true,
                                          itemBuilder: (context, i) {
                                            return MessageBubble(
                                                user: snap.data!.docs[i]
                                                        ['sent_by'] ==
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid,
                                                msgText: snap.data!.docs[i]
                                                    ['message'],
                                                msgSender: DateFormat('hh:mm a')
                                                    .format(snap.data!
                                                        .docs[i]['datetime']
                                                        .toDate()));
                                          },
                                        );
                                });
                      } else {
                        return Center(
                          child: Text(
                            'No conversion found',
                            style: Styles.h1().copyWith(color: primaryColor),
                          ),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }
                  }),
            ),
          ),
          Container(
            color: Colors.green[50],
            child: ChatWidgets.messageField(onSubmit: (controller) {
              if (controller.text.toString() != '') {
                if (roomId != null) {
                  Map<String, dynamic> data = {
                    'message': controller.text.trim(),
                    'sent_by': FirebaseAuth.instance.currentUser!.uid,
                    'datetime': DateTime.now(),
                  };
                  firestore.collection('Rooms').doc(roomId).update({
                    'last_message_time': DateTime.now(),
                    'last_message': controller.text,
                  });
                  firestore
                      .collection('Rooms')
                      .doc(roomId)
                      .collection('messages')
                      .add(data);
                } else {
                  Map<String, dynamic> data = {
                    'message': controller.text.trim(),
                    'sent_by': FirebaseAuth.instance.currentUser!.uid,
                    'datetime': DateTime.now(),
                  };
                  firestore.collection('Rooms').add({
                    'users': [
                      widget.id,
                      FirebaseAuth.instance.currentUser!.uid,
                    ],
                    'last_message': controller.text,
                    'last_message_time': DateTime.now(),
                  }).then((value) async {
                    value.collection('messages').add(data);
                  });
                }
              }
              controller.clear();
            }),
          )
        ],
      ),
    );
  }
}
