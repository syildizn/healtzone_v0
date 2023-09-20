import 'package:equatable/equatable.dart';

class DoctorModel extends Equatable {
  final String? id;
  final String? address;
  final String? companyName;
  final bool? completedProfile;
  final String? department;
  final String? email;
  final String? name;
  final String? no;
  final String? phone;
  final bool? verified;


  DoctorModel({
    this.id,
    this.address,
    this.companyName,
    this.completedProfile,
    this.department,
    this.email,
    this.name,
    this.no,
    this.phone,
    this.verified,

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
    no,
    phone,
    verified
  ];

  DoctorModel copyWith({
    String? id,
    String? address,
    String? companyName,
    bool? completedProfile,
    String? department,
    String? email,
    String? name,
    String? no,
    String? phone,
    bool? verified,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      address: address ?? this.address,
      companyName: companyName ?? this.companyName,
      completedProfile: completedProfile ?? this.completedProfile,
      department: department ?? this.department,
      email: email ?? this.email,
      name: name ?? this.name,
      no: no ?? this.no,
      phone: phone ?? this.phone,
      verified: verified ?? this.verified,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'address': address,
      'companyName': companyName,
      'completedProfile': completedProfile,
      'department': department,
      'email': email,
      'name': name,
      'no': no,
      'phone': phone,
      'verified': verified,
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
      no: json['no'] as String?,
      phone: json['phone'] as String?,
      verified: json['verified'] as bool?,
    );
  }
}
