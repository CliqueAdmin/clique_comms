import 'package:clique_comms/extentions/color_extention.dart';
import 'package:clique_comms/providers/top_quotes.dart';
import 'package:clique_comms/screens/CommunityLandingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:provider/provider.dart';

import 'onboard_help_request_screen.dart';

/// This is the stateless widget that the main application instantiates.
class QuotesScreen extends StatefulWidget {
  static const routeName = '/quotes';

  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  int _selectedIndex = 1;

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
    final topQuotesData = Provider.of<TopQuotes>(context, listen: false);
    final topQuotes = topQuotesData.items;
    final quoteId = ModalRoute.of(context).settings.arguments as String;
    final quoteIndex = topQuotesData.findIndexBy(quoteId);
    final PageController controller = PageController(initialPage: quoteIndex);
    final Color bgColor = HexColor.fromHex(topQuotes[quoteIndex].hexColor);
    return Scaffold(
      body: PageView.builder(
        controller: controller,
        scrollDirection: Axis.vertical,
        itemCount: topQuotes.length,
        itemBuilder: (context, position) {
          return Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: bgColor,
              child: BlurHash(
                imageFit: BoxFit.cover,
                duration: const Duration(milliseconds: 1500),
                curve: Curves.easeInOutExpo,
                hash: topQuotes[position].blurHash,
                image: topQuotes[position].imageUrl,
                onStarted: () {
                  print('onStarted');
                },
                onDecoded: () {
                  print('onDecoded');
                },
                onReady: () {
                  print('onReady');
                },
              ),
            ),
          );
        },
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
  }
}
