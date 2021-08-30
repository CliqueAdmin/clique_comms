import 'dart:async';
import 'package:clique_comms/providers/top_quotes.dart';
import 'package:clique_comms/screens/onboard_help_request_screen.dart';
import 'package:clique_comms/screens/quotes_screen.dart';
import 'package:clique_comms/widgets/custom_tab.dart';
import 'package:clique_comms/widgets/top_quote.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class CommunityLandingScreen extends StatefulWidget {
  static const routeName = '/landing';
  @override
  _CommunityLandingScreenState createState() => _CommunityLandingScreenState();
}

class _CommunityLandingScreenState extends State<CommunityLandingScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  var _isInit = true;
  var _isLoading = false;

  final List<String> entries = <String>["A", "B", "C"];
  final List<int> colorCodes = <int>[600, 500, 100];

  List<CustomTab> myTabs = <CustomTab>[];

  @override
  void initState() {
    super.initState();
  }

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<TopQuotes>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _getCategories(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  DefaultTabController _getTabController() {
    final productsData = Provider.of<TopQuotes>(context);
    return new DefaultTabController(
      length: 7,
      child: Builder(
        builder: (context) {
          final tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            print("New tab index: ${tabController.index}");
          });

          return Scaffold(
            body: DefaultTabController(
              length: 7,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      expandedHeight: 150.0,
                      floating: false,
                      pinned: true,
                      forceElevated: innerBoxIsScrolled,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text(
                          "Collapsing Toolbar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        background: Image.network(
                          "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverPersistentHeader(
                        delegate: _SliverAppBarTabDelegate(
                          child: PreferredSize(
                            preferredSize: Size.fromHeight(60.0),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: TabBar(
                                labelPadding: EdgeInsets.all(1),
                                isScrollable: true,
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.black38,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Colors.lightGreen,
                                          Colors.lightGreenAccent
                                        ])),
                                indicatorColor: Theme.of(context).primaryColor,
                                tabs: myTabs,
                              ),
                            ),
                          ),
                        ),
                        pinned: true,
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  // These are the contents of the tab views, below the tabs.
                  children: myTabs.map((CustomTab tab) {
                    final ValueKey label = tab.key as ValueKey;
                    return Container(
                      height: 100,
                      width: double.infinity,
                      color: Colors.amberAccent,
                      child: ChangeNotifierProvider.value(
                        value: productsData.items[label.value],
                        child: SafeArea(top: true, child: TopQuoteWidget()),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Business',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: 'School',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              onTap: _onItemTapped,
            ),
          );
        },
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      if (_selectedIndex == index) {
        return;
      }
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        Navigator.of(context).pushNamed(CommunityLandingScreen.routeName);
      }
      if (_selectedIndex == 1) {
        Navigator.of(context).pushNamed(QuotesScreen.routeName);
      }
      if (_selectedIndex == 2) {
        Navigator.of(context).pushNamed(OnboardHelpRequestScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _populateTabs(context);
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : _getTabController();
  }

  void _populateTabs(BuildContext context) {
    myTabs.clear();
    double tw = (MediaQuery.of(context).size.width - 64) / 7;

    DateTime firstDay = findFirstDateOfTheWeek(DateTime.now());
    DateTime lastDay = findLastDateOfTheWeek(DateTime.now());
    DateTime currentDate = DateTime.now();
    for (int i = 0; i <= lastDay.difference(firstDay).inDays; i++) {
      currentDate = firstDay.add(Duration(days: i));
      String abbrWeekday =
          DateFormat(DateFormat.ABBR_WEEKDAY).format(currentDate);
      myTabs.add(
        CustomTab(
          key: ValueKey(i),
          child: Container(
            height: double.infinity,
            width: tw,
            // color: Colors.tealAccent,
            child: new Container(
              // padding: new EdgeInsets.all(32.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text(abbrWeekday),
                  new Text(currentDate.day.toString())
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

class _SliverAppBarTabDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  _SliverAppBarTabDelegate({this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        child: Padding(
      child: child,
      padding: EdgeInsets.symmetric(horizontal: 25),
    ));
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class _ProductTabSliver extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _ProductTabSliver(this._tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.amber,
        ),
        child: _tabBar);
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
