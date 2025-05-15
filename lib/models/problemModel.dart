// ignore_for_file: file_names, non_constant_identifier_names, unnecessary_null_comparison

class ProblemModel {
  String? name_pb;
  String? date_pb;
  String? time_pb;
  String? title_pb;
  String? comment_pb;
  ProblemModel({
    required this.name_pb,
    required this.date_pb,
    required this.time_pb,
    required this.title_pb,
    required this.comment_pb,
  });
  factory ProblemModel.fromMap(Map<String, dynamic> newProblem) {
    String name_pb = newProblem["name"];
    String date_pb = newProblem["date"];
    String time_pb = newProblem["time"];
    String title_pb = newProblem["title"];
    String comment_pb = newProblem["comment"];
    if (newProblem == null) {
      return ProblemModel(
          name_pb: null,
          date_pb: null,
          time_pb: null,
          title_pb: null,
          comment_pb: null);
    } else {
      return ProblemModel(
          name_pb: name_pb,
          date_pb: date_pb,
          time_pb: time_pb,
          title_pb: title_pb,
          comment_pb: comment_pb);
    }
  }
  Map<String, dynamic> ProblemToMap() {
    return {
      "name": name_pb,
      "date": date_pb,
      "time": time_pb,
      "title": title_pb,
      "comment": comment_pb,
    };
  }
}
