class ExaminationMode {
  final int modeId;
  final String modeName;

  ExaminationMode({required this.modeId, required this.modeName});

  // تحويل JSON إلى كائن Dart
  factory ExaminationMode.fromJson(json) {
    return ExaminationMode(
      modeId: json['mode_id'] ?? 0,
      modeName: json['mode_name'] ?? "",
    );
  }
}
