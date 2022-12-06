import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

Widget textEntryField(
    String title,
    TextEditingController controller,
    ) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: title,
    ),
  );
}

Widget numericEntryField(
    String title,
    TextEditingController controller,
    ) {
  return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ]
  );
}
