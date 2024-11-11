part of 'edit_order_cubit.dart';

sealed class EditOrderState extends Equatable {
  const EditOrderState();

  @override
  List<Object> get props => [];
}

final class EditOrderInitial extends EditOrderState {}

final class EditOrderLoading extends EditOrderState {}

final class EditOrderLoaded extends EditOrderState {}

final class EditOrderError extends EditOrderState {
  final String errMessage;

  const EditOrderError({required this.errMessage});
}
