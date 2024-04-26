import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<String>> getCategories() async {
    try {
      const String url = "https://dummyjson.com/products";

      Response response = await _dio.get(url);

      if (response.statusCode == 200) {
        List<dynamic> categoriesJson = response.data as List<dynamic>;
        List<String> categories = categoriesJson.map((category) => category.toString()).toList();
        return categories;
      } else {
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
