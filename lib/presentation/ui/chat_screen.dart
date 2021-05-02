import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/networking/image_address_provider.dart';
import 'package:book_shop/presentation/animation/fade_in_animation.dart';
import 'package:book_shop/presentation/widgets/customer_agent_widget.dart';
import 'package:book_shop/presentation/widgets/from_message_bubble.dart';
import 'package:book_shop/presentation/widgets/my_tool_bar.dart';
import 'package:book_shop/presentation/widgets/user_message_bubble.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  Map<String, String> args;
  @override
  _ChatScreenState createState() => _ChatScreenState();
  ChatScreen({this.args});
}

class _ChatScreenState extends State<ChatScreen> {
  Map<String, String> arguments;
  String thumbImage, id, name, writer;
  @override
  void initState() {
    arguments = widget.args;
    _getArguments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 23,
            ),
            Align(
                alignment: Alignment.center,
                child: FadeInAnimation(
                    0.25, MyToolBar(title: Strings.chatSpeakWithSeller))),
            SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: IColors.green,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      offset: Offset(7, 7),
                      color: IColors.balck35),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 27, vertical: 16),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 81,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  offset: Offset(7, 7),
                                  blurRadius: 10)
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Hero(
                              tag: "post_${id}_v",
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.transparent),
                                child: Image.network(
                                    ImageAddressProvider.imageURL + thumbImage),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 34,
                        ),
                        Container(
                          width: 94,
                          child: Text(
                            "${name}",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: Strings.fontIranSans,
                                color: IColors.balck85),
                          ),
                        ),
                        Container(
                          width: 94,
                          child: Text("${writer}",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: Strings.fontIranSans,
                                  color: IColors.balck35)),
                        )
                      ],
                    ),
                    Positioned(
                        top: 94,
                        left: 20,
                        child: Center(child: CustomerAgentWidget())),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Container(
              color: Colors.white,
              child: Container(
                  child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [UserMessageBubble(), FromMessageBubble()],
              )),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: IColors.lowedBoldGreen,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8),
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: [
                    Icon(
                      Icons.send,
                      color: IColors.boldGreen,
                      size: 22,
                      textDirection: TextDirection.ltr,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          color: IColors.balck85,
                          fontFamily: Strings.fontIranSans,
                          fontSize: 14,
                        ),
                        minLines: 1,
                        maxLines: 6,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'یک پیام بنویسید...',
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  void _getArguments() {
    thumbImage = arguments['thumbPicture'];
    id = arguments['post_id'];
    name = arguments['name'];
    writer = arguments['writer'];
  }
}
