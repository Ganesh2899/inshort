import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inshort/commons/constants/app_constants.dart';
import 'package:inshort/commons/services/news_service.dart';
import 'package:inshort/service_locator.dart';

class HomeController extends GetxController {
  RxInt selectedCategoryIndex = 0.obs;
  RxString selectedCategory = 'Politics'.obs;

  final dio = Dio();
  RxList articlesList = [].obs;
  RxBool isLoading = false.obs;

  TextEditingController searchController = TextEditingController();

  NewsService get newsService => locator<NewsService>();

  @override
  void onInit() {
    super.onInit();
    print('Homeview onInit called');
    getArticlesByCategory();
  }

  // Get the list of articles by category

  getArticlesByCategory() async {
    try {
      isLoading.value = true;
      articlesList.clear();

      await newsService
          .getNewsByCategory(selectedCategory.value)
          .then((value) async {
        print('getArticlesByCategory Res:   ${value.data['articles']}');
        isLoading.value = false;
        value.data['articles'].forEach((article) {
          articlesList.add({
            "title": article['title'],
            "image": article['urlToImage'],
            "description": article['description'],
            "isBookmarked": false
          });
        });
      }).catchError((onError) {
        print(onError);
        print('getArticlesByCategory onError ::: ${onError}');
      });
    } catch (e) {
      print('getArticlesByCategory err ::: ${e}');
      print(e);
    }
  }

  void filterSearchResults(String query) {
    List searchResults = [];

    if (query.length > 0) {
      articlesList.forEach((article) {
        if (article['title'].toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(article);
        }
      });

      articlesList.clear();
      articlesList.addAll(searchResults);
    } else {
      getArticlesByCategory();
    }
  }
}
