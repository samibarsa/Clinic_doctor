part of 'get_price_cubit.dart';

sealed class GetPriceState extends Equatable {
  const GetPriceState();

  @override
  List<Object> get props => [];
}

final class GetPriceInitial extends GetPriceState {}

final class GetPriceLoading extends GetPriceState {}

final class GetPriceLoaded extends GetPriceState {
  final int price;

  const GetPriceLoaded({required this.price});
}

final class GetPriceError extends GetPriceState {
  final String errMessage;

  const GetPriceError({required this.errMessage});
}
