// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String email;
  final String date;
  final String phoneNumber;
  final String mode;
  UserModel({
    required this.email,
    required this.date,
    required this.phoneNumber,
    required this.mode,
  });

  UserModel copyWith({
    String? email,
    String? date,
    String? phoneNumber,
    String? mode,
  }) {
    return UserModel(
      email: email ?? this.email,
      date: date ?? this.date,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      mode: mode ?? this.mode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'date': date,
      'phoneNumber': phoneNumber,
      'mode': mode,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      date: map['date'] as String,
      phoneNumber: map['phoneNumber'] as String,
      mode: map['mode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserModel(email: $email, date: $date, phoneNumber: $phoneNumber, mode : $mode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.email == email &&
        other.date == date &&
        other.phoneNumber == phoneNumber &&
        other.mode == mode;
  }

  @override
  int get hashCode =>
      email.hashCode ^ date.hashCode ^ phoneNumber.hashCode ^ mode.hashCode;
}
