import 'package:equatable/equatable.dart';

class PatientModel extends Equatable {
  final String? id;
  final String? name;
  final String? birthDay;
  final String? phone;
  final String? address;
  final String? city;
  final bool? completedProfile;
  final String? email;
  final String? sex;
  final String? photoUrl;

  PatientModel({
    this.id,
    this.name,
    this.birthDay,
    this.phone,
    this.address,
    this.city,
    this.completedProfile,
    this.email,
    this.sex,
    this.photoUrl,
  });

  @override
  List<Object?> get props =>
      [id,name, birthDay, phone, address, city, completedProfile, email, sex, photoUrl,];

  PatientModel copyWith({
    String? id,
    String? name,
    String? birthDay,
    String? phone,
    String? address,
    String? city,
    bool? completedProfile,
    String? email,
    String? sex,
    String? photoUrl,
  }) {
    return PatientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      birthDay: birthDay ?? this.birthDay,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      completedProfile: completedProfile ?? this.completedProfile,
      email: email ?? this.email,
      sex: sex ?? this.sex,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'birthDay': birthDay,
      'phone': phone,
      'address': address,
      'city': city,
      'completedProfile': completedProfile,
      'email': email,
      'sex': sex,
      'photoUrl': photoUrl,
    };
  }

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      birthDay: json['birthDay'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      completedProfile: json['completedProfile'] as bool?,
      email: json['email'] as String?,
      sex: json['sex'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );
  }
}
