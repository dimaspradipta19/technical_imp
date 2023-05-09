import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technical_imp/model/login_model.dart';
import 'package:technical_imp/model/logout_model.dart';
import 'package:technical_imp/utils/result_state.dart';
import 'package:technical_imp/viewmodel/service/auth_service.dart';

class AuthProvider with ChangeNotifier {
  AuthService service = AuthService();
  LoginModel? loginModel;
  LogoutModel? logoutModel;
  ResultState state = ResultState.noData;

  /*Login*/
  Future<dynamic> postLogin(String email, String password, context) async {
    try {
      state = ResultState.loading;
      notifyListeners();

      loginModel = await service.postLoginModel(email, password, context);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", loginModel!.data.accessToken);

      if (loginModel == null) {
        state = ResultState.noData;
        notifyListeners();
      } else {
        state = ResultState.hasData;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", loginModel!.data.accessToken);
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  /*Logout*/
  Future<dynamic> postLogout(String token, context) async {
    try {
      state = ResultState.loading;
      notifyListeners();

      logoutModel = await service.postLogoutModel(token, context);

      if (logoutModel == null) {
        state = ResultState.noData;
        notifyListeners();
      } else {
        state = ResultState.hasData;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }
}
