import 'package:flutter/material.dart';
import 'package:jaras01/components/BreakingNewsMarqueeWidget.dart';
import 'package:jaras01/components/ViewAllHeadingWidget.dart';
import 'package:jaras01/components/home2/component/DashBoard2BreakingNewsListWidget.dart';
import 'package:jaras01/components/home2/component/DashBoard2NewsListWidget.dart';
import 'package:jaras01/components/home2/component/DashBoard2TwitterFeedListWidget.dart';
import 'package:jaras01/models/DashboardResponse.dart';
import 'package:jaras01/screens/ViewAllNewsScreen.dart';
import 'package:jaras01/screens/ViewAllVideoScreen.dart';
import 'package:jaras01/utils/Colors.dart';
import 'package:jaras01/utils/Constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../AppLocalizations.dart';
import '../QuickReadWidget.dart';
import '../StoryListWidget.dart';
import 'component/DashBoard2VideoListWidget.dart';

class Dashboard2Widget extends StatefulWidget {
  final AsyncSnapshot<DashboardResponse> snap;

  Dashboard2Widget(this.snap);

  @override
  Dashboard2WidgetState createState() => Dashboard2WidgetState();
}

class Dashboard2WidgetState extends State<Dashboard2Widget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var appLocalization = AppLocalizations.of(context)!;

    return SafeArea(
      top: !isIos ? true : false,
      child: Container(
        height: context.height(),
        width: context.width(),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BreakingNewsMarqueeWidget(data: widget.snap.data!.breaking_post),

              StoryListWidget(
                list: widget.snap.data!.story_post,
                backgroundColor: white,
                textColor: scaffoldColorDark,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  20.height,
                  ViewAllHeadingWidget(
                    title: appLocalization.translate('breaking_News').toUpperCase(),
                    backgroundColor: white,
                    textColor: scaffoldColorDark,
                    onTap: () {
                      ViewAllNewsScreen(title: 'breaking_News', req: {'posts_per_page': postsPerPage, FILTER: FILTER_FEATURE}).launch(context);
                    },
                  ),
                  8.height,
                  DashBoard2BreakingNewsListWidget(widget.snap.data!.breaking_post),
                ],
              ).visible(widget.snap.data!.breaking_post.validate().isNotEmpty),

              // Quick Read
              QuickReadWidget(widget.snap.data!.recent_post),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  16.height,
                  ViewAllHeadingWidget(
                    title: appLocalization.translate('recent_News').toUpperCase(),
                    backgroundColor: white,
                    textColor: scaffoldColorDark,
                    onTap: () {
                      ViewAllNewsScreen(title: 'recent_News', req: {'posts_per_page': postsPerPage}).launch(context);
                    },
                  ),
                  8.height,
                  DashBoard2NewsListWidget(widget.snap.data!.recent_post, padding: EdgeInsets.symmetric(horizontal: 8)),
                ],
              ).visible(widget.snap.data!.recent_post.validate().isNotEmpty),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  16.height,
                  ViewAllHeadingWidget(
                    title: appLocalization.translate('videos').toUpperCase(),
                    backgroundColor: white,
                    textColor: scaffoldColorDark,
                    onTap: () {
                      ViewAllVideoScreen().launch(context);
                    },
                  ),
                  8.height,
                  DashBoard2VideoListWidget(widget.snap.data!.videos.validate(), axis: Axis.horizontal),
                ],
              ).visible(widget.snap.data!.videos.validate().isNotEmpty),

              16.height,

              //Show Twitter Widget only if you have not disabled in your Word-Press Admin panel
              DashBoard2TwitterFeedListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
