import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/constants/color.dart';
import 'package:demo_app/screens/chat_screen/chatpage.dart';
import 'package:demo_app/screens/chat_screen/comps/styles.dart';
import 'package:demo_app/screens/chat_screen/comps/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<ChatScreen> {
  final firestore = FirebaseFirestore.instance;
  bool open = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(0),
                child: Container(
                  color: primaryColor,
                  padding: const EdgeInsets.all(8),
                  height: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10),
                        child: Text(
                          'Recent Users',
                          style: Styles.h1(),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: 80,
                        child: StreamBuilder(
                            stream: firestore.collection('Rooms').snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              List data = !snapshot.hasData
                                  ? []
                                  : snapshot.data!.docs
                                      .where((element) => element['users']
                                          .toString()
                                          .contains(FirebaseAuth
                                              .instance.currentUser!.uid))
                                      .toList();
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length,
                                itemBuilder: (context, i) {
                                  List users = data[i]['users'];
                                  var friend = users.where((element) =>
                                      element !=
                                      FirebaseAuth.instance.currentUser!.uid);
                                  var user = friend.isNotEmpty
                                      ? friend.first
                                      : users
                                          .where((element) =>
                                              element ==
                                              FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          .first;
                                  return FutureBuilder(
                                      future: firestore
                                          .collection('user')
                                          .doc(user)
                                          .get(),
                                      builder: (context, AsyncSnapshot snap) {
                                        return !snap.hasData
                                            ? Container()
                                            : ChatWidgets.circleProfile(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return ChatPage(
                                                          id: user,
                                                          name: snap
                                                              .data['userName'],
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                                name: snap.data['userName']);
                                      });
                                },
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: Styles.friendsBox(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Text(
                        'Contacts',
                        style: Styles.h1().copyWith(color: Colors.indigo),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: StreamBuilder(
                            stream: firestore.collection('Rooms').snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              List data = !snapshot.hasData
                                  ? []
                                  : snapshot.data!.docs
                                      .where((element) => element['users']
                                          .toString()
                                          .contains(FirebaseAuth
                                              .instance.currentUser!.uid))
                                      .toList();
                              return ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, i) {
                                  List users = data[i]['users'];
                                  var friend = users.where((element) =>
                                      element !=
                                      FirebaseAuth.instance.currentUser!.uid);
                                  var user = friend.isNotEmpty
                                      ? friend.first
                                      : users
                                          .where((element) =>
                                              element ==
                                              FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          .first;
                                  return FutureBuilder(
                                      future: firestore
                                          .collection('user')
                                          .doc(user)
                                          .get(),
                                      builder: (context, AsyncSnapshot snap) {
                                        return !snap.hasData
                                            ? Container()
                                            : ChatWidgets.card(
                                                title: snap.data['userName'],
                                                subtitle: data[i]
                                                    ['last_message'],
                                                time: DateFormat('hh:mm a')
                                                    .format(data[i][
                                                            'last_message_time']
                                                        .toDate()),
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return ChatPage(
                                                          id: user,
                                                          name: snap.data[
                                                              'userName'],
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              );
                                      });
                                },
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ChatWidgets.searchBar(open)
        ],
      ),
    );
  }
}
