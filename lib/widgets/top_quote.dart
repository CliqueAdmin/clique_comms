import 'package:clique_comms/screens/quotes_screen.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:transparent_image/transparent_image.dart';
import '../providers/top_quote.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopQuoteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final topQuote = Provider.of<TopQuote>(context, listen: false);
    return Padding(
      padding: EdgeInsets.all(50),
      child: Container(
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: 10,
                color: Colors.amberAccent,
              ),
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
                        ProgressiveImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          // size: 1.87KB
                          thumbnail: topQuote.imageUrlThumb,
                          // size: 1.29MB
                          image: topQuote.imageUrlSmall,
                          height: 300,
                          width: 500,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 16,
                          right: 16,
                          left: 16,
                          child: Text(topQuote.quote == null
                              ? "No quote found"
                              : topQuote.quote),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            FlatButton(
                              child: Text('Buy Cat'),
                              onPressed: () {},
                            ),
                            FlatButton(
                              child: Text('Buy Cat Food'),
                              onPressed: () {},
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 10,
                color: Colors.amberAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
