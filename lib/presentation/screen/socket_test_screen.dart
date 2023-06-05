import 'package:flutter/material.dart';

class SocketTextScreen extends StatefulWidget {
  @override
  _SocketTextScreenState createState() => _SocketTextScreenState();
}

class _SocketTextScreenState extends State<SocketTextScreen> {
  // final channel =
      // IOWebSocketChannel.connect("ws://192.168.1.4:8080/phpWebSocketChat/");
  @override
  void initState() {
    // socketInitial();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: 
        Column(
          children: [
            Text(
              "Simple TexXt",
            ),
            // RaisedButton(
            //   onPressed: () => socketSendMessage(),
            //   child: Text("Send message"),
            // ),
          ],
        ),
      ),
    );
  }

  // socketInitial() async {
  //   try {
  //     channel.stream.listen((event) {
  //       channel.sink.add('{"type": "socket","user_id": "25"}');
  //       final x = json.decode(event.toString());
  //       print(x);
  //       print(x['msg']);
  //     });
  //   } catch (er) {
  //     print("error socket");
  //   }
  // }

  // socketSendMessage() {
  //   channel.sink.add('{"type":"chat","user_id":25,"chat_msg":"hello"}'.toString());
  //   // print('HEll');
  // }
}
