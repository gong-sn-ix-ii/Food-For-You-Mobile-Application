// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, avoid_print

class FoodListModel {
  List<Map<String, dynamic>> foodlist_order;
  String date;
  String time;
  int id;
  int total;
  FoodListModel({
    required this.foodlist_order,
    required this.total,
    required this.time,
    required this.date,
    required this.id,
  });
  factory FoodListModel.fromMap(Map<String, dynamic> foodListModel) {
    List<Map<String, dynamic>> foodlist_order = [];

    for (int i = 0; i < foodListModel["order"].length; i++) {
      foodlist_order.addAll([
        {
          "name": foodListModel["order"][i]["name"],
          "count": foodListModel["order"][i]["count"],
          "price": foodListModel["order"][i]["price"],
        }
      ]);
    }
    String date = foodListModel["date"];
    String time = foodListModel["time"];
    int id = foodListModel["id"];
    int total = foodListModel["total"];
    /*print(
        "Foodlist Name ==> ${foodListModel["order"]}");*/ //How to use FoodListModel[order] [index] ["Field"]
    if (foodListModel == null) {
      print("Condition Complete FoodListModel == null");
      return FoodListModel(foodlist_order: [
        {
          "name": null,
          "count": null,
          "price": null,
        }
      ], total: 0, date: null.toString(), time: null.toString(), id: 0);
    } else {
      print(
          "Condtion Failed FoodListModel has data ==> ${foodlist_order[0]["name"]}");
      return FoodListModel(
        foodlist_order: foodlist_order,
        total: total,
        time: time,
        date: date,
        id: id,
      );
    }
  }
  Map<String, dynamic> FoodListToMap() {
    return {
      "order": foodlist_order,
      "total": total,
      "date": date,
      "time": time,
      "id": id,
    };
  }
}
