import 'package:bloc/bloc.dart';
import 'package:doctor_app/Features/Home/domain/usecase/edit_order_usecase.dart';
import 'package:equatable/equatable.dart';

part 'edit_order_state.dart';

class EditOrderCubit extends Cubit<EditOrderState> {
  EditOrderCubit(this.editOrderUsecase) : super(EditOrderInitial());
  final EditOrderUsecase editOrderUsecase;
  Future<void> editOrder(
      {required String? selectedOutputType,
      required String selectedImageType,
      required String? selectedExaminationOption,
      String? additionalNotesController}) async {}
}
