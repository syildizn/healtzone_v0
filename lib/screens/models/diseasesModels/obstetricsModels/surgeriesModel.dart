import 'package:equatable/equatable.dart';

class SurgeriesModel extends Equatable {
  bool? hadPreviousSurgery;
  String? diagnosis;
  String? selectedSurgery;
  String? surgeryType;
  String? pathologyResults;
  bool? hasMedicalInfo;
  String? medicalInfo;
  String? filePath;
  String? picPath;
  String? id;
  String? name;
  String? birtDay;
  String? city;
  String? sex;
  String? address;
  String? userId;

  SurgeriesModel({
    this.hadPreviousSurgery,
    this.diagnosis,
    this.selectedSurgery,
    this.surgeryType,
    this.pathologyResults,
    this.hasMedicalInfo,
    this.medicalInfo,
    this.filePath,
    this.picPath,
    this.id,
    this.name,
    this.birtDay,
    this.city,
    this.sex,
    this.address,
    this.userId,
  });

  @override
  List<Object?> get props => [
    hadPreviousSurgery,
    diagnosis,
    selectedSurgery,
    surgeryType,
    pathologyResults,
    hasMedicalInfo,
    medicalInfo,
    filePath,
    picPath,
    id,
    name,
    birtDay,
    city,
    sex,
    address,
    userId
  ];

  SurgeriesModel copyWith({
    bool? hadPreviousSurgery,
    String? diagnosis,
    String? selectedSurgery,
    String? surgeryType,
    String? pathologyResults,
    bool? hasMedicalInfo,
    String? medicalInfo,
    String? filePath,
    String? picPath,
    String? id,
    String? name,
    String? birtDay,
    String? city,
    String? sex,
    String? address,
    String? userId,
  }) {
    return SurgeriesModel(
      hadPreviousSurgery: hadPreviousSurgery ?? this.hadPreviousSurgery,
      diagnosis: diagnosis ?? this.diagnosis,
      selectedSurgery: selectedSurgery ?? this.selectedSurgery,
      surgeryType: surgeryType ?? this.surgeryType,
      pathologyResults: pathologyResults ?? this.pathologyResults,
      hasMedicalInfo: hasMedicalInfo ?? this.hasMedicalInfo,
      medicalInfo: medicalInfo ?? this.medicalInfo,
      filePath: filePath ?? this.filePath,
      picPath: picPath ?? this.picPath,
      id: id ?? this.id,
      name: name ?? this.name,
      birtDay: birtDay ?? this.birtDay,
      city: city ?? this.city,
      sex: sex ?? this.sex,
      address: address ?? this.address,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hadPreviousSurgery': hadPreviousSurgery,
      'diagnosis': diagnosis,
      'selectedSurgery': selectedSurgery,
      'surgeryType': surgeryType,
      'pathologyResults': pathologyResults,
      'hasMedicalInfo': hasMedicalInfo,
      'medicalInfo': medicalInfo,
      'filePath': filePath,
      'picPath': picPath,
      'id': id,
      'name': name,
      'birtDay': birtDay,
      'city': city,
      'sex': sex,
      'address': address,
      'userId': userId,
    };
  }

  factory SurgeriesModel.fromJson(Map<String, dynamic> json) {
    return SurgeriesModel(
      hadPreviousSurgery: json['hadPreviousSurgery'] as bool?,
      diagnosis: json['diagnosis'] as String?,
      selectedSurgery: json['selectedSurgery'] as String?,
      surgeryType: json['surgeryType'] as String?,
      pathologyResults: json['pathologyResults'] as String?,
      hasMedicalInfo: json['hasMedicalInfo'] as bool?,
      medicalInfo: json['medicalInfo'] as String?,
      filePath: json['filePath'] as String?,
      picPath: json['picPath'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      birtDay: json['birtDay'] as String?,
      city: json['city'] as String?,
      sex: json['sex'] as String?,
      address: json['address'] as String?,
      userId: json['userId'] as String?,
    );
  }
}
