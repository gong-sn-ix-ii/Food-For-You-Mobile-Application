// ignore_for_file: file_names, non_constant_identifier_names, unnecessary_null_comparison

class MakeListModel {
  List<Map<String, dynamic>> makelist_order;
  MakeListModel({
    required this.makelist_order,
  });

  factory MakeListModel.fromMap(Map<String, dynamic> newMakeList) {
    List<Map<String, dynamic>> makelist_order = [];
    for (int i = 0; i < newMakeList["order"].length; i++) {
      makelist_order.addAll([
        {
          "name": newMakeList["order"][i]["name"],
          "type": newMakeList["order"][i]["type"],
          "price": newMakeList["order"][i]["price"],
          "linkImage": newMakeList["order"][i]["linkImage"],
          "image": newMakeList["order"][i]["image"],
        }
      ]);
    }
    if (newMakeList == null) {
      return MakeListModel(makelist_order: [
        {
          "name": null,
          "type": null,
          "price": null,
          "image": null,
          "linkImage": null
        }
      ]);
    } else {
      return MakeListModel(makelist_order: makelist_order);
    }
  }
  Map<String, dynamic> MakeListToMap() {
    return {
      "order": makelist_order,
    };
  }
}
