import 'package:flutter/material.dart';

class TopQuote with ChangeNotifier {
  final String catetory;
  final String quote;
  final String hexColor;
  final String blurHash;
  final String quoteId;
  final String reference;
  final String imageUrl;
  final String imageUrlFull;
  final String imageUrlSmall;
  final String imageUrlThumb;
  bool isFavorite;

  TopQuote({
    @required this.catetory,
    @required this.quote,
    @required this.hexColor,
    @required this.blurHash,
    @required this.quoteId,
    @required this.reference,
    @required this.imageUrl,
    @required this.imageUrlFull,
    @required this.imageUrlSmall,
    @required this.imageUrlThumb,
    this.isFavorite = false,
  });
}
