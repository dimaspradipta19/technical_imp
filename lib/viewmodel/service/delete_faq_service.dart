import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:technical_imp/model/delete_model.dart';

import '../../view/home_screen.dart';

class DeleteFaqService {
  Future<DeleteFaqModel?> deleteFaq(String token, int idFaq, context) async {
    try {
      Dio dio = Dio();
      String url =
          "https://be.lms-staging.madrasahkemenag.com/api/v1/superadmin/faq/$idFaq";

      var response = await dio.delete(url,
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
        return DeleteFaqModel.fromJson(response.data);
      } else {
        throw Exception("Error Delete FAQ Service: ${response.statusCode}");
      }
    } catch (e) {
      return null;
    }
  }
}
