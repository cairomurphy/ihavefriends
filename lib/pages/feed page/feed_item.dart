import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ihavefriends/models/models.dart';
import 'package:provider/provider.dart';
import 'package:ihavefriends/provider.dart';
import 'package:intl/intl.dart';

class FeedItem extends StatelessWidget {
  const FeedItem({required this.trip, Key? key}) : super(key: key);
  final Trip trip;

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
          child: FutureBuilder<AppUser>(
            future: Provider.of<AppProvider>(context, listen: false).fetchBuddy(trip.userID),
            builder: (builder, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data;
                if (data != null) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      //TODO: open profile page maybe
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${data.firstName} ${data.lastName}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          data.phoneNumber,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.watch_later_outlined,
                              color: Colors.grey,
                              size: 20,
                            ),
                            const SizedBox(width: 5,),
                            Text(
                              DateFormat('hh:mm a').format(trip.departureTime),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.grey
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.business,
                              color: Colors.grey,
                              size: 20,
                            ),
                            const SizedBox(width: 5,),
                            FutureBuilder<Location>(
                              future: Provider.of<AppProvider>(context, listen: false).fetchLocation(trip.startingLocationID),
                              builder: (builder, snapshot) {
                                if (snapshot.hasData) {
                                  final data = snapshot.data;
                                  if (data != null) {
                                    return Text(
                                      data.locationName,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey
                                      ),
                                    );
                                  } else {
                                    return const Center(
                                      child: Text(
                                        'unknown',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: SpinKitFadingCircle(
                                      size: 20,
                                      color: Colors.blue,
                                    ),
                                  );
                                }
                              },
                            ),
                            const Icon(
                              Icons.arrow_right,
                              color: Colors.grey,
                              size: 20,
                            ),
                            FutureBuilder<Location>(
                              future: Provider.of<AppProvider>(context, listen: false).fetchLocation(trip.endingLocationID),
                              builder: (builder, snapshot) {
                                if (snapshot.hasData) {
                                  final data = snapshot.data;
                                  if (data != null) {
                                    return Text(
                                      data.locationName,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey
                                      ),
                                    );
                                  } else {
                                    return const Center(
                                      child: Text(
                                        'unknown',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: SpinKitFadingCircle(
                                      size: 20,
                                      color: Colors.blue,
                                    ),
                                  );
                                }
                              },
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
