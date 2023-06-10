// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget {
  TabController? tabController;
  List<Widget> children;
  TabBarWidget({Key? key, required this.tabController, required this.children})
      : super(
          key: key,
        );

  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
          controller: widget.tabController, children: widget.children),
    );
  }
}
