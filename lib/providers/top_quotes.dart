import 'dart:convert';
import 'dart:io';
import 'top_quote.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TopQuotes with ChangeNotifier {
  List<TopQuote> _items = [];
  //   TopQuote(
  //     catetory: 'Bravery',
  //     quote: 'Red Shirt',
  //     quoteId: '1',
  //     reference: '',
  //     imageUrl: '1.jpg',
  //   ),
  //   TopQuote(
  //       catetory: 'Focus',
  //       quote: 'A nice pair of trousers.',
  //       quoteId: '2',
  //       reference: '',
  //       imageUrl: '2.jpg'),
  //   TopQuote(
  //       catetory: 'Bravery',
  //       quote: 'Warm and cozy - exactly what you need for the winter.',
  //       quoteId: '3',
  //       reference: '',
  //       imageUrl: '3.jpg'),
  //   TopQuote(
  //       catetory: 'Family',
  //       quote: 'A Pan Prepare any meal you want.',
  //       quoteId: '4',
  //       reference: '',
  //       imageUrl: '4.jpg'),
  //   TopQuote(
  //       catetory: 'Bravery',
  //       quote:
  //           'Stream builder for every tab,Warm and cozy - exactly what you need for the winter.',
  //       quoteId: '5',
  //       reference: '',
  //       imageUrl: '5.jpg'),
  //   TopQuote(
  //       catetory: 'Flutter',
  //       quote: 'Card and Positioned are interesting',
  //       quoteId: '6',
  //       reference: '',
  //       imageUrl: '6.jpg'),
  //   TopQuote(
  //       catetory: 'Action',
  //       quote: 'Animation in flutter is real action.',
  //       quoteId: '7',
  //       reference: '',
  //       imageUrl: '7.jpg'),
  // ];

  Future<void> fetchAndSetProducts() async {
    var url = Uri.parse(
        'https://api.unsplash.com/collections/stkwSZkbDBU/photos?client_id=VluRhI4bO2fdFX3ue7APFxVtzCi388L8Uszg_p1-giI');
    try {
      final response = await http.get(url);
      debugPrint(response.body);
      final extractedData = json.decode(response.body);

      if (extractedData == null) {
        return;
      }

      List<TopQuote> loadedProducts =
          List<TopQuote>.generate(extractedData.length, (index) {
        return TopQuote(
          quoteId: extractedData[index]['id'],
          quote: extractedData[index]['description'],
          hexColor: extractedData[index]['color'],
          blurHash: extractedData[index]['blur_hash'],
          catetory: extractedData[index]['id'],
          reference: extractedData[index]['id'],
          isFavorite: false,
          imageUrl: extractedData[index]['urls']['regular'],
          imageUrlFull: extractedData[index]['urls']['full'],
          imageUrlSmall: extractedData[index]['urls']['small'],
          imageUrlThumb: extractedData[index]['urls']['thumb'],
        );
      });

      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      debugPrint(error);
      throw (error);
    }
  }

  int findIndexBy(String id) {
    return _items.indexWhere((prod) => prod.quoteId == id);
  }

  List<TopQuote> get items {
    return [..._items];
  }

  Stream<TopQuote> quoteStream() async* {
    for (int i = 1; i <= 7; i++) {
      await Future.delayed(Duration(microseconds: 1));

      yield _items[i];
    }
  }
}
