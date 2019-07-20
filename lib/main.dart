import 'package:fcm_test/widgets/messaging_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(primaryColor: Colors.green),
      home: MainPage(),
    ));

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testando FCM"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: MessagingWidget(),
    );
  }
}
