import 'package:fcm_test/model/message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    _printToken();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        final notification = message["data"];
        setState(() {
          messages.add(Message(
              title: 'OnMessage: ${notification["title"]}',
              body: 'OnMessage: ${notification["body"]}'));
        });
        _showDialogBox(message["data"]["title"], message["data"]["body"]);
      },
      onLaunch: (Map<String, dynamic> message) async {
        final notification = message["data"];
        setState(() {
          messages.add(Message(
              title: 'OnLaunch: ${notification['title']}',
              body: 'OnLaunch: ${notification['body']}'));
        });
        _showDialogBox(message["data"]["title"], message["data"]["body"]);
      },
      onResume: (Map<String, dynamic> message) async {
        final notification = message["data"];
        setState(() {
          messages.add(Message(
              title: 'OnResume: ${notification['title']}',
              body: 'OnResume: ${notification['body']}'));
        });
        _showDialogBox(message["data"]["title"], message["data"]["body"]);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: messages.map(buildMessage).toList(),
    );
  }

  Widget buildMessage(Message message) {
    return ListTile(title: Text(message.title), subtitle: Text(message.body));
  }

  void _printToken() async {
    var token = await _firebaseMessaging.getToken();
    print("Device token: $token");
  }

  void _showDialogBox(title, body) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              FlatButton(
                child: Text("FECHAR"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
