import 'package:carousel_slider/carousel_slider.dart';
import 'package:clique_comms/providers/top_quotes.dart';
import 'package:clique_comms/widgets/custom_tab.dart';
import 'package:clique_comms/widgets/top_quote.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommunityLandingScreen extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  const CommunityLandingScreen(this.analytics, this.observer);
  static const routeName = '/landing';
  @override
  _CommunityLandingScreenState createState() => _CommunityLandingScreenState();
}

class _CommunityLandingScreenState extends State<CommunityLandingScreen>
    with TickerProviderStateMixin {
  //todo: Maybe add analytics some point of time

  int _selectedIndex = 0;
  var _isInit = true;
  var _isLoading = true;

  List<CustomTab> myTabs = <CustomTab>[];
  TopQuotes productsData;
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
      Provider.of<TopQuotes>(context).fetchAndSetTopQuotes().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    productsData = Provider.of<TopQuotes>(context);
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  elevation: 20,
                  pinned: false,
                  snap: false,
                  floating: false,
                  expandedHeight: 350.0,
                  flexibleSpace: const FlexibleSpaceBar(
                    background: FlutterLogo(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Container(
                      child: CarouselSlider.builder(
                        itemCount: 7,
                        itemBuilder: _buildTopQuoteWidget,
                        options: CarouselOptions(
                          viewportFraction: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Container(
                      child: CarouselSlider.builder(
                        itemCount: 7,
                        itemBuilder: _buildTopQuoteWidget,
                        options: CarouselOptions(
                          viewportFraction: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Container(
                      child: CarouselSlider.builder(
                        itemCount: 7,
                        itemBuilder: _buildTopQuoteWidget,
                        options: CarouselOptions(enableInfiniteScroll: false
                            // viewportFraction: 3.0,
                            ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: SizedBox(
                      height: 400,
                      width: 300,
                      child: CarouselSlider.builder(
                        itemCount: 7,
                        itemBuilder: _buildTopQuoteWidget,
                        options: CarouselOptions(
                          viewportFraction: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget _buildTopQuoteWidget(BuildContext context, int index, int realIndex) {
    return ChangeNotifierProvider.value(
      value: productsData.items[index],
      child: Container(
          height: double.infinity,
          width: double.infinity,
          child: TopQuoteWidget()),
    );
  }
}
