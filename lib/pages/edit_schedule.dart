import 'package:flutter/material.dart';
import 'package:ihavefriends/models/models.dart';
import 'package:ihavefriends/models/utility_models.dart';
import 'package:ihavefriends/pages/feed%20page/feed_page.dart';
import 'package:provider/provider.dart';
import 'package:ihavefriends/provider.dart';

class EditSchedule extends StatefulWidget {
  const EditSchedule({super.key});

  @override
  State<EditSchedule> createState() => _EditScheduleState();
}

class _EditScheduleState extends State<EditSchedule> {
  List<String> dayList = <String>['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  List<StudentClass> classes = [
    StudentClass(
        'Course Name', Location(locationID: '11', zoneID: '7', locationName: 'HBLL'), DateTime.utc(2023, 1, 2, 1, 1))
  ];
  
  String getWeekDay(DateTime time) {
    if (time.weekday == 1) {
      return 'Monday';
    } else if (time.weekday == 2) {
      return 'Tuesday';
    } else if (time.weekday == 3) {
      return 'Wednesday';
    } else if (time.weekday == 4) {
      return 'Thursday';
    } else {
      return 'Friday';
    }
  }

  List<Widget> classItems() {
    List<Widget> items = [];

    for (var myClass in classes) {
      items.add(Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Class ${classes.indexOf(myClass) + 1}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Course Name'),
              onChanged: (String? newValue) {
                setState(() {
                  myClass.name = newValue!;
                });
              },
            ),
            FutureBuilder<List<Location>?>(
              future: Provider.of<AppProvider>(context, listen: false).fetchLocations(),
              builder: (builder, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;
                  if (data != null) {
                    return Row(
                      children: [
                        DropdownButton<Location>(
                          value: null,
                          elevation: 16,
                          hint: const Text('Select Building'),
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (Location? value) {
                            setState(() {
                              myClass.location = value!;
                            });
                          },
                          items: data.map<DropdownMenuItem<Location>>((Location value) {
                            return DropdownMenuItem<Location>(
                              value: value,
                              child: Text(value.locationName),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Building: ${myClass.location.locationName}',
                        )
                      ],
                    );
                  }
                }
                return const SizedBox();
              },
            ),
            Row(
              children: [
                DropdownButton<String>(
                  value: getWeekDay(myClass.endTime),
                  hint: const Text('Select Day'),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      if (value != null) {
                        int hour = myClass.endTime.hour;
                        int minute = myClass.endTime.minute;
                        if (value == 'Monday') {
                          myClass.endTime = DateTime.utc(2023, 1, 2, hour, minute);
                        } else if (value == 'Tuesday') {
                          myClass.endTime = DateTime.utc(2023, 1, 3, hour, minute);
                        } else if (value == 'Wednesday') {
                          myClass.endTime = DateTime.utc(2023, 1, 4, hour, minute);
                        } else if (value == 'Thursday') {
                          myClass.endTime = DateTime.utc(2023, 1, 5, hour, minute);
                        } else {
                          myClass.endTime = DateTime.utc(2023, 1, 6, hour, minute);
                        }
                      }
                    });
                  },
                  items: dayList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (pickedTime != null) {
                      int hour = pickedTime.hour;
                      int min = pickedTime.minute;
                      int day = myClass.endTime.day;
                      setState(() {
                        myClass.endTime = DateTime.utc(2023, 1, day, hour, min);
                      });
                    }
                  },
                  child: const Text('Select End Time'),
                )
              ],
            ),
          ],
        ),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Schedule')),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Please enter all of your classes in the order they happen during the week.',
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Add or Remove Classes',
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (classes.length > 1)
                    GestureDetector(
                      onTap: () {
                        if (classes.length > 1) {
                          setState(() {
                            classes.removeLast();
                          });
                        }
                      },
                      child: Material(
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.remove_rounded,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    width: 17,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        classes.add(StudentClass(
                            'Course Name',
                            Location(locationID: '11', zoneID: '7', locationName: 'HBLL'),
                            DateTime.utc(2023, 1, 2, 1, 1)));
                      });
                    },
                    child: Material(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      child: const Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.add_rounded,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                ],
              ),
              Column(
                children: classItems(),
              ),
              const SizedBox(height: 30,),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await Provider.of<AppProvider>(context, listen: false).createSchedule(classes);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const FeedPage()));
                  },
                  child: const Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
