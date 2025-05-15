// ignore_for_file: file_names, non_constant_identifier_names, unnecessary_null_comparison

class TimesetModel {
  String time_Open;
  String time_Close;
  TimesetModel({required this.time_Open, required this.time_Close});
  factory TimesetModel.fromMap(Map<String, dynamic> newTimesetModel) {
    String time_Open = newTimesetModel["open"];
    String time_Close = newTimesetModel["close"];
    if (newTimesetModel == null) {
      return TimesetModel(time_Open: "00.00", time_Close: "00.00");
    } else {
      return TimesetModel(time_Open: time_Open, time_Close: time_Close);
    }
  }
  Map<String, dynamic> TimesetToMap() {
    return {"open": time_Open, "close": time_Close};
  }
}
