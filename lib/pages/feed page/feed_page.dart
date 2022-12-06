import 'package:flutter/material.dart';
import 'package:ihavefriends/models/models.dart';
import 'package:ihavefriends/pages/feed%20page/feed_item.dart';
import 'package:ihavefriends/pages/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:ihavefriends/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ihavefriends/pages/login_register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iHaveFriends'),
        
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ActionChip(
                label: Text("Logout"),
                onPressed: () {
                  logout(context);
                }),
            ActionChip(
                label: Text("Profile"),
                onPressed: () {
                  profilePage(context);
                }),
            FutureBuilder<List<Trip>>(
              future: Provider.of<AppProvider>(context, listen: false).findWalkingBuddies(),
              builder: (builder, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  if (data != null && data.isNotEmpty) {
                    List<Widget> feedItems = [];
                    for (var item in data) {
                      String dayOfWeek = '';
                      if (item.departureTime.weekday == 0) {
                        dayOfWeek = 'Sunday';
                      } else if (item.departureTime.weekday == 1) {
                        dayOfWeek = 'Monday';
                      } else if (item.departureTime.weekday == 2) {
                        dayOfWeek = 'Tuesday';
                      } else if (item.departureTime.weekday == 3) {
                        dayOfWeek = 'Wednesday';
                      } else if (item.departureTime.weekday == 4) {
                        dayOfWeek = 'Thursday';
                      } else if (item.departureTime.weekday == 5) {
                        dayOfWeek = 'Friday';
                      } else {
                        dayOfWeek = 'Saturday';
                      }

                      if (data.indexOf(item) == 0) {
                        feedItems.add(
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10, left: 10),
                            child: Text(dayOfWeek),
                          ),
                        );
                        feedItems.add(FeedItem(trip: item,));
                      } else {
                        if (item.departureTime.weekday != data[data.indexOf(item)-1].departureTime.weekday) {
                          feedItems.add(
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10, left: 10),
                              child: Text(dayOfWeek),
                            ),
                          );
                        }
                        feedItems.add(FeedItem(trip: item,));
                      }
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15,),
                        const Text(
                          'Upcoming Walks',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 25
                          ),
                        ),
                        const Divider(
                          height: 30,
                          thickness: 1,
                          indent: 30,
                          endIndent: 30,
                          color: Colors.grey,
                        ),
                        ListView(
                          shrinkWrap: true,
                          children: feedItems,
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'No matches found',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    );
                  }
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 2,
                      ),
                      const Text(
                        'Finding walking buddies...',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const SpinKitFadingCircle(
                        color: Colors.blue,
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Future<void> profilePage(BuildContext context) async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ProfilePage()));
  }
}
