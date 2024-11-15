import 'package:doctor_app/Features/Home/domain/Entites/examination.dart';

class Order {
  final int orderId;
  final int doctorId;
  final int patientId;
  final DateTime date;
  final int patientAge;
  final ExaminationDetail detail;
  final String additionalNotes;
  final int price;

  Order( {
    required this.price,
    required this.orderId,
    required this.doctorId,
    required this.patientId,
    required this.date,
    required this.patientAge,
    required this.detail,
    required this.additionalNotes,
  });


  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['order_id'],
      doctorId: json['doctor_id'],
      patientId: json['patient_id'],
      date: DateTime.parse(json['date']),
      patientAge: json['patient_age'],
      detail: ExaminationDetail.fromJson(json['examinationdetails']),
      additionalNotes: json['additional_notes'] ?? '',
      price: json['order_price'],
    );
  }
}
