import 'package:doctor_app/Features/Home/domain/usecase/fetch_order_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_app/Features/Home/domain/Entites/order.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orders;
  OrderLoaded(this.orders);
}

class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}
