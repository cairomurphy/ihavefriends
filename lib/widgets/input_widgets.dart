import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textEntryField(
    String title,
    TextEditingController controller,
    String initialValue
    ) {
  return TextField(
    controller: controller..text = initialValue,
    decoration: InputDecoration(
      labelText: title,
    ),
  );
}

Widget numericEntryField(
    String title,
    TextEditingController controller,
    String initialValue
    ) {
  return TextField(
      controller: controller..text = initialValue,
      decoration: InputDecoration(labelText: title),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ]
  );
}
