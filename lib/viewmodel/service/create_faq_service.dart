import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:technical_imp/model/create_faq_model.dart';
import 'package:technical_imp/view/home_screen.dart';

class CreateFaqService {
  Future<CreateFaqModel?> postCreateFaq(String pertanyaan, String jawaban,
      bool status_publish, String token, context) async {
    try {
      Dio dio = Dio();
      final String url =
          "https://be.lms-staging.madrasahkemenag.com/api/v1/superadmin/faq?pertanyaan=$pertanyaan&jawaban=$jawaban&status_publish=$status_publish";

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
        return CreateFaqModel.fromJson(response.data);
      } else {
        throw Exception("Error createfaqservice: ${response.statusCode}");
      }
    } catch (e) {
      return null;
    }
  }
}
