import 'package:dio/dio.dart';
import 'package:technical_imp/model/list_faq_model.dart';

class ListFaqService {
  Future<ListFaqModel?> getListFaq(String token) async {
    try {
      final Dio dio = Dio();
      const String url =
          "https://be.lms-staging.madrasahkemenag.com/api/v1/superadmin/faq?page=1&rows=10";

      var response = await dio.get(
        url,
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {
            "authorization": "bearer $token",
          },
        ),
      );
      if (response.statusCode == 200) {
        return ListFaqModel.fromJson(response.data);
      } else {
        throw Exception("Error faq service: ${response.statusCode}");
      }
    } catch (e) {
      print("Error faq service ${e.toString()}");
      // rethrow;
      return null;
    }
  }
}
