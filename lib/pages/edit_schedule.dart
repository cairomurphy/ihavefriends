import 'package:flutter/material.dart';
import 'package:ihavefriends/models/models.dart';
import 'package:provider/provider.dart';
import 'package:ihavefriends/provider.dart';

class EditSchedule extends StatefulWidget{
  @override
  State<EditSchedule> createState() => _EditScheduleState();
}

class _EditScheduleState extends State<EditSchedule> {
  Location dropDownValue = Location(locationID: '10',locationName: 'HFAC', zoneID: '7');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Schedule')),
      body: Column(children: <Widget>[
        const TextField(
          decoration: InputDecoration(hintText: 'Course Name'),
        ),
        FutureBuilder <List<Location>?>(
          future: Provider.of<AppProvider>(context, listen: false).fetchLocations(),
          builder: (builder, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              if (data != null) {
                return Text(data.length.toString());
                // return DropdownButton<Location?>(
                //   value: dropDownValue,
                //   icon: const Icon(Icons.arrow_downward),
                //   elevation: 16,
                //   style: const TextStyle(color: Colors.deepPurple),
                //   underline: Container(
                //     height: 2,
                //     color: Colors.deepPurpleAccent,
                //   ),
                //   onChanged: (Location? value) {
                //     // This is called when the user selects an item.
                //     setState(() {
                //       dropDownValue = value!;
                //     });
                //   },
                //   items: data.map<DropdownMenuItem<Location?>>((Location? value) {
                //     return DropdownMenuItem<Location?>(
                //       value: value,
                //       child: Text(value?.locationName ?? ''),
                //     );
                //   }).toList(),
                // );
              }
            }
            return const SizedBox();
          },
        ),
        const TextField(
          decoration: InputDecoration(hintText: 'End Time'),
        ),
      ],),
    );
  }
}