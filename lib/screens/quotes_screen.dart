import 'package:clique_comms/extentions/color_extention.dart';
import 'package:clique_comms/providers/top_quote.dart';
import 'package:clique_comms/providers/top_quotes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

/// This is the stateless widget that the main application instantiates.
class QuotesScreen extends StatelessWidget {
  static const routeName = '/quotes';

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
                duration: const Duration(milliseconds: 3000),
                curve: Curves.easeInOutBack,
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
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('Messages'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ),
    );
  }
}
