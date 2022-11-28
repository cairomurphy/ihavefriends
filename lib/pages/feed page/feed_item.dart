import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:ihavefriends/provider.dart';

class FeedItem extends StatelessWidget {
  const FeedItem({Key? key}) : super(key: key);
  //TODO: pass in data and display data on cards

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<String>(
            future: Provider.of<AppProvider>(context, listen: false).fetchBuddy('id'),
            builder: (builder, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data;
                if (data != null) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      //TODO: open profile page
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'buddyName',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const Text(
                          'phoneNumber',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.watch_later_outlined,
                              color: Colors.grey,
                              size: 20,
                            ),
                            SizedBox(width: 5,),
                            Text(
                              'time',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.business,
                              color: Colors.grey,
                              size: 20,
                            ),
                            SizedBox(width: 5,),
                            Text(
                              'buildingAbbr',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey
                              ),
                            ),
                            Icon(
                              Icons.arrow_right,
                              color: Colors.grey,
                              size: 20,
                            ),
                            Text(
                              'buildingAbbr',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Buddy not found',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  );
                }
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: SpinKitFadingCircle(
                    color: Colors.blue,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
