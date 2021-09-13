import 'package:flutter/material.dart';
import 'package:jaras01/components/BreakingNewsItemWidget.dart';
import 'package:jaras01/models/DashboardResponse.dart';
import 'package:jaras01/screens/NewsDetailListScreen.dart';
import 'package:jaras01/utils/Common.dart';
import 'package:nb_utils/nb_utils.dart';

class BreakingNewsListWidget extends StatefulWidget {
  static String tag = '/BreakingNewsListWidget';
  final List<NewsData>? newsList;

  BreakingNewsListWidget(this.newsList);

  @override
  BreakingNewsListWidgetState createState() => BreakingNewsListWidgetState();
}

class BreakingNewsListWidgetState extends State<BreakingNewsListWidget> {
  //int temp = 2;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //setDynamicStatusBarColor();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getDashBoard2WidgetHeight(),
      child: ListView.builder(
        padding: EdgeInsets.only(left: 8, right: 8),
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          NewsData newsData = widget.newsList![index];

          /*if (temp == index) {
            temp = temp + temp;
          }*/

          return BreakingNewsItemWidget(
            newsData,
            onTap: () => NewsDetailListScreen(widget.newsList, index: index).launch(context),
          );
        },
        itemCount: widget.newsList!.length,
        shrinkWrap: true,
      ),
    );
  }
}
