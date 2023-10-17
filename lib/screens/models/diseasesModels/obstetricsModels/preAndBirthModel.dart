import 'package:equatable/equatable.dart';

class PreAndBirthModel extends Equatable {
  bool? previousBirth;
  bool? cesarianSection;
  String? pregnancyWeek;
  bool? pregnancyInfoYesNo;
  String? pregnancyInfo;
  String? neededService;
  String? name;
  int? age;
  String? city;
  //String? email;
  String? sex;
  String? address;

  PreAndBirthModel({
    this.previousBirth,
    this.cesarianSection,
    this.pregnancyWeek,
    this.pregnancyInfoYesNo,
    this.pregnancyInfo,
    this.neededService,
    this.name,
    this.age,
    this.city,
    //this.email,
    this.sex,
    this.address
  });

  @override
  List<Object?> get props => [
    previousBirth,
    cesarianSection,
    pregnancyWeek,
    pregnancyInfoYesNo,
    pregnancyInfo,
    neededService,
    name,
    age,
    city,
    //email,
    sex,
    address
  ];

  PreAndBirthModel copyWith({
    bool? previousBirth,
    bool? cesarianSection,
    String? pregnancyWeek,
    bool? pregnancyInfoYesNo,
    String? pregnancyInfo,
    String? neededService,
    String? name,
    int? age,
    String? city,
    //String? email,
    String? sex,
    String? address,
  }) {
    return PreAndBirthModel(
      previousBirth: previousBirth ?? this.previousBirth,
      cesarianSection: cesarianSection ?? this.cesarianSection,
      pregnancyWeek: pregnancyWeek ?? this.pregnancyWeek,
      pregnancyInfoYesNo: pregnancyInfoYesNo ?? this.pregnancyInfoYesNo,
      pregnancyInfo: pregnancyInfo ?? this.pregnancyInfo,
      neededService: neededService ?? this.neededService,
      name: name ?? this.name,
      age: age ?? this.age,
      city: city ?? this.city,
      //email: email ?? this.email,
      sex: sex ?? this.sex,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'previousBirth': previousBirth,
      'cesarianSection': cesarianSection,
      'pregnancyWeek': pregnancyWeek,
      'pregnancyInfoYesNo': pregnancyInfoYesNo,
      'pregnancyInfo': pregnancyInfo,
      'neededService': neededService,
      'name': name,
      'age': age,
      'city': city,
      //'email': email,
      'sex': sex,
      'address': address,
    };
  }

  factory PreAndBirthModel.fromJson(Map<String, dynamic> json) {
    return PreAndBirthModel(
      previousBirth: json['previousBirth'] as bool?,
      cesarianSection: json['cesarianSection'] as bool?,
      pregnancyWeek: json['pregnancyWeek'] as String?,
      pregnancyInfoYesNo: json['pregnancyInfoYesNo'] as bool?,
      pregnancyInfo: json['pregnancyInfo'] as String?,
      neededService: json['neededService'] as String?,
      name: json['name'] as String?,
      age: json['age'] as int?,
      city: json['city'] as String?,
      //email: json['email'] as String?,
      sex: json['sex'] as String?,
      address: json['address'] as String?,
    );
  }
}
