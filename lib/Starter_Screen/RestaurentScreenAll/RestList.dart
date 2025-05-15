// ignore_for_file: file_names, unnecessary_import, implementation_imports, avoid_unnecessary_containers, prefer_const_constructors, avoid_print, override_on_non_overriding_member, annotate_overrides, prefer_is_empty, prefer_const_literals_to_create_immutables, unused_import, unnecessary_brace_in_string_interps, unused_local_variable, sized_box_for_whitespace, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/RestListShowDetail.dart';
import 'package:foodapp/models/foodlist_models.dart';
import 'package:foodapp/services/Database.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'main_RestaurantScreen.dart';

class RestList extends StatefulWidget {
  const RestList({Key? key}) : super(key: key);

  @override
  State<RestList> createState() => _RestListState();
}

final auth = FirebaseAuth.instance;

class _RestListState extends State<RestList> {
  @override
  Database db = Database.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              onPressed: () {
                print('Going To MainScreen Restaurant');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => Main_ScreenRestaurant()),
                    (route) => false);
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                size: 20,
              ),
              label: Text('')),
        ),
        backgroundColor: Colors.black,
        title: Container(
          child: Row(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
              Text(
                '${auth.currentUser?.email}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          child: Container(
            child: Row(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(65, 0, 0, 25)),
                Icon(
                  Icons.attach_money,
                  size: 20,
                  color: Colors.yellow,
                ),
                Text(
                  '00.00 THB',
                  style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(0),
        ),
      ),
      body: FutureBuilder<List<FoodListModel>>(
          future: db.get_FoodListAll(),
          builder: (context, snapshot) {
            if (snapshot.data?.length == 0) {
              return Center(
                child: Text("ยังไม่มีการทำรายการ",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    )),
              );
            } else if (snapshot.data?.length != null) {
              return Column(
                children: [
                  AspectRatio(
                    aspectRatio: 20 / 2,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(5, 5, 10, 0),
                      child: Text(
                        "รายการรับคำสั่งซื้อ",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1, //snapshot.data?.length,
                    child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          String other = "";
                          if (snapshot.data![index].foodlist_order.length > 1) {
                            other = "\n    (เพิ่มเติม)";
                          }
                          return AspectRatio(
                            aspectRatio: 9 / 2,
                            child: Container(
                              height: 75,
                              child: Card(
                                elevation: 3,
                                child: InkWell(
                                  splashColor: Colors.orange.withOpacity(0.3),
                                  onTap: () async {
                                    int id = int.parse(
                                        (snapshot.data?[index].id).toString());
                                    print("${id}");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ListShowDetail(userID: id)));
                                  },
                                  child: AspectRatio(
                                    aspectRatio: 5 / 2,
                                    child: Container(
                                      height: 75,
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.fastfood_sharp,
                                          color: Colors.amber,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              10,
                                        ),
                                        title: Text(
                                          "${snapshot.data?[index].date}  ${snapshot.data?[index].time}\nชื่อ ${snapshot.data?[index].foodlist_order[0]["name"]}... ",
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  29.5),
                                        ),
                                        subtitle: Text(
                                          "ราคา ${snapshot.data?[index].foodlist_order[0]["price"]} THB x${snapshot.data?[index].foodlist_order[0]["count"]}",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 0, 193, 6),
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  26,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${snapshot.data?[index].total} THB",
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    28,
                                                color: Color.fromARGB(
                                                    255, 0, 137, 5),
                                              ),
                                            ),
                                            Text(
                                              "เพิ่มเติม ${snapshot.data![index].foodlist_order.length - 1} รายการ",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          30),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            }
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.amber,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Loading Data...",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ));
          }),
    );
  }
}
