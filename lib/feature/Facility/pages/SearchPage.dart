import 'package:flutter/material.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {

  final _formKey = GlobalKey<FormState>();
  final facilityController = TextEditingController();

  // void ShowErrorDialog(BuildContext context) {
  //   showDialog(context: context,
  //               barrierDismissible: false,
  //               builder: (BuildContext context) {
  //                   return Dialog(
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(12),
  //                       side: const BorderSide(
  //                         color: Colors.black,
  //                         width: 1
  //                       )
  //                     ),
  //                     child: Padding(
  //                               padding: const EdgeInsets.only(top: 25),
  //                       child: Column(
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: [
  //                           const Text("指定した施設IDが存在しません。",
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(
  //                               fontSize: 16,
  //                               color: Colors.black
  //                             ),
  //                             ),
  //                           SizedBox(height: 20,),
  //                           const Divider(
  //                             color: Colors.grey,
  //                             thickness: 0.5,
  //                             height: 1,
  //                           ),
  //                           SizedBox(
  //                             width: double.infinity,
  //                             height: 70,
  //                             child: TextButton(onPressed: () {
  //                               Navigator.pop(context);
  //                             },
  //                                 style: TextButton.styleFrom(
  //                                   backgroundColor: Colors.transparent,
  //                                   padding: EdgeInsets.zero,
  //                                   shape: RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(0)
  //                                   )
  //                                 ),
  //
  //                                 child: Text("OK",
  //                                 style: TextStyle(
  //                                   fontSize: 16,
  //                                   color: Colors.black
  //                                 ),
  //                                 )),
  //                           )
  //
  //                           ],
  //                         ),
  //                     ),
  //
  //                   );
  //               });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[ Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "施設ID",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        SizedBox(
                        width: 250,
                        height: 50,
                        child: TextFormField(
                          obscureText: true,
                          controller: facilityController,
                          maxLength: 6,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ""; //
                            }
                            if (value.length != 6) {
                              return "";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            isDense: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: const EdgeInsetsGeometry.symmetric(
                              vertical: 24,
                              horizontal: 12
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.black, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.orange, width: 2),
                            ),

                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.red, width: 1.5),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.red, width: 1.5),
                            ),

                            errorStyle: const TextStyle(
                              height: 0,
                              fontSize: 0,
                            ),
                          ),
                        )

                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if(_formKey.currentState!.validate()) {
                                // ShowErrorDialog(context);
                                return;
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
        ],
        ),
      ),
    );
  }
}

