import 'package:dio/dio.dart';
import 'package:inshort/commons/constants/app_constants.dart';

class NewsService {
  final dio = Dio();

  Future getNewsByCategory(String selectedCategory) async {
    print('selectedCategory $selectedCategory');
    try {
      final response = await dio.get(AppConstants.BASE_URL +
          '${selectedCategory}&from=2023-06-01&sortBy=popularity&apiKey=0aa9408d956c4b139a1f196bed4f34fb');
      if (response.statusCode == 200) {
        print('getNewsByCategory  200');
        return response;
      }
    } on DioException catch (error) {
      print('getNewsByCategory error ${error}');
      throw Exception(error);
    }
  }
}
