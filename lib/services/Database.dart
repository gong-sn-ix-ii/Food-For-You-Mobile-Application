// ignore_for_file: file_names, non_constant_identifier_names, unused_local_variable, await_only_futures, unnecessary_brace_in_string_interps, avoid_print, unused_import, avoid_function_literals_in_foreach_calls, invalid_required_named_param, unnecessary_null_comparison, prefer_interpolation_to_compose_strings, prefer_is_empty, prefer_adjacent_string_concatenation
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/models/TimesetModel.dart';
import 'package:foodapp/models/cospital_model.dart';
import 'package:foodapp/models/customer_models.dart';
import 'package:foodapp/models/food_models.dart';
import 'package:foodapp/models/foodlist_models.dart';
import 'package:foodapp/models/information_models.dart';
import 'package:foodapp/models/makeList_Models.dart';
import 'package:foodapp/models/notificationModel.dart';
import 'package:foodapp/models/problemModel.dart';
import 'package:foodapp/models/user_models.dart';

import 'service.dart';

class Database {
  static Database instance = Database._();
  Database._();
  final auth = FirebaseAuth.instance;
  String alluid = "";
  String uid = "";

  Future<UserModel> Searching_User({
    required String collection,
    required String field,
    required String equalTo,
  }) async {
    Map<String, dynamic> userModel = {};
    final reference = FirebaseFirestore.instance.collection(collection);
    final query = await reference.where(field, isEqualTo: equalTo);
    final snapshot = await query.get();
    snapshot.docs.forEach((document) {
      if (document.exists) {
        print("###---Database Searching_User => ${document.data()}");
        userModel = document.data();
      }
    });
    return UserModel.fromMap(userModel);
  }

  Future<List<String>> get_allUID({String path = "user"}) async {
    List<String> masterUID = [];
    final reference =
        await FirebaseFirestore.instance.collection(path).get().then(
              (snapshot) => snapshot.docs.forEach((doc) {
                masterUID.add(doc.reference.id);
              }),
            );
    print(
        "###[Class Database Function get_allUID] check get AllUID = ${masterUID} | length [${masterUID.length}]");
    return masterUID;
  }

