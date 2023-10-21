import 'package:equatable/equatable.dart';

class PreAndBirthModel extends Equatable {
  String? id;
  bool? previousBirth;
  String? cesarianSection;
  String? pregnancyWeek;
  bool? pregnancyInfoYesNo;
  String? pregnancyInfo;
  String? neededService;
  String? name;
  String? birthDay;
  String? city;
  //String? email;
  String? sex;
  String? address;
  String? userId;

  PreAndBirthModel({
    this.id,
    this.previousBirth,
    this.cesarianSection,
    this.pregnancyWeek,
    this.pregnancyInfoYesNo,
    this.pregnancyInfo,
    this.neededService,
    this.name,
    this.birthDay,
    this.city,
    //this.email,
    this.sex,
    this.address,
    this.userId
  });

  @override
  List<Object?> get props => [
    id,
    previousBirth,
    cesarianSection,
    pregnancyWeek,
    pregnancyInfoYesNo,
    pregnancyInfo,
    neededService,
    name,
    birthDay,
    city,
    //email,
    sex,
    address,
    userId
  ];

  PreAndBirthModel copyWith({
    String? id,
    bool? previousBirth,
    String? cesarianSection,
    String? pregnancyWeek,
    bool? pregnancyInfoYesNo,
    String? pregnancyInfo,
    String? neededService,
    String? name,
    String? birthDay,
    String? city,
    //String? email,
    String? sex,
    String? address,
    String? userId
  }) {
    return PreAndBirthModel(
      id: id ?? this.id,
      previousBirth: previousBirth ?? this.previousBirth,
      cesarianSection: cesarianSection ?? this.cesarianSection,
      pregnancyWeek: pregnancyWeek ?? this.pregnancyWeek,
      pregnancyInfoYesNo: pregnancyInfoYesNo ?? this.pregnancyInfoYesNo,
      pregnancyInfo: pregnancyInfo ?? this.pregnancyInfo,
      neededService: neededService ?? this.neededService,
      name: name ?? this.name,
      birthDay: birthDay ?? this.birthDay,
      city: city ?? this.city,
      //email: email ?? this.email,
      sex: sex ?? this.sex,
      address: address ?? this.address,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'previousBirth': previousBirth,
      'cesarianSection': cesarianSection,
      'pregnancyWeek': pregnancyWeek,
      'pregnancyInfoYesNo': pregnancyInfoYesNo,
      'pregnancyInfo': pregnancyInfo,
      'neededService': neededService,
      'name': name,
      'birthDay': birthDay,
      'city': city,
      //'email': email,
      'sex': sex,
      'address': address,
      'userId': userId,
    };
  }

  factory PreAndBirthModel.fromJson(Map<String, dynamic> json) {
    return PreAndBirthModel(
      id: json['id'] as String?,
      previousBirth: json['previousBirth'] as bool?,
      cesarianSection: json['cesarianSection'] as String?,
      pregnancyWeek: json['pregnancyWeek'] as String?,
      pregnancyInfoYesNo: json['pregnancyInfoYesNo'] as bool?,
      pregnancyInfo: json['pregnancyInfo'] as String?,
      neededService: json['neededService'] as String?,
      name: json['name'] as String?,
      birthDay: json['birthDay'] as String?,
      city: json['city'] as String?,
      //email: json['email'] as String?,
      sex: json['sex'] as String?,
      address: json['address'] as String?,
      userId: json['userId'] as String?,
    );
  }
}
