import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:technical_imp/model/update_faq_model.dart';

import '../../view/home_screen.dart';

class UpdateFaqService {
  Future<UpdateFaqModel?> postUpdateFaq(String pertanyaan, String jawaban,
      bool status_publish, int idFaq, String token, context) async {
    try {
      Dio dio = Dio();
      String url =
          "https://be.lms-staging.madrasahkemenag.com/api/v1/superadmin/faq/$idFaq?pertanyaan=$pertanyaan?&jawaban=$jawaban&status_publish=$status_publish";

      var response = await dio.post(url,
          options: Options(
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {
              "authorization": "bearer $token",
            },
          ));
      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        ), (route) => false);
        return UpdateFaqModel.fromJson(response.data);
      } else {
        throw Exception("Error update faq service: ${response.statusCode}");
      }
    } catch (e) {
      return null;
    }
  }
}
