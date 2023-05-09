import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technical_imp/model/login_model.dart';
import 'package:technical_imp/view/home_screen.dart';
import 'package:technical_imp/view/login_screen.dart';

import '../../model/logout_model.dart';

class AuthService {
  /* Login Service */
  Future<LoginModel?> postLoginModel(
      String email, String password, context) async {
    try {
      final String url =
          "https://be.lms-staging.madrasahkemenag.com/api/v1/auth/login?nip=$email&password=$password";
      final Dio dio = Dio();

      var response = await dio.post(url);
      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        ), (route) => false);

        return LoginModel.fromJson(response.data);
      } else {
        throw Exception("Error loginService: ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
  /* End Login Service */

  /* Logout Service */
  Future<LogoutModel?> postLogoutModel(String token, context) async {
    try {
      const String url =
          "https://be.lms-staging.madrasahkemenag.com/api/v1/logout";
      final Dio dio = Dio();

      var response = await dio.post(url,
          options: Options(headers: {
            "authorization": "bearer $token",
          }));
      if (response.statusCode == 200) {
        
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn", false);
        prefs.clear();

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        ), (route) => false);

        return LogoutModel.fromJson(response.data);
      } else {
        throw Exception("Error logoutService: ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
  /* End Logout Service */
}
