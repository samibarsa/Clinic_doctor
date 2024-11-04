class Examination {
  final int id; // ID الفحص
  final int orderId; // ID الطلب المرتبط
  final String examinationType; // نوع الفحص
  final String? fov; // مجال الرؤية (اختياري)
  final String examinationDetails; // تفاصيل الفحص
  final String results; // النتائج أو الروابط إلى الصور

  Examination({
    required this.id,
    required this.orderId,
    required this.examinationType,
    this.fov,
    required this.examinationDetails,
    required this.results,
  });

  factory Examination.fromJson(Map<String, dynamic> json) {
    return Examination(
      id: json['examination_id'], // تأكد من تطابق الاسم مع قاعدة البيانات
      orderId: json['order_id'], // تأكد من تطابق الاسم مع قاعدة البيانات
      examinationType:
          json['examination_type'], // تأكد من تطابق الاسم مع قاعدة البيانات
      fov: json['fov'], // تأكد من تطابق الاسم مع قاعدة البيانات
      examinationDetails:
          json['examination_details'], // تأكد من تطابق الاسم مع قاعدة البيانات
      results: json['results'], // تأكد من تطابق الاسم مع قاعدة البيانات
    );
  }
}
