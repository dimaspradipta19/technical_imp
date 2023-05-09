import 'package:flutter/material.dart';
import 'package:technical_imp/model/delete_model.dart';
import 'package:technical_imp/utils/result_state.dart';
import 'package:technical_imp/viewmodel/service/delete_faq_service.dart';

class DeleteFaqProvider with ChangeNotifier {
  DeleteFaqService service = DeleteFaqService();
  DeleteFaqModel? deleteFaqModel;
  ResultState state = ResultState.noData;

  Future<dynamic> deleteFaq(String token, int idFaq, context) async {
    try {
      state = ResultState.loading;
      notifyListeners();
      deleteFaqModel = await service.deleteFaq(token, idFaq, context);

      if (deleteFaqModel == null) {
        state = ResultState.noData;
        notifyListeners();
      } else {
        state = ResultState.hasData;
        notifyListeners();
      }
    } catch (e) {
      return null;
    }
  }
}
