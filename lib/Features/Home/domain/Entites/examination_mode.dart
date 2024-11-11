class ExaminationMode {
  final int modeId;
  final String modeName;

  ExaminationMode({required this.modeId, required this.modeName});

  // تحويل JSON إلى كائن Dart
  factory ExaminationMode.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ExaminationMode(
        modeId: 0,
        modeName: "",
      );
    }
    return ExaminationMode(
      modeId: json['mode_id'],
      modeName: json['mode_name'],
    );
  }
}
