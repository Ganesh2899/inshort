import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inshort/commons/constants/app_constants.dart';
import 'package:inshort/commons/constants/theme_constants.dart';
import 'package:inshort/commons/widgets/category_widget.dart';
import 'package:inshort/components/artlcle_detail/article_detail_view.dart';
import 'package:inshort/components/bookmarks/bookmarks_view.dart';
import 'package:inshort/components/home/home_controller.dart';

class Homeview extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 7, child: buildSearchBar()),
                    Expanded(
                      flex: 1,
                      child: buildBookmarkIcon(),
                    )
                  ],
                ),
                SizedBox(
                  height: ThemeConstants.height6,
                ),
                buildCategories(),
                SizedBox(
                  height: ThemeConstants.height6,
                ),
                buildArticles(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconButton buildBookmarkIcon() {
    return IconButton(
        onPressed: () {
          Get.to(BookmarksView());
        },
        icon: Icon(
          Icons.bookmark_outline,
          size: 30,
        ));
  }

  buildCategories() {
    return Container(
      width: Get.width,
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: ClampingScrollPhysics(),
          itemCount: AppConstants.categoriesList.length,
          itemBuilder: (BuildContext context, int position) {
            return Padding(
                padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                child: Obx(() => ChoiceChip(
                      label:
                          Text(AppConstants.categoriesList[position]['title']),
                      labelStyle: (homeController.selectedCategoryIndex.value ==
                              position)
                          ? TextStyle(
                              color: ThemeConstants.WHITE_COLOR,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold)
                          : TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Colors.grey)),
                      backgroundColor: ThemeConstants.WHITE_COLOR,
                      selectedColor: ThemeConstants.PRIMARY_COLOR,
                      selected: homeController.selectedCategoryIndex.value ==
                          position,
                      onSelected: (selected) {
                        homeController.selectedCategoryIndex.value = position;

                        homeController.selectedCategory.value =
                            AppConstants.categoriesList[position]['title'];

                        homeController.getArticlesByCategory();
                      },
                    )));
          }),
    );
  }

  buildArticles() {
    return Obx(() => homeController.isLoading.value == true
        ? Container(
            height: Get.height * 0.5,
            child: Center(child: CircularProgressIndicator()))
        : Container(
            child: Obx(() => homeController.articlesList.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, index) =>
                        Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: homeController.articlesList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return CategoryWidget(
                        title: homeController.articlesList[index]['title'],
                        onPressed: () {
                          Get.to(() => ArticleDetailView(), arguments: {
                            "title": homeController.articlesList[index]
                                ['title'],
                            "image": homeController.articlesList[index]
                                ['image'],
                            "description": homeController.articlesList[index]
                                ['description'],
                            "isBookmarked": homeController.articlesList[index]
                                ['isBookmarked'],
                          });
                        },
                        index: index,
                        imageUrl: homeController.articlesList[index]['image'],
                        isFromBookmarkScreen: false,
                        isBookmarked: homeController.articlesList[index]
                            ['isBookmarked'],
                        description: homeController.articlesList[index]
                            ['description'],
                      );
                    })
                : Container(
                    height: Get.height * 0.5,
                    child: Center(child: Text('No Data Found')),
                  )),
          ));
  }

  TextField buildSearchBar() {
    return TextField(
      controller: homeController.searchController,
      decoration: InputDecoration(
        fillColor: ThemeConstants.GREY_COLOR,
        filled: true,
        hintText: 'Search...',
        suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              homeController.searchController.text = '';
              homeController.getArticlesByCategory();
            }),
        prefixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: ThemeConstants.GREY_COLOR, width: 0.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onChanged: (value) {
        print('value  $value');

        homeController.filterSearchResults(value);
      },
    );
  }
}
