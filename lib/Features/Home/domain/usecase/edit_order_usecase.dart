import 'package:doctor_app/Features/Home/domain/repo/data_repos.dart';

class EditOrderUsecase {
  final DataRepository dataRepository;

  EditOrderUsecase({required this.dataRepository});
  Future<void> editOrder(
      {required String? selectedOutputType,
      required int orderId,
      required String selectedImageType,
      required String? selectedExaminationOption,
      required String additionalNotes}) async {
    dataRepository.editOrder(
        orderId: orderId,
        selectedOutputType: selectedOutputType,
        selectedImageType: selectedImageType,
        selectedExaminationOption: selectedExaminationOption,
        additionalNotes: additionalNotes);
  }
}
