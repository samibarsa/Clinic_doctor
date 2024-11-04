class Note {
  final int id; // ID الملاحظة
  final int orderId; // ID الطلب المرتبط
  final String note; // محتوى الملاحظة

  Note({
    required this.id,
    required this.orderId,
    required this.note,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['note_id'], // تأكد من تطابق الاسم مع قاعدة البيانات
      orderId: json['order_id'], // تأكد من تطابق الاسم مع قاعدة البيانات
      note: json['note'], // تأكد من تطابق الاسم مع قاعدة البيانات
    );
  }
}
