import 'package:flutter/material.dart';
import 'package:ihavefriends/models/models.dart';
import 'package:provider/provider.dart';
import 'package:ihavefriends/provider.dart';



class EditSchedule extends StatefulWidget{
  const EditSchedule({super.key});

  @override
  State<EditSchedule> createState() => _EditScheduleState();
}

class _EditScheduleState extends State<EditSchedule> {
  Location? dropDownValue;
  String dropdownVal = 'Monday';
  String courseName = '';
  int numClasses = 3;
  String weekDay = '';
  TimeOfDay time = TimeOfDay.now();
  List<String> dayList = <String>['Monday','Tuesday','Wednesday','Thursday','Friday'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Schedule')),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Add or Remove Classes',
              ),
              const SizedBox(width: 10,),
              if (numClasses > 1)
                GestureDetector(
                  onTap: () {
                    if (numClasses > 1) {
                      setState(() {
                        numClasses--;
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
                    numClasses++;
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
          const Text(
            'Class 1',
            style: TextStyle(
              fontWeight: FontWeight.w600
            ),
          ),
          TextField(
            decoration: const InputDecoration(hintText: 'Course Name'),
            onChanged: (String? newValue) {
              setState(() {
                courseName = newValue!;
              });
            },
          ),
          FutureBuilder <List<Location>?>(
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
                        hint: const Text(
                          'Select Building'
                        ),
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (Location? value) {
                          setState(() {
                            dropDownValue = value!;
                          });
                        },
                        items: data.map<DropdownMenuItem<Location>>((Location value) {
                          return DropdownMenuItem<Location>(
                            value: value,
                            child: Text(value.locationName),
                          );
                        }).toList(),
                      ),
                      const SizedBox(width: 10,),
                      Text(
                        'Building: ${dropDownValue?.locationName ?? 'Building'}',
                      )
                    ],
                  );
                }
              }
              return const SizedBox();
            },
          ),

          DropdownButton<String>(
            value: dropdownVal,
            hint: const Text(
                'Select Day'
            ),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownVal = value!;
              });
            },
            items: dayList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),

            ElevatedButton(
              onPressed: () async {
                final pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (pickedTime != null) {
                  setState(() {
                    time = pickedTime;
                  });
                }
              },

              child: const Text('Select End Time'),
            )
        ],),
      ),
    );
  }
}
