// import 'package:flutter/cupertino.dart';
//
// Future<void> showyearPicker(BuildContext context) async {
//   // Create temporary variables for the dialog state
//   int tempYear = _startYear ?? DateTime.now().year;
//   int tempMonth = _startMonthForyear;
//
//   await showDialog(
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setDialogState) {
//           return Dialog(
//             backgroundColor: Colors.white,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Year Dropdown
//                       Row(
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.arrow_left),
//                             onPressed: () {
//                               setState(() {
//                                 _selectedYear--;
//                               });
//                             },
//                           ),
//                           DropdownButton<int>(
//                             value: tempYear,
//                             items: List.generate(10, (index) {
//                               final year = DateTime.now().year - 7 + index;
//                               return DropdownMenuItem(value: year, child: Text('$year'));
//                             }),
//                             onChanged: (value) {
//                               setDialogState(() {
//                                 tempYear = value!;
//                               });
//                             },
//                           ),
//                           const SizedBox(width: 10),
//                           Text("年", style: TextStyle(color: Colors.grey[700])),
//                         ],
//                       ),
//                       // Month Dropdown
//                       Row(
//                         children: [
//
//                           DropdownButton<int>(
//                             value: tempMonth,
//                             items: List.generate(1, (index) {
//                               final month = index + 1;
//                               return DropdownMenuItem(
//                                 value: month,
//                                 child: Text('$month'),
//                               );
//                             }),
//                             onChanged: (value) {
//                               setDialogState(() {
//                                 tempMonth = value!;
//                               });
//                             },
//                           ),
//                           const SizedBox(width: 10),
//                           Text("月", style: TextStyle(color: Colors.grey[700])),
//                           IconButton(
//                             icon: const Icon(Icons.arrow_right),
//                             onPressed: () {
//                               setState(() {
//                                 _selectedYear++;
//                               });
//                             },
//                           ),
//
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }