import 'package:equatable/equatable.dart';

class DoctorModel extends Equatable {
  final String? id;
  final String? address;
  final String? companyName;
  final bool? completedProfile;
  final String? department;
  final String? email;
  final String? name;
  final String? graduationYear;
  final String? phone;
  final bool? verified;
  final String? title;
  final String? university;
  final String? role;

  DoctorModel({
    this.id,
    this.address,
    this.companyName,
    this.completedProfile,
    this.department,
    this.email,
    this.name,
    this.graduationYear,
    this.phone,
    this.verified,
    this.title,
    this.university,
    this.role
  });

  @override
  List<Object?> get props => [
    id,
    address,
    companyName,
    completedProfile,
    department,
    email,
    name,
    graduationYear,
    phone,
    verified,
    title,
    university,
    role
  ];

  DoctorModel copyWith({
    String? id,
    String? address,
    String? companyName,
    bool? completedProfile,
    String? department,
    String? email,
    String? name,
    String? graduationYear,
    String? phone,
    bool? verified,
    String? title,
    String? university,
    String? role,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      address: address ?? this.address,
      companyName: companyName ?? this.companyName,
      completedProfile: completedProfile ?? this.completedProfile,
      department: department ?? this.department,
      email: email ?? this.email,
      name: name ?? this.name,
      graduationYear: graduationYear ?? this.graduationYear,
      phone: phone ?? this.phone,
      verified: verified ?? this.verified,
      title: title ?? this.title,
      university: university ?? this.university,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'companyName': companyName,
      'completedProfile': completedProfile,
      'department': department,
      'email': email,
      'name': name,
      'graduationYear': graduationYear,
      'phone': phone,
      'verified': verified,
      'title': title,
      'university': university,
      'role': role,
    };
  }

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] as String?,
      address: json['address'] as String?,
      companyName: json['companyName'] as String?,
      completedProfile: json['completedProfile'] as bool?,
      department: json['department'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      graduationYear: json['graduationYear'] as String?,
      phone: json['phone'] as String?,
      verified: json['verified'] as bool?,
      title: json['title'] as String?,
      university: json['university'] as String?,
      role: json['role'] as String?,
    );
  }
}
