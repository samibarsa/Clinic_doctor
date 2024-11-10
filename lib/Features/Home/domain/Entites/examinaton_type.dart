class ExaminationType {
  final int examinationTypeId;
  final String typeName;

  ExaminationType({required this.examinationTypeId, required this.typeName});

  // تحويل JSON إلى كائن Dart
  factory ExaminationType.fromJson(Map<String, dynamic> json) {
    return ExaminationType(
      examinationTypeId: json['examination_type_id'],
      typeName: json['type_name'],
    );
  }
}
