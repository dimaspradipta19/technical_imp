import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:technical_imp/model/detail_faq_model.dart';
import 'package:technical_imp/view/detail_faq_screen.dart';

class DetailServiceFaq {
  Future<DetailFaqModel?> getDetailFaq(int idFaq, String token, context) async {
    try {
      Dio dio = Dio();
      String url =
          "https://be.lms-staging.madrasahkemenag.com/api/v1/superadmin/faq/$idFaq";
      var response = await dio.get(url,
          options: Options(
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {
              "authorization": "bearer $token",
            },
          ));

      if (response.statusCode == 200) {
        // Navigator.push(context, MaterialPageRoute(
        //   builder: (context) {
        //     return const DetailFaqScreen();
        //   },
        // ));
        return DetailFaqModel.fromJson(response.data);
      } else {
        throw Exception("Error detail Faq Service: ${response.statusCode}");
      }
    } catch (e) {
      return null;
    }
  }
}
