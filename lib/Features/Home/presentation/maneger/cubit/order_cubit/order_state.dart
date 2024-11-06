import 'package:doctor_app/Features/Home/domain/Entites/doctor.dart';
import 'package:doctor_app/Features/Home/domain/Entites/order.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orders;
  final Doctor doctor;
  OrderLoaded(this.orders, this.doctor);
}

class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}
