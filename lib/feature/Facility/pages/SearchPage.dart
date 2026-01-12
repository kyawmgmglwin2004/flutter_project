import 'package:flutter/material.dart';
import 'package:ntt/core/route/app_route.dart';
import 'package:ntt/mock/consumption_detail_mock_data.dart';
import 'package:ntt/mock/consumption_mock_data.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {

  final facilityController = TextEditingController();
  // final FlutterSecureStorage storage = FlutterSecureStorage();
  bool isLoading = false;
  ConsumptionData? foundFacility;

  Future<void> searchFacility() async {
    setState(() {
      isLoading = true;
    });
    print("reach");

    final id = facilityController.text;
    final List<ConsumptionData> data = getMockData();

    foundFacility = null;
    for(var DetailData in data) {
      if(DetailData.facilityId == id) {
        foundFacility = DetailData;
        break;
      }
    }


    if(foundFacility == null ){
      setState(() {
        isLoading = false;
        print("Don't have : $foundFacility");
      });
      ShowErrorDialog(context);
    } else {
      setState(() {
        isLoading = false;
      });
      print("reach page");
      // await storage.write(key:  'facilityId', value: id);

      Navigator.pushReplacementNamed(context, AppRoute.consumption, arguments: id);
    }
  }

  void ShowErrorDialog(BuildContext context) {
    showDialog(context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 1
                        )
                      ),
                      child: Padding(
                                padding: const EdgeInsets.only(top: 25),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("指定した施設IDが存在しません。",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black
                              ),
                              ),
                            SizedBox(height: 20,),
                            const Divider(
                              color: Colors.grey,
                              thickness: 0.5,
                              height: 1,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 70,
                              child: TextButton(onPressed: () {
                                Navigator.pop(context);
                              },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0)
                                    )
                                  ),

                                  child: Text("OK",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black
                                  ),
                                  )),
                            )

                            ],
                          ),
                      ),

                    );
                });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
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
                  Row(
                    children: [
                      SizedBox(
                      width: 250,
                      height: 50,
                      child: TextFormField(
                        controller: facilityController,
                        maxLength: 6,
                        decoration: InputDecoration(
                          counterText: "",
                          isDense: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.symmetric(
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
                        ),
                      )

                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed:  () {
                          if(!isLoading) {
                            searchFacility();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 11,
                            horizontal: 30,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: isLoading
                            ? SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : Text(
                          "検索",
                          style: TextStyle(fontSize: 20),
                        ),
                      )



                    ],
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

