// ignore_for_file: non_constant_identifier_names, empty_constructor_bodies, avoid_types_as_parameter_names, unnecessary_null_comparison, unused_local_variable, unnecessary_brace_in_string_interps, avoid_print

class CostpitalAndBankModel {
  String? cost_start;
  String? cost_target;
  Map<String, bool> paybank;
  CostpitalAndBankModel({
    required this.cost_start,
    required this.cost_target,
    required this.paybank,
  });
  factory CostpitalAndBankModel.fromMap(Map<String, dynamic> costpital) {
    String? cost_start = costpital["start"];
    String? cost_target = costpital["target"];
    Map<String, bool> paybank = {};
    if (costpital == null || costpital["banks"] == null) {
      return CostpitalAndBankModel(
          cost_start: "00.00",
          cost_target: "00.00",
          paybank: {
            "TrueWallet": false,
            "KPlus": false,
            "KrungThai": false,
            "PrompPay": false,
            "Paotung": false,
            "ShopeePay": false,
            "Bitcoin": false,
            "PayPaw": false,
            "MasterCard": false,
          });
    } else {
      print("${costpital["banks"]}");
      return CostpitalAndBankModel(
          cost_start: cost_start,
          cost_target: cost_target,
          paybank: {
            "TrueWallet": costpital["banks"]["TrueWallet"],
            "KPlus": costpital["banks"]["KPlus"],
            "KrungThai": costpital["banks"]["KrungThai"],
            "PrompPay": costpital["banks"]["PrompPay"],
            "Paotung": costpital["banks"]["Paotung"],
            "ShopeePay": costpital["banks"]["ShopeePay"],
            "Bitcoin": costpital["banks"]["Bitcoin"],
            "PayPaw": costpital["banks"]["PayPaw"],
            "MasterCard": costpital["banks"]["MasterCard"],
          });
    }
  }
  Map<String, dynamic> cospitalToMap() {
    print("########## >>>>>>>> ${paybank} <<<<<<<<< ##########");
    return {
      "start": cost_start,
      "target": cost_target,
      "banks": {
        "TrueWallet": paybank["TrueWallet"],
        "KPlus": paybank["KPlus"],
        "KrungThai": paybank["KrungThai"],
        "PrompPay": paybank["PrompPay"],
        "Paotung": paybank["Paotung"],
        "ShopeePay": paybank["ShopeePay"],
        "Bitcoin": paybank["Bitcoin"],
        "PayPaw": paybank["PayPaw"],
        "MasterCard": paybank["MasterCard"],
      },
    };
  }
}
