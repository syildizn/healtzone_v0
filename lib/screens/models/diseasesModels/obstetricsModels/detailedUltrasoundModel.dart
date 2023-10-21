import 'package:equatable/equatable.dart';

class DetailedUltrasoundModel extends Equatable {
  bool? hadPreviousIssues;
  String? pregnancyWeek;
  String? previousIssuesText;
  String? id;
  String? name;
  String? birthDay;
  String? city;
  String? sex;
  String? address;
  String? userId;

  DetailedUltrasoundModel({
    this.hadPreviousIssues,
    this.pregnancyWeek,
    this.previousIssuesText,
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
    hadPreviousIssues,
    pregnancyWeek,
    previousIssuesText,
    id,
    name,
    birthDay,
    city,
    sex,
    address,
    userId
  ];

  DetailedUltrasoundModel copyWith({
    bool? hadPreviousIssues,
    String? pregnancyWeek,
    String? previousIssuesText,
    String? id,
    String? name,
    String? birthDay,
    String? city,
    String? sex,
    String? address,
    String? userId,
  }) {
    return DetailedUltrasoundModel(
      hadPreviousIssues: hadPreviousIssues ?? this.hadPreviousIssues,
      pregnancyWeek: pregnancyWeek ?? this.pregnancyWeek,
      previousIssuesText: previousIssuesText ?? this.previousIssuesText,
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
      'hadPreviousIssues': hadPreviousIssues,
      'pregnancyWeek ': pregnancyWeek,
      'previousIssuesText': previousIssuesText,
      'id': id,
      'name': name,
      'birthDay': birthDay,
      'city': city,
      'sex': sex,
      'address': address,
      'userId': userId,
    };
  }

  factory DetailedUltrasoundModel.fromJson(Map<String, dynamic> json) {
    return DetailedUltrasoundModel(
      hadPreviousIssues: json['hadPreviousIssues'] as bool?,
      pregnancyWeek: json['pregnancyWeek '] as String?,
      previousIssuesText: json['previousIssuesText'] as String?,
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
