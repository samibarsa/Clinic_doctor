import 'package:doctor_app/Features/Home/domain/Entites/examination_mode.dart';
import 'package:doctor_app/Features/Home/domain/Entites/examination_option.dart';
import 'package:doctor_app/Features/Home/domain/Entites/examinaton_type.dart';

class ExaminationDetail {
  final int detailId;
  final ExaminationMode mode;
  final ExaminationOption option;
  final ExaminationType type;

  ExaminationDetail({
    required this.detailId,
    required this.mode,
    required this.option,
    required this.type,
  });

  // تحويل JSON إلى كائن Dart
  factory ExaminationDetail.fromJson(Map<String, dynamic> json) {
    return ExaminationDetail(
      detailId: json['detail_id'],
      mode: ExaminationMode.fromJson(json['mode']),
      option: ExaminationOption.fromJson(json['option']),
      type: ExaminationType.fromJson(json['type']),
    );
  }
}
