import 'package:flutter/material.dart';
import 'package:technical_imp/model/update_faq_model.dart';
import 'package:technical_imp/utils/result_state.dart';
import 'package:technical_imp/viewmodel/service/update_faq_service.dart';

class UpdateFaqProvider with ChangeNotifier {
  UpdateFaqService service = UpdateFaqService();
  UpdateFaqModel? updateFaqModel;
  ResultState state = ResultState.noData;

  Future<dynamic> postUpdateFaq(
    String pertanyaan,
    String jawaban,
    String token,
    bool status_publish,
    int idFaq,
    context,
  ) async {
    try {
      state = ResultState.loading;
      notifyListeners();

      updateFaqModel = await service.postUpdateFaq(
          pertanyaan, jawaban, status_publish, idFaq, token, context);

      if (updateFaqModel == null) {
        state = ResultState.noData;
        notifyListeners();
      } else {
        state = ResultState.hasData;
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      // throw Exception("Error update faq provider: ${updateFaqModel!.message}");
      return null;
    }
  }
}
