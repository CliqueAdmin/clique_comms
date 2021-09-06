import 'package:clique_comms/screens/quotes_screen.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:transparent_image/transparent_image.dart';
import '../providers/top_quote.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopQuoteWidget extends StatefulWidget {
  @override
  _TopQuoteWidgetState createState() => _TopQuoteWidgetState();
}

class _TopQuoteWidgetState extends State<TopQuoteWidget> {
  @override
  Widget build(BuildContext context) {
    final topQuote = Provider.of<TopQuote>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            // Expanded(
            //   child: Container(
            //     height: 10,
            //     color: Colors.transparent,
            //   ),
            // ),
            Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: ProgressiveImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      thumbnail: topQuote.imageUrlThumb,
                      image: topQuote.imageUrlSmall,
                      height: 245,
                      width: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    bottom: 16,
                    right: 16,
                    left: 16,
                    child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: Center(child: Text('In the middle'))),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    left: 16,
                    child: Container(
                      color: Colors.amber,
                      child: ButtonBar(
                        children: [
                          Container(
                            color: Colors.black26,
                            child: IconButton(
                              color: Theme.of(context).accentColor,
                              iconSize: 32,
                              icon: const Icon(Icons.fullscreen),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  QuotesScreen.routeName,
                                  arguments: topQuote.quoteId,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  QuotesScreen.routeName,
                  arguments: topQuote.quoteId,
                );
              },
              child: Card(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: ProgressiveImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            thumbnail: topQuote.imageUrlThumb,
                            image: topQuote.imageUrlSmall,
                            height: 245,
                            width: 500,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          right: 16,
                          left: -16,
                          child: Container(
                            color: Colors.transparent,
                            child: ButtonBar(
                              children: [
                                Container(
                                  color: Colors.black26,
                                  child: IconButton(
                                    color: Theme.of(context).accentColor,
                                    iconSize: 32,
                                    icon: const Icon(Icons.fullscreen),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Expanded(
            //   child: Container(
            //     height: 10,
            //     color: Colors.transparent,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
