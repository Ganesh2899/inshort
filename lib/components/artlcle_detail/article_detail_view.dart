import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inshort/commons/constants/theme_constants.dart';
import 'package:inshort/components/artlcle_detail/article_detail_controller.dart';
import 'package:share_plus/share_plus.dart';

class ArticleDetailView extends StatelessWidget {
  final ArticleDetailController articleDetailController =
      Get.put(ArticleDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Get.height * 0.25,
                    width: Get.width,
                    child: CachedNetworkImage(
                      imageUrl: articleDetailController.image.value
                          .toString()
                          .replaceAll('https', 'http'),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/default_Product_Image.jpg",
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ThemeConstants.height10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ThemeConstants.screenPadding),
                    child: Column(
                      children: [
                        buildTitle(),
                        SizedBox(
                          height: ThemeConstants.height10,
                        ),
                        buildDescription(),
                        SizedBox(
                          height: ThemeConstants.height5,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
        bottomNavigationBar: buildBottomBar());
  }

  buildBottomBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.share,
            color: Colors.grey,
          ),
          label: "Share",
        ),
        BottomNavigationBarItem(
            icon: Obx(() => articleDetailController.isBookmarked.value == true
                ? Icon(Icons.bookmark, color: ThemeConstants.PRIMARY_COLOR)
                : Icon(Icons.bookmark_add_outlined, color: Colors.grey)),
            label: "Bookmark",
            activeIcon: Icon(Icons.local_offer),
            backgroundColor: Colors.grey),
      ],
      currentIndex: 0,
      onTap: (index) async {
        if (index == 0) {
          await Share.share(
            articleDetailController.image.value,
            subject: articleDetailController.title.value,
          );
        } else {}
      },
      selectedFontSize: 13,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w500,
      ),
      unselectedFontSize: 13,
      iconSize: 20,
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }

  Text buildTitle() {
    return Text(
      articleDetailController.title.value ?? '',
      style: TextStyle(
          color: ThemeConstants.TITLE_COLOR,
          fontSize: ThemeConstants.fontSize20,
          fontWeight: FontWeight.w500),
    );
  }

  buildDescription() {
    return Text(
      articleDetailController.description.value ?? '',
      style: TextStyle(
          color: ThemeConstants.SUB_TITLE_COLOR,
          fontSize: ThemeConstants.fontSize16,
          fontWeight: FontWeight.w500),
    );
  }
}
