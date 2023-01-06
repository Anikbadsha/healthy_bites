import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatBar extends StatefulWidget {
  const ChatBar({super.key});

  @override
  State<ChatBar> createState() => _ChatBarState();
}

class _ChatBarState extends State<ChatBar> {
  // final String title = "Live Chat Support";
  // final String selectedUrl =
  //     "https://tawk.to/chat/63b5502147425128790b9374/1glu420ts";
  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();

  // int position = 1;

  // final key = UniqueKey();
  // downLoading(String A) {
  //   setState(() {
  //     position = 0;
  //   });
  // }

  // StartLoading(String A) {
  //   setState(() {
  //     position = 1;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Healthy Bites Online Agent"),
        backgroundColor: Color_me.main,
      ),
      body: Tawk(
        directChatLink:
            'https://tawk.to/chat/63b5502147425128790b9374/1glu420ts',
        visitor: TawkVisitor(
          name: '',
          email: '',
        ),
      ),
    );
  }
}
