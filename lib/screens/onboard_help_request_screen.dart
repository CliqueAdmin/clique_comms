import 'package:clique_comms/widgets/help_imagepicker.dart';
import 'package:flutter/material.dart';

class OnboardHelpRequestScreen extends StatefulWidget {
  static const routeName = '/help-request';

  @override
  _OnboardHelpRequestScreenState createState() =>
      _OnboardHelpRequestScreenState();
}

class _OnboardHelpRequestScreenState extends State<OnboardHelpRequestScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    this.tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("this.widget.title"),
              background: Image.network(
                'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: StickyTabBarDelegate(
              child: TabBar(
                labelColor: Colors.black,
                controller: this.tabController,
                tabs: <Widget>[
                  Tab(text: 'Home'),
                  Tab(text: 'Profile'),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: this.tabController,
              children: <Widget>[
                Center(
                  child: HelpImagePicker(),
                ),
                Center(child: Text('Content of Profile')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListWidget(Color color, String text) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 48),
        ),
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class OnboardHelpRequestHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.greenAccent,
      child: Center(
        child: Text(
          "headerTitle",
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 500;

  @override
  double get minExtent => 200;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
