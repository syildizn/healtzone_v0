import 'package:equatable/equatable.dart';

class PatientModel extends Equatable {
  final String? id;
  final String? name;
  final int? age;
  final String? phone;
  final String? address;
  final String? city;
  final bool? completedProfile;
  final String? email;
  final String? sex;

  PatientModel({
    this.id,
    this.name,
    this.age,
    this.phone,
    this.address,
    this.city,
    this.completedProfile,
    this.email,
    this.sex,
  });

  @override
  List<Object?> get props =>
      [id,name, age, phone, address, city, completedProfile, email, sex];

  PatientModel copyWith({
    String? id,
    String? name,
    int? age,
    String? phone,
    String? address,
    String? city,
    bool? completedProfile,
    String? email,
    String? sex,
  }) {
    return PatientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      completedProfile: completedProfile ?? this.completedProfile,
      email: email ?? this.email,
      sex: sex ?? this.sex,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'phone': phone,
      'address': address,
      'city': city,
      'completedProfile': completedProfile,
      'email': email,
      'sex': sex,
    };
  }

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      age: json['age'] as int?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      completedProfile: json['completedProfile'] as bool?,
      email: json['email'] as String?,
      sex: json['sex'] as String?,
    );
  }
}
