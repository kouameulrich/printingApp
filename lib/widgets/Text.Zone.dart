// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:printer_app/widgets/default.colors.dart';

Widget TextZone(BuildContext context, TextEditingController controller) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        maxLines: 5,
        autocorrect: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Defaults.white,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1, color: Defaults.white), //<-- SEE HERE
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Defaults.white),
            borderRadius: BorderRadius.circular(15),
          ),
          // hintText: 'Text zone to explain'
        ),
      ),
    );
