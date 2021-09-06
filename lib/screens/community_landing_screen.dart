import 'package:carousel_slider/carousel_slider.dart';
import 'package:clique_comms/providers/top_quotes.dart';
import 'package:clique_comms/widgets/custom_tab.dart';
import 'package:clique_comms/widgets/top_quote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'package:transparent_image/transparent_image.dart';

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
  final Stream<QuerySnapshot> deedCategories =
      FirebaseFirestore.instance.collection('deedCategories').snapshots();

  final Stream<QuerySnapshot> quotes =
      FirebaseFirestore.instance.collection('quotes').snapshots();

  var _isInit = true;
  var _isLoading = true;

  TopQuotes quotesData;
  @override
  void initState() {
    super.initState();
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
    quotesData = Provider.of<TopQuotes>(context);
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  elevation: 20,
                  pinned: false,
                  snap: false,
                  floating: false,
                  expandedHeight: 350.0,
                  flexibleSpace: _buildFlexibleSpaceWidget(),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, top: 20, bottom: 10),
                    child: _topQuoteHeading(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: quotes,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('error');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('loading');
                      }
                      final data = snapshot.requireData;
                      return CarouselSlider.builder(
                        itemCount: data.size,
                        itemBuilder: _buildTopQuoteWidget,
                        options: CarouselOptions(
                          height: 390,
                          viewportFraction: 1.0,
                        ),
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, top: 20, bottom: 10),
                    child: Container(
                      height: 25,
                      width: double.infinity,
                      child: Text(
                        "Collect deed pearls",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      height: 350.0,
                      color: Colors.transparent,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: deedCategories,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('error');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text('loading');
                          }
                          final data = snapshot.requireData;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.size,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 350,
                                width: 350.0,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 0,
                                  // child: Text('${data.docs[index]['title']}'),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: ProgressiveImage.memoryNetwork(
                                          placeholder: kTransparentImage,
                                          thumbnail: data.docs[index]
                                              ['imageUrlThumb'],
                                          image: data.docs[index]['imageUrl'],
                                          height: 300,
                                          width: 350,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 0, top: 10, bottom: 10),
                                        child: Container(
                                            height: 20,
                                            alignment: Alignment.centerLeft,
                                            child:
                                                // Text(data.docs[index]['title']),
                                                Text(data.docs[index]['title'],
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                              // Text(
                              //     "My name is ${data.docs[index]['name']} and I am ${data.docs[index]['age']}");
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          // decoration: BoxDecoration(
                          //   border: Border.all(
                          //     color: Colors.red[500],
                          //   ),
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          color: Colors.amber,
                          height: 550.0,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 250,
                                width: double.infinity,
                                color: Colors.blueGrey.shade900,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 30, bottom: 10),
                                      child: Center(
                                        child: Text(
                                          "Try helping",
                                          style: TextStyle(
                                              fontSize: 26,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 40, right: 40),
                                        child: Text(
                                          "Earn extra deeds by helping somone in need by creating help opportunity.",
                                          maxLines: 3,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(20),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            color: Colors.white,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 20),
                                              child: Text(
                                                "Learn more",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ProgressiveImage.assetNetwork(
                                placeholder: "assets/images/help_someone.jpg",
                                thumbnail: "assets/images/help_someone.jpg",
                                image: "assets/images/help_someone.jpg",
                                height: 300,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Container _topQuoteHeading() {
    return Container(
      height: 25,
      width: double.infinity,
      child: Text(
        "Dhikr of the day",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  ProgressiveImage _buildFlexibleSpaceWidget() {
    return ProgressiveImage.assetNetwork(
      placeholder: "assets/images/landing_thumb.jpg",
      thumbnail: "assets/images/landing_thumb.jpg",
      image: "assets/images/landing.jpg",
      height: 400,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget _buildTopQuoteWidget(BuildContext context, int index, int realIndex) {
    return ChangeNotifierProvider.value(
      value: quotesData.items[index],
      child: TopQuoteWidget(),
    );
  }
}
