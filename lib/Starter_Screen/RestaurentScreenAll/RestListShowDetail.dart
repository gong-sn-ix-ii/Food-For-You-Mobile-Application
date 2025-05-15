// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps, unused_local_variable, non_constant_identifier_names, file_names, prefer_interpolation_to_compose_strings, await_only_futures, avoid_print, avoid_unnecessary_containers, use_key_in_widget_constructors, unused_import, must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/main_RestaurantScreen.dart';
import 'package:foodapp/models/food_models.dart';
import 'package:foodapp/models/foodlist_models.dart';
import 'package:foodapp/services/Database.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ListShowDetail extends StatefulWidget {
  int userID;
  ListShowDetail({
    required this.userID,
  });
  @override
  State<ListShowDetail> createState() => _ListShowDetailState();
}

class _ListShowDetailState extends State<ListShowDetail> {
  @override
  Widget build(BuildContext context) {
    Database db = Database.instance;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(""),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(flex: 1, child: Container()),
            Column(
              children: [
                HeartbeatProgressIndicator(
                    child: Icon(
                  Icons.library_books_outlined,
                  color: Color.fromARGB(255, 70, 249, 11),
                  size: 60,
                )),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "ข้อมูลรายกาย",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              color: Colors.black,
              indent: 20,
              endIndent: 20,
              thickness: 4,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(100, 0, 80, 0),
              child: FutureBuilder<List<FoodListModel>>(
                  future: db.get_FoodListperDoc(widget.userID),
                  builder: (context, snapshot) {
                    return ListTile(
                      title: Text(
                        " ${snapshot.data?[0].date ?? "00/00/0000"}  ${snapshot.data?[0].time ?? "00:00"}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width / 20),
                      ),
                      subtitle: Text(
                        "ราคารวม ${snapshot.data?[0].total ?? "00"}.00 THB",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 23,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 12, 164, 17)),
                      ),
                    );
                  }),
            ),
            Divider(
              color: Colors.black,
              indent: 20,
              endIndent: 20,
              thickness: 4,
            ),
            Flexible(
              flex: 2,
              child: FutureBuilder<List<FoodListModel>>(
                  future: db.get_FoodListperDoc(widget.userID),
                  builder: (context, snapshot) {
                    return ListView.builder(
                        itemCount: snapshot.data?[0].foodlist_order.length ?? 1,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Card(
                              elevation: 2,
                              child: ListTile(
                                leading: Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                title: Text(
                                  "${snapshot.data?[0].foodlist_order[index]["name"] ?? 'ชื่อเมนู'}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                subtitle: Text(
                                    "ราคา : ${snapshot.data?[0].foodlist_order[index]["price"] ?? "00"}.00 THB"),
                                trailing: Text(
                                  "x${snapshot.data?[0].foodlist_order[index]["count"] ?? "0"}",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          );
                        });
                  }),
            ),
            // Flexible(
            //     flex: 0,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.end,
            //           children: [
            //             ElevatedButton(
            //                 style: ElevatedButton.styleFrom(
            //                     backgroundColor: Colors.white,
            //                     side: BorderSide(
            //                         style: BorderStyle.solid, width: 2)),
            //                 onPressed: () async {
            //                   showDialog(
            //                       barrierDismissible: false,
            //                       context: context,
            //                       builder: (context) => Comeback_Screen());
            //                   List<Map<String, dynamic>>? foodlist_order = [];
            //                   String date = DateTime.now().day.toString() +
            //                       "/" +
            //                       DateTime.now().month.toString() +
            //                       "/" +
            //                       DateTime.now().year.toString();

            //                   String time = DateTime.now().hour.toString() +
            //                       ":" +
            //                       DateTime.now().minute.toString();
            //                   List<FoodListModel> len =
            //                       await db.get_FoodListAll();
            //                   int id = await len.length + 1;
            //                   String uid = "";
            //                   String text =
            //                       "AaBbCCDDEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789";
            //                   for (int i = 0; i < 16; i++) {
            //                     //Round => index
            //                     int x =
            //                         Random().nextInt(text.length); //Random X
            //                     uid += text.substring(x, x + 1);
            //                   }
            //                   setState(() {
            //                     print(
            //                         "FoodModel = ${widget.foodmenu[0].food_name} |\n count = ${widget.count_foodmenu} |\n money_result = ${widget.money_result}.00 THB");
            //                   });
            //                   print(
            //                       "######### Length ===> ${widget.foodmenu.length} ");
            //                   for (int i = 0; i < widget.foodmenu.length; i++) {
            //                     print(
            //                         "[${i}].Foodmenu => ${widget.foodmenu[i].food_name} | ${widget.foodmenu[i].food_price} | count = ${widget.count_foodmenu[i]}");
            //                     foodlist_order.add({
            //                       "name": widget.foodmenu[i].food_name,
            //                       "price": widget.foodmenu[i].food_price,
            //                       "count": widget.count_foodmenu[i]
            //                     });
            //                   }
            //                   print(
            //                       " ###################### foodlist_order Variable ==> ${foodlist_order}");
            //                   FoodListModel newFoodlistModel = FoodListModel(
            //                       foodlist_order: foodlist_order,
            //                       total: widget.money_result,
            //                       date: date,
            //                       time: time,
            //                       id: id);
            //                   await db.add_FoodList(newFoodlistModel, uid);
            //                   //Navigator.pop(context, "cancle");
            //                   String my_uid = await db.my_uid();
            //                   await db.update_Database(
            //                       collection_start: "user",
            //                       collection_end: "order",
            //                       user_ID: widget.userID,
            //                       field: "status",
            //                       value: "complete",
            //                       typeString: true);
            //                   showDialog(
            //                       barrierDismissible: false,
            //                       context: context,
            //                       builder: (context) => SaveData_Success());
            //                   Future.delayed(
            //                     Duration(seconds: 3),
            //                     () => Navigator.pushAndRemoveUntil(
            //                         context,
            //                         MaterialPageRoute(
            //                             builder: (context) =>
            //                                 Main_ScreenRestaurant()),
            //                         (route) => false),
            //                   );
            //                 },
            //                 child: Row(
            //                   children: [
            //                     Container(
            //                       child: Icon(
            //                         Icons.check,
            //                         color: Color.fromARGB(255, 60, 255, 66),
            //                         size: 30,
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       width: 10,
            //                     ),
            //                     Text(
            //                       "เสร็จสิ้น",
            //                       style: TextStyle(
            //                           color: Colors.black,
            //                           fontSize: 18,
            //                           fontWeight: FontWeight.bold),
            //                     ),
            //                   ],
            //                 )),
            //             SizedBox(
            //               width: 10,
            //             ),
            //             ElevatedButton(
            //                 style: ElevatedButton.styleFrom(
            //                     backgroundColor: Colors.white,
            //                     side: BorderSide(
            //                         style: BorderStyle.solid, width: 2)),
            //                 onPressed: () async {
            //                   showDialog(
            //                       barrierDismissible: false,
            //                       context: context,
            //                       builder: (context) => Cancle_Screen());
            //                   await db.update_Database(
            //                       collection_start: "user",
            //                       collection_end: "order",
            //                       user_ID: widget.userID,
            //                       field: "status",
            //                       value: "complete",
            //                       typeString: true);
            //                   Future.delayed(
            //                     Duration(seconds: 2),
            //                     () => showDialog(
            //                       barrierDismissible: false,
            //                       context: context,
            //                       builder: (context) => Cancle_screenComplete(),
            //                     ),
            //                   );
            //                   Future.delayed(
            //                     Duration(seconds: 5),
            //                     () => Navigator.pushAndRemoveUntil(
            //                         context,
            //                         MaterialPageRoute(
            //                             builder: (context) =>
            //                                 Main_ScreenRestaurant()),
            //                         (route) => false),
            //                   );
            //                 },
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   crossAxisAlignment: CrossAxisAlignment.center,
            //                   children: [
            //                     Container(
            //                         margin: EdgeInsets.fromLTRB(0, 0, 00, 0),
            //                         child: Text(
            //                           "x",
            //                           style: TextStyle(
            //                               fontSize: 30, color: Colors.red),
            //                         )),
            //                     Container(
            //                       margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
            //                       child: Text(
            //                         "ยกเลิก",
            //                         style: TextStyle(
            //                             fontSize: 20,
            //                             fontWeight: FontWeight.bold,
            //                             color: Colors.black),
            //                       ),
            //                     ),
            //                   ],
            //                 )),
            //           ],
            //         )
            //       ],
            //     )),
          ],
        ));
  }
}
