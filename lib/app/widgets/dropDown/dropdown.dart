import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../data/model/getSyncData.dart';


Widget singleDropDown({
  required String title,
  required List<Dealers> list,
  required ValueChanged<Dealers?> valChanged,
  required List<int> disabledIds,
  int? selectedId, // Use ID instead of selectedItem
  Key? key,
  bool? showSearchBOX = true,
  Mode? mode,
  bool? enable,
}) {
  // Find the selected dealer based on the selectedId
  Dealers? selectedDealer = list.firstWhere(
        (element) => element.id == selectedId,
    orElse: () => Dealers(), // Provide a default Dealers object if not found
  );

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: DropdownSearch<Dealers>(
          enabled: enable ?? true,
          key: key,
          validator: (v) => v == null ? "required field" : null,
          selectedItem: selectedDealer, // Ensure selectedItem is not null
          dropdownDecoratorProps: const DropDownDecoratorProps(),
          items: list,
          itemAsString: (Dealers u) => u.dealershipName ?? '',
          onChanged: valChanged,
          dropdownBuilder: (context, selectedItem) {
            return Text(
              selectedId==0 ||selectedId==-1?"Select dealer":  selectedItem?.dealershipName ?? '',
              style: TextStyle(
                color: selectedItem != null && disabledIds.contains(selectedItem.id)
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black,
              ),
            );
          },
          popupProps: PopupProps.menu(
            showSearchBox: showSearchBOX ?? false,
            itemBuilder: (context, item, isSelected) {
              return ListTile(
                title: Text(
                  item.dealershipName ?? '',
                  style: TextStyle(
                    color: disabledIds.contains(item.id) ? Colors.black.withOpacity(0.3) : Colors.black,
                  ),
                ),
                enabled: !disabledIds.contains(item.id),
              );
            },
            searchFieldProps: const TextFieldProps(
              decoration: InputDecoration(
                hintText: 'Search...',
              ),
            ),
          ),
        ),
      ),
    ),
  );
}













// Widget singleDropDown({
//   required String title,
//   required List<Object> list,
//   Key? key,
//   bool? showSearchBOX,
//   required ValueChanged<Object?> valChanged,
//   String? selectedItem,
//   Mode? mode,
//   bool? enable,
//   List<int>? disabledIndices, // Add a parameter to specify disabled indices
// }) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 4.0),
//     child: Container(
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Center(
//         child: DropdownSearch<Object>(
//           enabled: enable ?? true,
//           key: key,
//           validator: (v) => v == null ? "required field" : null,
//           selectedItem: selectedItem,
//           dropdownDecoratorProps: const DropDownDecoratorProps(),
//           items: list,
//           onChanged: (value) {
//             // Check if the selected index is disabled
//             int selectedIndex = list.indexOf(value!);
//             if (disabledIndices != null && disabledIndices.contains(selectedIndex)) {
//               // If the selected index is disabled, don't allow the change
//               return;
//             }
//             valChanged(value);
//           },
//           itemAsString: (Object? item) {
//             int index = list.indexOf(item!);
//             if (disabledIndices != null && disabledIndices.contains(index)) {
//               return "$item (Disabled)";
//             }
//             return item.toString();
//           },
//           onBeforeChange: (a, b) {
//             int newIndex = list.indexOf(b!);
//             if (disabledIndices != null && disabledIndices.contains(newIndex)) {
//               return Future.value(false);
//             } else {
//               return Future.value(true);
//             }
//           },
//         ),
//       ),
//     ),
//   );
// }

// Widget singleDropDown(
//     {required String title,
//       required List<Object> list,
//       Key? key,
//       bool? showSearchBOX,
//       required ValueChanged<Object?> valChanged,
//       String? selectedItem,
//       Mode? mode,
//       bool? enable}) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 4.0),
//     child: Container(
//       padding: EdgeInsets.all(8),
//       decoration:BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Center(
//         child: DropdownSearch(
//
//           enabled: enable ?? true,
//           key: key,
//           validator: (v) => v == null ? "required field" : null,
//           selectedItem: selectedItem,
//           dropdownDecoratorProps: const DropDownDecoratorProps(
//
//           ),
//           items: list,
//           onChanged: valChanged,
//           onBeforeChange: (a, b) {
//             if (a == b) {
//               return Future.value(false);
//             } else {
//               return Future.value(true);
//             }
//           },
//         ),
//       ),
//     ),
//   );
// }
