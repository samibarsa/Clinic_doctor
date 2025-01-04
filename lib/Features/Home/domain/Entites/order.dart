import 'package:doctor_app/Features/Home/domain/Entites/examination.dart';
import 'package:doctor_app/Features/Home/domain/Entites/output.dart';

class Order {
  final int orderId;
  final int doctorId;
  final int patientId;
  final bool isImaged;
  final DateTime date;
  final ExaminationDetail detail;
  final String additionalNotes;
  final int price;
  final Output output;
  final int? toothNumber;

  Order(
    this.toothNumber, {
    required this.output,
    required this.price,
    required this.isImaged,
    required this.orderId,
    required this.doctorId,
    required this.patientId,
    required this.date,
    required this.detail,
    required this.additionalNotes,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      json['tooth_number'],
      orderId: json['order_id'],
      isImaged: json['isImaged'],
      doctorId: json['doctor_id'],
      patientId: json['patient_id'],
      date: DateTime.parse(json['date']),
      detail: ExaminationDetail.fromJson(json['examinationdetails']),
      additionalNotes: json['additional_notes'] ?? '',
      price: json['order_price'],
      output: Output.fromJson(json['output']),
    );
  }
}
