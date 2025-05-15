// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names

class CustomerModel {
  String? customer_name;
  int? customer_age;
  CustomerModel({required this.customer_name, required this.customer_age});

  factory CustomerModel.fromMap(Map<String, dynamic> customer) {
    String customer_name = customer["name"];
    int customer_age = customer["age"];
    if (customer == null) {
      return CustomerModel(
          customer_name: customer_name, customer_age: customer_age);
    } else {
      return CustomerModel(
          customer_name: customer_name, customer_age: customer_age);
    }
  }

  Map<String, dynamic> CustomerToMap() {
    return {"name": customer_name, "age": customer_age};
  }
}
