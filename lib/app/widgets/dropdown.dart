import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

Widget DropDownWidget(
    {required String title,
    required List<Object>? list,
    List<Object>? filterlist,
    Key? key,
    bool? showSearchBOX,
    required ValueChanged<Object?> valChanged,
    String? selectedItem,
    Mode? mode,
    bool? enable}) {
  return CustomDropdown<Object>(
    // excludeSelected: true,
    // disabledDecoration: ,
    //  initialItem:selectedItem: ,
    hintText: 'Select $title',
    items: list,
    onChanged: valChanged,
  );
}
