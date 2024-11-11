import 'package:doctor_app/Features/Auth/domain/Entities/doctor.dart';
import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orders;
  final Doctor doctor;
  final List<Patient> patient;
  OrderLoaded(this.orders, this.doctor, this.patient);
}

class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}
