import 'package:flutter/material.dart';
import 'package:technical_imp/model/create_faq_model.dart';
import 'package:technical_imp/utils/result_state.dart';
import 'package:technical_imp/viewmodel/service/create_faq_service.dart';

class CreateFaqProvider with ChangeNotifier {
  CreateFaqService service = CreateFaqService();
  CreateFaqModel? createFaqModel;
  ResultState state = ResultState.noData;

  Future<dynamic> postCreateFaq(String pertanyaan, String jawaban,
      bool status_publish, String token, context) async {
    try {
      state = ResultState.loading;
      notifyListeners();

      createFaqModel = await service.postCreateFaq(
          pertanyaan, jawaban, status_publish, token, context);

      if (createFaqModel == null) {
        state = ResultState.noData;
        notifyListeners();
      } else {
        state = ResultState.hasData;
        notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      return null;
    }
  }
}
