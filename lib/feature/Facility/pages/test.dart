// import 'package:flutter/material.dart';
// import '../data/mock_api.dart';
//
// class SearchPage extends StatefulWidget {
//   const SearchPage({super.key});
//
//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }
//
// class _SearchPageState extends State<SearchPage> {
//   final _formKey = GlobalKey<FormState>();
//   final facilityController = TextEditingController();
//
//   Facility? foundFacility;
//   bool isLoading = false;
//
//   Future<void> searchFacility() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         isLoading = true;
//         foundFacility = null;
//       });
//
//       final result = await fetchFacility(facilityController.text);
//
//       setState(() {
//         foundFacility = result;
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               children: const [
//                 Text("施設ID",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.black)),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Form(
//               key: _formKey,
//               child: Row(
//                 children: [
//                   SizedBox(
//                     width: 250,
//                     height: 50,
//                     child: TextFormField(
//                       controller: facilityController,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Fill facility";
//                         }
//                         if (value.length != 6) {
//                           return "Fill 6 digit";
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide:
//                             const BorderSide(color: Colors.black, width: 1)),
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: const BorderSide(
//                                 color: Colors.orange, width: 2)),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   ElevatedButton(
//                     onPressed: searchFacility,
//                     child: const Text(
//                       "検索",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orange,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 11, horizontal: 30),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         )),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             if (isLoading)
//               const CircularProgressIndicator(),
//             if (!isLoading && foundFacility != null)
//               Card(
//                 child: ListTile(
//                   title: Text(foundFacility!.name),
//                   subtitle: Text(foundFacility!.location),
//                 ),
//               ),
//             if (!isLoading && foundFacility == null)
//               const Text("Facility not found"),
//           ],
//         ),
//       ),
//     );
//   }
// }
