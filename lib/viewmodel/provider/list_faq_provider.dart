import 'package:flutter/material.dart';
import 'package:technical_imp/model/list_faq_model.dart';
import 'package:technical_imp/utils/result_state.dart';
import 'package:technical_imp/viewmodel/service/list_faq_service.dart';

class ListFaqProvider with ChangeNotifier {
  ListFaqService service = ListFaqService();
  ListFaqModel? listFaq;
  ResultState state = ResultState.noData;

  Future<dynamic> getListFaq(String token) async {
    try {
      state = ResultState.loading;
      notifyListeners();

      listFaq = await service.getListFaq(token);
      if (listFaq == null) {
        state = ResultState.noData;
        notifyListeners();
      } else {
        state = ResultState.hasData;
        notifyListeners();
      }
    } catch (e) {
      print("Error faq provider: ${e.toString()}");
      // return null;
    }
    notifyListeners();
  }
}
