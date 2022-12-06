import 'package:flutter/material.dart';
import 'package:ihavefriends/models/models.dart';
import 'package:ihavefriends/pages/feed%20page/feed_item.dart';
import 'package:ihavefriends/pages/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:ihavefriends/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
          children: [
            FutureBuilder<List<Trip>>(
              future: Provider.of<AppProvider>(context, listen: false).findWalkingBuddies(),
              builder: (builder, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  if (data != null && data.isNotEmpty) {
                    data.sort((a, b) => a.departureTime.compareTo(b.departureTime));
                    List<Trip> thisWeek = [];
                    List<Trip> nextWeek = [];
                    for (var item in data) {
                      if (item.departureTime.weekday > DateTime.now().weekday) {
                        thisWeek.add(item);
                      } else {
                        nextWeek.add(item);
                      }
                    }
                    thisWeek.addAll(nextWeek);

                    List<Widget> feedItems = [];
                    for (var item in thisWeek) {
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

                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column( 
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
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: feedItems,
                            ),
                          ],
                        ),
                      ),
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
            ActionChip(
                label: const Text("Profile"),
                onPressed: () {
                  profilePage(context);
                }),
          ],
        ),
      ),
    );
  }

  Future<void> profilePage(BuildContext context) async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ProfilePage()));
  }
}
