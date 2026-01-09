// import 'package:flutter/material.dart';
// import 'package:ntt/core/widget/button_widget.dart';
// import 'package:ntt/core/widget/input_widget.dart';
//
// class Searchpage extends StatefulWidget {
//   const Searchpage({super.key});
//
//   @override
//   State<Searchpage> createState() => _SearchpageState();
// }
//
// class _SearchpageState extends State<Searchpage> {
//
//   final _formKey = GlobalKey<FormState>();
//   final facilityController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsetsGeometry.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [ Form(
//               key: _formKey,
//               child: Row(
//                 children: [
//                   SizedBox(
//                     width: 250,
//                     child: InputWidget(
//                       controller: facilityController,
//                       labelText: "Facility ID",
//                       hintText: "Enter your facility",
//                       validator:  (value) {
//                         if(value == null || value.isEmpty) {
//                           return "Fill facility";
//                         }
//                         if(value.length != 6) {
//                           return "Fill 6 digit";
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   ButtonWidget(text: "Search",
//                       onPressed: () {
//                     if(_formKey.currentState!.validate()) {
//                       print("Click button");
//                     }
//                   },
//                   ),
//                 ],
//               )
//           ),
//         ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {

  final _formKey = GlobalKey<FormState>();
  final facilityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("施設ID",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),),
              ],
            ),
            Row(
              children: [
                Form(
                  key: _formKey,
                  child: Row(
                    children: [ SizedBox(
                      width: 250,
                      height: 50,
                      child: TextFormField(
                        obscureText: true,
                        controller: facilityController,
                          validator:  (value) {
                          if(value == null || value.isEmpty) {
                            return "Fill facility";
                          }
                          if(value.length != 6) {
                            return "Fill 6 digit";
                          }
                          return null;
                        },
                        // onChanged: onChanged,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.black, width: 1)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.orange, width: 2)
                          ),
                          errorText: null,
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1.5),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1.5),
                          ),
                          errorStyle: const TextStyle(height: 0, fontSize: 0),
                        ),

                        ),
                      ),
                    ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate()) {
                              return null;
                            }
                          },
                          child: Text("検索",
                            style: TextStyle(
                              fontSize: 20
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 11,
                              horizontal: 30
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                            )
                          ),

                      )
              ],
                  ),

                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