  Future<String> my_uid() async {
    String my_uid = "";
    final reference = await FirebaseFirestore.instance
        .collection("user")
        .where("email", isEqualTo: auth.currentUser?.email)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            my_uid = document.reference.id.toString();
            print(
                "Database check Auth => ${auth.currentUser?.email} | id = ${my_uid}");
          }),
        );
    return my_uid;
  }

  Future<List<FoodModel>> getAllFoodMenu_Database(
      {@required String masterID = "null"}) async {
    String myUID = "";
    if (masterID == "null") {
      myUID = await my_uid();
      print(
          "#############################[Condtion masterID != null Complete ${myUID}]");
    } else if (masterID != "null") {
      myUID = masterID;
    }
    print("#########+++++++++++++++++-------------------->>>>>>> ${myUID}");
    final reference =
        await FirebaseFirestore.instance.collection("/user/${myUID}/foodmenu");
    final query = await reference.orderBy("price", descending: false);
    final snapshot = await query.get();
    return snapshot.docs.map((snapshot) {
      return FoodModel.fromMap(snapshot.data());
    }).toList();
  }

  Future<List<FoodModel>> Search_FoodmenuForData(
      {required String search, @required String masterID = "null"}) async {
    String myUID = "";
    if (masterID == "null") {
      myUID = await my_uid();
      print(
          "#############################[Condtion masterID != null Complete ${myUID}]");
    } else if (masterID != "null") {
      myUID = masterID;
    }
    final reference =
        await FirebaseFirestore.instance.collection("/user/${myUID}/foodmenu");
    final query =
        await reference.where("name", isEqualTo: search.toString()).get();
    return query.docs.map((doc) => FoodModel.fromMap(doc.data())).toList();
  }

  Future<void> AddFoodMenu(FoodModel newFoodMenu, String uid) async {
    String myUID = await my_uid();
    final reference =
        await FirebaseFirestore.instance.doc("/user/${myUID}/foodmenu/${uid}");
    await reference.set(newFoodMenu.FoodToMap());
    print("add Foodmenu success");
  }

  Future<void> DeleteFoodMenu(FoodModel delFoodMenu, String uid) async {
    String myUID = await my_uid();
    print("Deletting FoodModel... name : ${delFoodMenu}");
    final reference =
        await FirebaseFirestore.instance.doc("/user/${myUID}/foodmenu/${uid}");
    await reference.delete();
    print("delete Foodmenu success");
  }

  Future<String> get_FoodUID(FoodModel foodmenu) async {
    String myUID = await my_uid();
    final get = await FirebaseFirestore.instance
        .collection("/user/${myUID}/foodmenu")
        .where("name", isEqualTo: foodmenu.food_name)
        .where("type", isEqualTo: foodmenu.food_type)
        .where("price", isEqualTo: foodmenu.food_price)
        .get()
        .then((value) => value.docs.forEach((element) {
              uid = element.reference.id.toString();
            }));
    print(
        "[Database.get_FoodUID] name : ${foodmenu.food_name} | type : ${foodmenu.food_type} | price : ${foodmenu.food_price}.00 |\nUID[get_FoodUID] ==> %{$uid}");
    return uid;
  }

  Future<List<InformationModel>> get_AllInformation(
      {@required String masterID = "null"}) async {
    String myUID = await my_uid();
    if (masterID != "null" || masterID != null) {
      print(
          "[Database get_AllInformation]########### MasterID Condition Success [${masterID}]");
      myUID = masterID;
    }
    final reference = await FirebaseFirestore.instance
        .collection("/user/${myUID}/information")
        .get();
    return reference.docs
        .map((snapshot) => InformationModel.fromMap(snapshot.data()))
        .toList();
  }

  Future<List<FoodListModel>> get_FoodListperDoc(int id) async {
    String myUID = await my_uid();
    FoodListModel foodListModel;
    final reference = await FirebaseFirestore.instance
        .collection("/user/${myUID}/list")
        .where("id", isEqualTo: id)
        .get();
    return reference.docs.map((doc) {
      print(
          "####----> Class Database Future<List<FoodListModel>> get_FoodListperDoc = ${doc.data()}");
      return FoodListModel.fromMap(doc.data());
    }).toList();
  }

  Future<InformationModel> get_Information({String masterID = "null"}) async {
    String myUID = await my_uid();
    Map<String, dynamic> informationData = {};
    final reference = await FirebaseFirestore.instance
        .collection("/user/${myUID}/information");

    final query = await reference.orderBy("name", descending: false);
    final snapshot = await query.get();
    snapshot.docs.forEach((snapshots) {
      if (snapshots.exists) {
        informationData = snapshots.data();
      }
    });
    print("Information Database => ${informationData}");
    return await InformationModel.fromMap(informationData);
  }

  Future<void> add_Information(InformationModel information) async {
    try {
      String myUID = await my_uid();
      final reference = await FirebaseFirestore.instance
          .doc("/user/${myUID}/information/default");
      await reference.set(information.Information_ToMap());
      print("updating...\nSuccess ${information}");
    } catch (err) {
      print("add Information Failed... \nError ==> ${err}");
    }
  }

  Future<CostpitalAndBankModel> get_CospitalAndBank() async {
    String myUID = await my_uid();
    Map<String, dynamic> costpital = {};
    final query = await FirebaseFirestore.instance
        .collection("/user/${myUID}/paybank")
        .get();
    query.docs.forEach((snapshot) {
      if (snapshot.exists) {
        costpital = snapshot.data();
      }
    });
    return await CostpitalAndBankModel.fromMap(costpital);
  }

  Future<void> add_CospitalAndBank(CostpitalAndBankModel newcospital) async {
    String myUID = await my_uid();
    try {
      final reference = await FirebaseFirestore.instance
          .doc("/user/${myUID}/paybank/default");
      reference.set(newcospital.cospitalToMap());
      print("Add Costpital Success");
    } catch (err) {
      print(
          "add Costpital Failed... \nError ==> ${err}"); //comment Add Database for Cospital
    }
  }

  Future<void> add_MakeList(MakeListModel newFoodModel,
      {required int id}) async {
    String my_UID = await db.my_uid();
    final ref = FirebaseFirestore.instance
        .doc("/user/${my_UID}/makeList/defualt${id}"); //E21i01n4G6
    try {
      ref.set(newFoodModel.MakeListToMap());
      print("add Foodmenu Complete");
    } catch (e) {
      print("Error ${e}");
    }
  }

  Future<List<MakeListModel>> get_MakeListAll() async {
    String my_uid = await db.my_uid();
    final ref =
        FirebaseFirestore.instance.collection("/user/${my_uid}/makeList");
    final snapshot = await ref.get();
    return snapshot.docs
        .map((doc) => MakeListModel.fromMap(doc.data()))
        .toList();
  }

  Future<MakeListModel> get_MakeList({required int id}) async {
    String my_uid = await db.my_uid();
    Map<String, dynamic> makeList = {};
    final ref = FirebaseFirestore.instance;
    print("ID = ${id}");
    final snapshot = await ref
        .collection("/user/${my_uid}/makeList/")
        .where("id", isEqualTo: id)
        .get();
    snapshot.docs.forEach((doc) {
      makeList = doc.data();
      print(
          "!!!1---> class Database get_MakeList Line 262 check Data ==> ${makeList}");
    });
    return await MakeListModel.fromMap(makeList);
  }

  Future<List<FoodListModel>> get_FoodListAll() async {
    String myUID = await my_uid();
    final reference =
        await FirebaseFirestore.instance.collection("/user/${myUID}/list");
    final query = await reference.orderBy("id", descending: true).get();
    return query.docs.map((snapshot) {
      print(snapshot.data());
      return FoodListModel.fromMap(snapshot
          .data()); //Comment get Information from Database To FoodListAll
    }).toList();
  }

  Future<void> add_FoodList(FoodListModel newFoodlistmodel, String uid) async {
    String myUID = await my_uid();
    final reference =
        await FirebaseFirestore.instance.doc("/user/${myUID}/list/${uid}");
    try {
      reference.set(newFoodlistmodel.FoodListToMap());
      print("add Foodlist Complete");
    } catch (err) {
      print("add Foodlist Failed ${err}");
    }
  }

  Future<void> add_problem(ProblemModel newProblem) async {
    String myUID = await my_uid();
    print("#### add_problem Class database ${newProblem.name_pb}");
    final refetence = await FirebaseFirestore.instance
        .doc("/problem/${myUID}/defualt/${time}");
    try {
      await refetence.set(newProblem.ProblemToMap());
      print("Add Problem Success");
    } catch (e) {
      print("Add Problem Failed ${e}");
    }
  }

  Future<void> add_notification(FoodListModel newNotification,
      {required String master_id,
      required String doc_id,
      required String collection_inside,
      @required String status = "wait"}) async {
    final reference = FirebaseFirestore.instance
        .doc('/user/${master_id}/${collection_inside}/${doc_id}');
    try {
      print("adding notification ");
      await reference.set(
        newNotification.FoodListToMap(),
      );
      await reference.update({"userID": doc_id});
      await reference.update({"status": status});
      //status : ["wait" , "accept", "cancle"]
      print('add notification finish');
    } catch (err) {
      rethrow;
    }
  }

  //update
  Future<void> update_Database({
    required String collection_start,
    required String collection_end,
    required String user_ID,
    required String field,
    required String value,
    required bool typeString,
  }) async {
    String my_UID = await my_uid();
    if (user_ID.length <= 0) {
      user_ID = "null";
    } else {
      user_ID = user_ID;
    }
    print(
        "####Update Database ==> path /${collection_start}/${my_UID}/${collection_end}/${user_ID} |  {${field} : ${value}} ");
    final reference = await FirebaseFirestore.instance
        .doc("/${collection_start}/${my_UID}/${collection_end}/${user_ID}");
    print("##--adding database");
    try {
      if (typeString) {
        await reference.update({field: value});
      } else {
        await reference.update({field: int.tryParse(value)});
      }
      print("add database complete");
    } catch (err) {
      print("adding failed Error : ${err}");
    }
  }

  Future<void> delete_Database({required String path}) async {
    String my_UID = await db.my_uid();
    print("Deleting Database path : ${path}");
    try {
      final refernce = await FirebaseFirestore.instance.doc(path).delete();

      print("Delete Database[${path}] Complete");
    } catch (err) {
      print("Deleting Database Failed Error : ${err}");
    }
  }

  Stream<String> stream_myUID() {
    String stream_ID = "";
    final reference = FirebaseFirestore.instance
        .collection("user")
        .where("email", isEqualTo: auth.currentUser?.email)
        .snapshots();
    return reference.map((snapshots) {
      return snapshots.docs.map((doc) {
        String stream_ID = doc.reference.id;
        print(
            "#######=========> Database Function stream_myUID ==> ${doc.reference.id} | ${stream_ID.length}");
        return stream_ID;
      }).toString();
    });
  }

  Stream<List<NotificationModel>> get_Notification_versionStream(
      {required String master_ID}) {
    print(
        "get_Notification_versionStreeam | parameter MasterID = [${master_ID}]");
    if (master_ID.length <= 0) {
      master_ID = "asda";
    } else {
      master_ID = master_ID;
    }
    print(
        "########### get_Notification_versionStream path : /user/${master_ID}/notificationMessagerToUser/ ");

    final reference = FirebaseFirestore.instance
        .collection("/user/${master_ID}/notificationMessagerToUser/")
        .snapshots();
    return reference.map((snapshots) {
      return snapshots.docs.map((document) {
        print("${document.data()}");
        return NotificationModel.fromMap(document.data());
      }).toList();
    });
  }

  Stream<List<NotificationModel>> get_Notification_versionStream_CanOrderBy({
    required String master_ID,
    required String collection_Inside,
    required bool desception,
  }) {
    print(
        "#######get_Notification_versionStream | parameter1 MasterID = [${master_ID}]");
    if (master_ID.length <= 0) {
      master_ID = "2E1i01n20g03";
    } else {
      master_ID = master_ID;
    }

    print(
        "#####get_Notification_versionStream_CanSearching | path : /user/${master_ID}/${collection_Inside}/ .orderBy('id', descending : ${desception})");
    final reference = FirebaseFirestore.instance
        .collection("/user/${master_ID}/${collection_Inside}/")
        .orderBy("id", descending: desception)
        .snapshots();
    return reference.map((snapshots) {
      return snapshots.docs.map((doc) {
        return NotificationModel.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<NotificationModel>> get_Notification_versionStream_CanSearching({
    required String master_ID,
    required String user_ID,
    required String collection_Inside,
  }) {
    print(
        "#######get_Notification_versionStream | parameter1 MasterID = [${master_ID}] parameter2 UserID = [${user_ID}]");
    if (master_ID.length <= 0) {
      master_ID = "2E1i01n20g03";
    } else {
      master_ID = master_ID;
    }

    if (user_ID.length <= 0) {
      user_ID = "2E1i01n20g03";
    } else {
      user_ID = user_ID;
    }
    print(
        "#####get_Notification_versionStream_CanSearching | path : /user/${master_ID}/${collection_Inside}/ .Where('userID' : isEqualTo :  ${user_ID})");
    final reference = FirebaseFirestore.instance
        .collection("/user/${master_ID}/${collection_Inside}/")
        .where("userID", isEqualTo: user_ID)
        .snapshots();
    return reference.map((snapshots) {
      return snapshots.docs.map((doc) {
        return NotificationModel.fromMap(doc.data());
      }).toList();
    });
  }

  Future<List<NotificationModel>> get_DataInside_Collection_Order(
      {required String master_ID}) async {
    String my_uid = await db.my_uid();
    if (master_ID.length <= 0) {
      master_ID = "2E1i01n20g03";
    } else {
      master_ID = master_ID;
    }
    print(
        "Call Class Database Function get_DataInside_Collection_Order Starting... ${master_ID}");
    final reference = await FirebaseFirestore.instance
        .collection("/user/${my_uid}/order")
        .where("date", isEqualTo: date);
    final query = await reference.get();
    return query.docs.map((snapshots) {
      print(
          "##### Future<List<NotificationModel>> get_DataInside_Collection_Order ==> ${snapshots.data()}");
      return NotificationModel.fromMap(snapshots.data());
    }).toList();
  }

  Future<void> add_Timeset({required TimesetModel timesetModel}) async {
    print("Database Adding Timeset");
    String master_id = await db.my_uid();
    try {
      await FirebaseFirestore.instance
          .doc("user/${master_id}/timesetOpenClose/defualt")
          .set(timesetModel.TimesetToMap());
      print("Class Database Adding Conplete ");
    } catch (e) {
      print("Class Database Adding TimesetOpenClose Failed Error : ${e}");
    }
  }

  Stream<TimesetModel> get_TimesetOpenClose({required String master_UID}) {
    if (master_UID.length <= 0) {
      master_UID = "2E1i01n20g03";
    } else {
      master_UID = master_UID;
    }
    Map<String, dynamic> timesetOpenClose = {};
    String path = "/" + "user" + "/" + master_UID + "/" + "timesetOpenClose/";
    print("1Get_TimesetModel Master ID : ${path}");
    final refernce = FirebaseFirestore.instance.collection(path).snapshots();
    return refernce.map((snapshots) {
      print("2Get_TimesetModel Master ID : ${master_UID}");
      print("#################-----Class Database Get_TimesetModel geting...");
      snapshots.docs.forEach((document) {
        print(
            "####-Class Database Get_TimesetModel Data is : ${document.data()}");
        if (document.exists) {
          timesetOpenClose = document.data();
        }
      });

      return TimesetModel.fromMap(timesetOpenClose);
    });
  }

  Future<List<NotificationModel>> get_Notification_versionFuture(
      {required String masterID, @required String serial = "null"}) async {
    List<NotificationModel> notify = [];
    masterID = await db.my_uid();
    String path = "";
    print(
        "Database Function[Future<List<NotificationModel>> get_Notification_versionFuture check path [${path}]]");
    print(
        "Calling Database-Future-get_Notification_versionFuture |masterID = ${masterID}");
    final reference = await FirebaseFirestore.instance
        .collection("/user/${masterID}/notificationMessagerToUser")
        .where("userID", isEqualTo: serial)
        .get();
    return reference.docs.map((snapshots) {
      print("########################## ${snapshots.data()}");
      return NotificationModel.fromMap(snapshots.data());
    }).toList();
  }

  Stream<List<Map<String, dynamic>>> getCollectionStream(String path) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshot = reference.snapshots();
    return snapshot.map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  Stream<String> Searching_document_id({
    required String Firstcollection,
    required String my_uid,
    required String Secondcollection,
    required String field,
    required String value,
  }) {
    String? ref_documentID = "";

    String path = "/" + Firstcollection + "/" + my_uid + "/" + Secondcollection;
    final reference = FirebaseFirestore.instance
        .collection(path)
        .where(field, isEqualTo: value)
        .snapshots();
    return reference.map((snapshot) => snapshot.docs.map((document) async {
          ref_documentID = await document.reference.id;
          print(
              "Stream<String> Searching_document_id Result Get UID => ${ref_documentID}");
          return ref_documentID;
        }).toString());
  }
}

//get Foodmenu by masterID || masterID = restaurant 1 per foodmenu

//Realtime Stream<>
