import 'package:equatable/equatable.dart';

class InVitroFertilizationModel extends Equatable {
  bool? hadIVFTreatmentBefore;
  bool? haveFrozenEmbryos;
  bool? havePreviousDiagnosis;
  String? previousDiagnosisText;
  String? additionalInformation;
  bool? haveAdditionalInformation;
  String? filePath;
  String? picPath;
  String? id;
  String? name;
  String? birtDay;
  String? city;
  String? sex;
  String? address;
  String? userId;

  InVitroFertilizationModel({
    this.hadIVFTreatmentBefore,
    this.haveFrozenEmbryos,
    this.havePreviousDiagnosis,
    this.previousDiagnosisText,
    this.additionalInformation,
    this.haveAdditionalInformation,
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
    hadIVFTreatmentBefore,
    haveFrozenEmbryos,
    havePreviousDiagnosis,
    previousDiagnosisText,
    additionalInformation,
    haveAdditionalInformation,
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

  InVitroFertilizationModel copyWith({
    bool? hadIVFTreatmentBefore,
    bool? haveFrozenEmbryos,
    bool? havePreviousDiagnosis,
    String? previousDiagnosisText,
    String? additionalInformation,
    bool? haveAdditionalInformation,
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
    return InVitroFertilizationModel(
      hadIVFTreatmentBefore:
      hadIVFTreatmentBefore ?? this.hadIVFTreatmentBefore,
      haveFrozenEmbryos: haveFrozenEmbryos ?? this.haveFrozenEmbryos,
      havePreviousDiagnosis:
      havePreviousDiagnosis ?? this.havePreviousDiagnosis,
      previousDiagnosisText:
      previousDiagnosisText ?? this.previousDiagnosisText,
      additionalInformation:
      additionalInformation ?? this.additionalInformation,
      haveAdditionalInformation:
      haveAdditionalInformation ?? this.haveAdditionalInformation,
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
      'hadIVFTreatmentBefore': hadIVFTreatmentBefore,
      'haveFrozenEmbryos': haveFrozenEmbryos,
      'havePreviousDiagnosis': havePreviousDiagnosis,
      'previousDiagnosisText': previousDiagnosisText,
      'additionalInformation': additionalInformation,
      'haveAdditionalInformation': haveAdditionalInformation,
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

  factory InVitroFertilizationModel.fromJson(Map<String, dynamic> json) {
    return InVitroFertilizationModel(
      hadIVFTreatmentBefore: json['hadIVFTreatmentBefore'] as bool?,
      haveFrozenEmbryos: json['haveFrozenEmbryos'] as bool?,
      havePreviousDiagnosis: json['havePreviousDiagnosis'] as bool?,
      previousDiagnosisText: json['previousDiagnosisText'] as String?,
      additionalInformation: json['additionalInformation'] as String?,
      haveAdditionalInformation: json['haveAdditionalInformation'] as bool?,
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
