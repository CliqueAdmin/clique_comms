import 'package:clique_comms/providers/products.dart';
import 'package:clique_comms/providers/top_quotes.dart';
import 'package:clique_comms/screens/auth_screen.dart';
import 'package:clique_comms/screens/onboard_help_request_screen.dart';
import 'package:clique_comms/screens/quotes_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'providers/auth.dart';
import 'screens/community_landing_screen.dart';
import 'screens/edit_product_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider.value(
        //   value: Auth(),
        // ),
        // ChangeNotifierProxyProvider<Auth, Products>(
        //   create: (_) => Products('', '', []),
        //   update: (ctx, auth, previousProducts) => Products(
        //     auth.token,
        //     auth.userId,
        //     previousProducts == null ? [] : previousProducts.items,
        //   ),
        // ),
        ChangeNotifierProvider.value(
          value: TopQuotes(),
        ),
      ],
      child: MaterialApp(
        title: 'DeedPearls',
        theme: ThemeData(
          // primarySwatch: colorCustom,
          accentColor: Colors.teal,
          fontFamily: 'Roboto',
          primaryColor: Colors.white,
        ),
        home: CommunityLandingScreen(analytics, observer),
        routes: {
          CommunityLandingScreen.routeName: (ctx) =>
              CommunityLandingScreen(analytics, observer),
          QuotesScreen.routeName: (ctx) => QuotesScreen(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
          OnboardHelpRequestScreen.routeName: (ctx) =>
              OnboardHelpRequestScreen(),
        },
      ),
    );
  }
}
