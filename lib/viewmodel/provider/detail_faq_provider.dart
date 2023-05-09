import 'package:flutter/material.dart';
import 'package:technical_imp/model/detail_faq_model.dart';
import 'package:technical_imp/utils/result_state.dart';
import 'package:technical_imp/viewmodel/service/detail_faq_service.dart';

class DetailFaqProvider with ChangeNotifier {
  DetailServiceFaq service = DetailServiceFaq();
  DetailFaqModel? detailFaqModel;
  ResultState state = ResultState.noData;

  Future<dynamic> getDetailFaq(String token, int idFaq, context) async {
    try {
      state = ResultState.loading;
      notifyListeners();

      detailFaqModel = await service.getDetailFaq(idFaq, token, context);

      if (detailFaqModel == null) {
        state = ResultState.noData;
        notifyListeners();
      } else {
        state = ResultState.hasData;
        notifyListeners();
      }
    } catch (e) {
      throw Exception("Error detailfaqprovider: ${e.toString()}");
    }
    notifyListeners();
  }
}
