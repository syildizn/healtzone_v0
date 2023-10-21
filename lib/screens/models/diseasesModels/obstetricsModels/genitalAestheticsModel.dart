import 'package:equatable/equatable.dart';

class GenitalAestheticsModel extends Equatable {
  bool? hadPreviousSurgery;
  bool? hadProfessionalExamination;
  String? desiredProcedure;
  String? recommendedProcedure;
  String? otherProcedure;
  String? id;
  String? name;
  String? birthDay;
  String? city;
  String? sex;
  String? address;
  String? userId;

  GenitalAestheticsModel({
    this.hadPreviousSurgery,
    this.hadProfessionalExamination,
    this.desiredProcedure,
    this.recommendedProcedure,
    this.otherProcedure,
    this.id,
    this.name,
    this.birthDay,
    this.city,
    this.sex,
    this.address,
    this.userId,
  });

  @override
  List<Object?> get props => [
    hadPreviousSurgery,
    hadProfessionalExamination,
    desiredProcedure,
    recommendedProcedure,
    otherProcedure,
    id,
    name,
    birthDay,
    city,
    sex,
    address,
    userId
  ];

  GenitalAestheticsModel copyWith({
    bool? hadPreviousSurgery,
    bool? hadProfessionalExamination,
    String? desiredProcedure,
    String? recommendedProcedure,
    String? otherProcedure,
    String? id,
    String? name,
    String? birthDay,
    String? city,
    String? sex,
    String? address,
    String? userId,
  }) {
    return GenitalAestheticsModel(
      hadPreviousSurgery: hadPreviousSurgery ?? this.hadPreviousSurgery,
      hadProfessionalExamination:
      hadProfessionalExamination ?? this.hadProfessionalExamination,
      desiredProcedure: desiredProcedure ?? this.desiredProcedure,
      recommendedProcedure: recommendedProcedure ?? this.recommendedProcedure,
      otherProcedure: otherProcedure ?? this.otherProcedure,
      id: id ?? this.id,
      name: name ?? this.name,
      birthDay: birthDay ?? this.birthDay,
      city: city ?? this.city,
      sex: sex ?? this.sex,
      address: address ?? this.address,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hadPreviousSurgery': hadPreviousSurgery,
      'hadProfessionalExamination': hadProfessionalExamination,
      'desiredProcedure': desiredProcedure,
      'recommendedProcedure': recommendedProcedure,
      'otherProcedure': otherProcedure,
      'id': id,
      'name': name,
      'birthDay': birthDay,
      'city': city,
      'sex': sex,
      'address': address,
      'userId': userId,
    };
  }

  factory GenitalAestheticsModel.fromJson(Map<String, dynamic> json) {
    return GenitalAestheticsModel(
      hadPreviousSurgery: json['hadPreviousSurgery'] as bool?,
      hadProfessionalExamination: json['hadProfessionalExamination'] as bool?,
      desiredProcedure: json['desiredProcedure'] as String?,
      recommendedProcedure: json['recommendedProcedure'] as String?,
      otherProcedure: json['otherProcedure'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      birthDay: json['birthDay'] as String?,
      city: json['city'] as String?,
      sex: json['sex'] as String?,
      address: json['address'] as String?,
      userId: json['userId'] as String?,
    );
  }
}
