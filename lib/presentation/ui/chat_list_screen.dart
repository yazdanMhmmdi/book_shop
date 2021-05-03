import 'package:book_shop/constants/colors.dart';
import 'package:book_shop/constants/strings.dart';
import 'package:book_shop/logic/bloc/chatlist_bloc.dart';
import 'package:book_shop/presentation/animation/fade_in_animation.dart';
import 'package:book_shop/presentation/ui/vertical_card_support.dart';
import 'package:book_shop/presentation/widgets/back_button_widget.dart';
import 'package:book_shop/presentation/widgets/loading_bar.dart';
import 'package:book_shop/presentation/widgets/my_tool_bar.dart';
import 'package:book_shop/presentation/widgets/not_found_bar.dart';
import 'package:book_shop/presentation/widgets/server_failure_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  ScrollController _controller = ScrollController();
  ChatlistBloc _chatlistBloc;
  double _animationDelay = 0.25;
  bool progress = true;
  @override
  void initState() {
    _chatlistBloc = BlocProvider.of<ChatlistBloc>(context);
    _chatlistBloc.add(GetChatList());
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print('end of page');
        _chatlistBloc.add(GetChatList());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatlistBloc, ChatlistState>(
      listener: (context, state) {
        if (state is ChatlistSuccess) {
          setState(() {
            progress = false;
            _animationDelay = _animationDelay + 0.3;
          });
        } else {}
      },
      child: Scaffold(
        body: Stack(
          children: [
            progress
                ? Center(
                    child: MyLoadingBar(
                      animation: 'Untitled',
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 23,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FadeInAnimation(
                                0.5,
                                BackButtonWidget(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              FadeInAnimation(
                                  0.25, MyToolBar(title: Strings.chatLabel)),
                              //for aligning
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
                        BlocBuilder<ChatlistBloc, ChatlistState>(
                          builder: (context, state) {
                            if (state is ChatlistInitial) {
                              return Container();
                            } else if (state is ChatlistLoading) {
                              return Container();
                            } else if (state is ChatlistSuccess) {
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  controller: _controller,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      state.chatListModel.chatsList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return FadeInAnimation(
                                      _animationDelay,
                                      VerticalCardSupport(
                                        id: "${state.chatListModel.chatsList[index].bookIdNum}",
                                        image: "image",
                                        name:
                                            "${state.chatListModel.chatsList[index].name}",
                                        writer:
                                            "${state.chatListModel.chatsList[index].writer}",
                                        thumbImage:
                                            "${state.chatListModel.chatsList[index].pictureThumb}",
                                        voteCount: double.parse(state
                                            .chatListModel
                                            .chatsList[index]
                                            .voteCount
                                            .toString()),
                                        price:
                                            "${state.chatListModel.chatsList[index].price}",
                                        newMessageCount: state.chatListModel
                                            .chatsList[index].newMessageCount
                                            .toString(),
                                        userId: state.userId,
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else if (state is ChatlistFailure) {
                              return Center(child: ServerFailureFlare());
                            } else if (state is ChatlistEmpty) {
                              return Center(child: NotFoundBar());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
