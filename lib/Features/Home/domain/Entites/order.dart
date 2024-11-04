class Order {
  final int id; // ID الطلب
  final int doctorId; // ID الطبيب
  final int patientId; // ID المريض
  final DateTime date; // تاريخ الطلب
  final int patientAge; // عمر المريض
  final String type; // نوع الفحص
  final String? examinationOptions; // خيارات الفحص (اختياري)
  final String? outputType; // نوع المخرجات (اختياري)
  final String? additionalNotes; // ملاحظات إضافية (اختياري)

  Order({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.date,
    required this.patientAge,
    required this.type,
    this.examinationOptions,
    this.outputType,
    this.additionalNotes,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['order_id'], // تأكد من تطابق الاسم مع قاعدة البيانات
      doctorId: json['doctor_id'], // تأكد من تطابق الاسم مع قاعدة البيانات
      patientId: json['patient_id'], // تأكد من تطابق الاسم مع قاعدة البيانات
      date: DateTime.parse(json['date']), // تأكد من أن التاريخ في تنسيق صحيح
      patientAge: json['patient_age'], // تأكد من تطابق الاسم مع قاعدة البيانات
      type: json['type'], // تأكد من تطابق الاسم مع قاعدة البيانات
      examinationOptions:
          json['examination_options'], // تأكد من تطابق الاسم مع قاعدة البيانات
      outputType: json['output_type'], // تأكد من تطابق الاسم مع قاعدة البيانات
      additionalNotes:
          json['additional_notes'], // تأكد من تطابق الاسم مع قاعدة البيانات
    );
  }
}
