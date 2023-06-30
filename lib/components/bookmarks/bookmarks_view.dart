import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inshort/commons/constants/theme_constants.dart';
import 'package:inshort/commons/services/common_service.dart';
import 'package:inshort/commons/widgets/category_widget.dart';
import 'package:inshort/components/artlcle_detail/article_detail_view.dart';

class BookmarksView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bookmarks',
          style: TextStyle(color: ThemeConstants.WHITE_COLOR),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildBookmarks(),
            ],
          ),
        ),
      ),
    );
  }

  buildBookmarks() {
    return Container(
      child: Obx(() => CommonService.instance.bookMarksList.isNotEmpty
          ? ListView.separated(
              separatorBuilder: (context, index) =>
                  Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: CommonService.instance.bookMarksList.length,
              itemBuilder: (BuildContext ctx, index) {
                return CategoryWidget(
                  title: CommonService.instance.bookMarksList[index]['title'],
                  onPressed: () {
                    Get.to(() => ArticleDetailView(), arguments: {
                      "title": CommonService.instance.bookMarksList[index]
                          ['title'],
                      "image": CommonService.instance.bookMarksList[index]
                          ['imageUrl'],
                      "description": CommonService.instance.bookMarksList[index]
                          ['description'],
                      "isBookmarked": CommonService
                          .instance.bookMarksList[index]['isBookmarked'],
                    });
                  },
                  index: index,
                  imageUrl: CommonService.instance.bookMarksList[index]
                      ['imageUrl'],
                  isFromBookmarkScreen: true,
                );
              })
          : Container(
              height: Get.height * 0.5,
              child: Center(child: Text('No Bookmarks Found')),
            )),
    );
  }
}
