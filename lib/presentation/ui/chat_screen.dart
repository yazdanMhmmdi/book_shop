import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/logic/bloc/chat_bloc.dart';
import 'package:book_shop/networking/image_address_provider.dart';
import 'package:book_shop/presentation/animation/fade_in_animation.dart';
import 'package:book_shop/presentation/widgets/back_button_widget.dart';
import 'package:book_shop/presentation/widgets/customer_agent_widget.dart';
import 'package:book_shop/presentation/widgets/from_message_bubble.dart';
import 'package:book_shop/presentation/widgets/my_tool_bar.dart';
import 'package:book_shop/presentation/widgets/user_message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  Map<String, String> args;
  @override
  _ChatScreenState createState() => _ChatScreenState();
  ChatScreen({this.args});
}

class _ChatScreenState extends State<ChatScreen> {
  Map<String, String> arguments;
  String thumbImage, id, name, writer;
  ChatBloc _chatBloc;
  String userId;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    arguments = widget.args;
    _getArguments();
    _chatBloc = BlocProvider.of<ChatBloc>(context);
    _chatBloc.add(DisposeChatMessages());
    _chatBloc.add(GetChatMessages(book_id: id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IColors.backgroundColor,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            SizedBox(
              height: 23,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButtonWidget(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: FadeInAnimation(
                          0.25, MyToolBar(title: Strings.chatSpeakWithSeller))),
                  Container(
                    width: 25,
                    height: 25,
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
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
                        Hero(
                          tag: "post_${id}_v",
                          child: Container(
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
                        child: Center(
                            child: Hero(
                                tag: 'post_${id}_agent',
                                child: CustomerAgentWidget()))),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Container(
              color: Colors.white,
              child: Container(child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatLoading) {
                    return Container();
                  } else if (state is ChatSuccess) {
                    scrollBottom();
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.chatModel.chats.length,
                      itemBuilder: (context, index) {
                        return state.chatModel.chats[index].userId == userId
                            ? UserMessageBubble(
                                message: state.chatModel.chats[index].message,
                              )
                            : FromMessageBubble(
                                message: state.chatModel.chats[index].message);
                      },
                    );
                  } else if (state is ChatEmpty) {
                    return Container();
                  } else if (state is ChatFailure) {
                    return Container();
                  } else if (state is ChatInitial) {
                    return Container();
                  }
                },
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
    userId = arguments['user_id'];
    id = arguments['post_id'];
    name = arguments['name'];
    writer = arguments['writer'];
  }

  void scrollBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 70,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }
}
