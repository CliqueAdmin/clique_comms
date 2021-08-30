import 'package:clique_comms/providers/products.dart';
import 'package:clique_comms/providers/top_quotes.dart';
import 'package:clique_comms/screens/onboard_help_request_screen.dart';
import 'package:clique_comms/screens/quotes_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth.dart';
import 'screens/CommunityLandingScreen.dart';
import 'screens/edit_product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products('', '', []),
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider.value(
          value: TopQuotes(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: CommunityLandingScreen(),
        routes: {
          CommunityLandingScreen.routeName: (ctx) => CommunityLandingScreen(),
          QuotesScreen.routeName: (ctx) => QuotesScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
          OnboardHelpRequestScreen.routeName: (ctx) =>
              OnboardHelpRequestScreen(),
        },
      ),
    );
  }
}
