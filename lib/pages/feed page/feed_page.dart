import 'package:flutter/material.dart';
import 'package:ihavefriends/pages/feed%20page/feed_item.dart';
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
        child: FutureBuilder<List<String>>(
          future: Provider.of<AppProvider>(context, listen: false).findWalkingBuddies(),
          builder: (builder, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              if (data != null && data.isNotEmpty) {
                List<Widget> feedItems = [];
                for (var item in data) {
                  if (data.indexOf(item) == 0) {
                    //TODO: get name of day string from timestamp
                    feedItems.add(
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10, left: 10),
                        child: Text('dayOfTheWeek'),
                      ),
                    );
                    feedItems.add(const FeedItem());
                  } else {
                    //TODO: check for different week day, add new dayOfWeek
                    feedItems.add(const FeedItem());
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
      ),
    );
  }
}
