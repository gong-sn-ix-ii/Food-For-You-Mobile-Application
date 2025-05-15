// ignore_for_file: file_names, unused_local_variable, unnecessary_null_comparison, non_constant_identifier_names, avoid_print, unnecessary_brace_in_string_interps

class NotificationModel {
  List<Map<String, dynamic>> order;
  String date;
  String userID;
  String status;
  String time;
  int total;
  int id;
  NotificationModel({
    required this.order,
    required this.id,
    required this.date,
    required this.time,
    required this.userID,
    required this.total,
    required this.status,
  });
  factory NotificationModel.fromMap(Map<String, dynamic> notification) {
    print(
        "1.#########NotificationModel.FromMap Started ---> ${notification["date"]}");
    List<Map<String, dynamic>> order = [];
    for (int i = 0; i < notification["order"].length; i++) {
      order.addAll([
        {
          "name": notification["order"][i]["name"],
          "count": notification["order"][i]["count"],
          "price": notification["order"][i]["price"],
        }
      ]);
    } // get type list

    print("2.#########NotificationModel. ---> ${order}");
    String date = notification["date"];
    String time = notification["time"];
    String status = notification["status"];
    String userID = notification["userID"];
    int id = notification["id"];
    int total = notification["total"];
    print("3.#########NotificationModel. ###---> ${notification["total"]}");

    if (notification == null) {
      print("Condition Success NotificationModel == null");
      return NotificationModel(
        order: [
          {
            "name": null,
            "count": null,
            "price": null,
          }
        ],
        id: 0,
        date: null.toString(),
        time: null.toString(),
        userID: null.toString(),
        total: 0,
        status: null.toString(),
      );
    } else {
      print("NotificationModel Have Data");
      return NotificationModel(
        order: order,
        id: id,
        date: date,
        time: time,
        userID: userID,
        total: total,
        status: status,
      );
    }
  }
  Map<String, dynamic> NotificationToMap() {
    return {
      "order": order,
      "id": id,
      "date": date,
      "time": time,
      "userID": userID,
      "status": status,
      "total": total,
    };
  }
}
