import 'package:flutter/material.dart';

class QuoteBg with ChangeNotifier {
  final String hexColor;
  final String blurHash;
  final String reference;
  final String imageUrl;
  final String imageUrlFull;
  final String imageUrlSmall;
  final String imageUrlThumb;

  QuoteBg({
    @required this.hexColor,
    @required this.blurHash,
    @required this.reference,
    @required this.imageUrl,
    @required this.imageUrlFull,
    @required this.imageUrlSmall,
    @required this.imageUrlThumb,
  });
}
