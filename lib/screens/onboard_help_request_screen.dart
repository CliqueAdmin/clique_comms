import 'package:clique_comms/screens/community_landing_screen.dart';
import 'package:clique_comms/widgets/help_imagepicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OnboardHelpRequestScreen extends StatefulWidget {
  static const routeName = '/help-request';

  @override
  _OnboardHelpRequestScreenState createState() =>
      _OnboardHelpRequestScreenState();
}

class _OnboardHelpRequestScreenState extends State<OnboardHelpRequestScreen>
    with SingleTickerProviderStateMixin {
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('users').snapshots();
  var name = '';
  var age = 0;

  TabController tabController;
  @override
  void initState() {
    super.initState();
    this.tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    CollectionReference usersA = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("this.widget.title"),
              background: Placeholder(),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: StickyTabBarDelegate(
              child: TabBar(
                labelColor: Colors.black,
                controller: this.tabController,
                tabs: <Widget>[
                  Tab(text: 'Home'),
                  Tab(text: 'Profile'),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: this.tabController,
              children: <Widget>[
                Center(
                  child: HelpImagePicker(),
                ),
                Center(
                    child: Column(
                  children: [
                    Container(
                      height: 250,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: users,
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
                            itemCount: data.size,
                            itemBuilder: (context, index) {
                              return Text(
                                  "My name is ${data.docs[index]['name']} and I am ${data.docs[index]['age']}");
                            },
                          );
                        },
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  icon: Icon(Icons.person),
                                  hintText: 'WHhat is your namne!',
                                  labelText: 'Name  '),
                              onChanged: (value) {
                                name = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'pleae add age';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  icon: Icon(Icons.date_range),
                                  hintText: 'WHhat is your age!',
                                  labelText: 'Age  '),
                              onChanged: (value) {
                                age = int.tryParse(value);
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'pleae add age';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Data to cloud firstore.'),
                                      ),
                                    );
                                    usersA
                                        .add({'name': name, 'age': age})
                                        .then((value) => print(value))
                                        .catchError((error) => print(error));
                                  }
                                },
                                child: Text('Submit'),
                              ),
                            ),
                            Center(
                              child: ElevatedButton(
                                onPressed: _signOut,
                                child: Text('Sign Out'),
                              ),
                            )
                          ],
                        )),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamed(CommunityLandingScreen.routeName);
  }

  Widget _buildListWidget(Color color, String text) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 48),
        ),
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class OnboardHelpRequestHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.greenAccent,
      child: Center(
        child: Text(
          "headerTitle",
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 500;

  @override
  double get minExtent => 200;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
