class ExaminationOption {
  final int optionId;
  final String optionName;

  ExaminationOption({required this.optionId, required this.optionName});

  // تحويل JSON إلى كائن Dart
  factory ExaminationOption.fromJson(Map<String, dynamic> json) {
    return ExaminationOption(
      optionId: json['option_id'],
      optionName: json['option_name'],
    );
  }
}
