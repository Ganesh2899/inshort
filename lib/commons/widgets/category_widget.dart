import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inshort/commons/constants/theme_constants.dart';
import 'package:inshort/commons/services/common_service.dart';
import 'package:inshort/components/home/home_controller.dart';
import 'package:share_plus/share_plus.dart';

class CategoryWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String? title;
  final int? index;
  final String? imageUrl;
  final bool? isFromBookmarkScreen;
  final bool? isBookmarked;
  final String? description;

  HomeController homeController = Get.find();

  CategoryWidget(
      {required this.onPressed,
      this.title,
      this.index,
      this.imageUrl,
      this.isFromBookmarkScreen,
      this.isBookmarked,
      this.description});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                color: Colors.black12,
                width: 1.0,
              )),
          child: Container(
            child: Column(
              children: [
                Container(
                  height: Get.height * 0.25,
                  width: Get.width,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl.toString().replaceAll('https', 'http'),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          title ?? '',
                          style: TextStyle(
                              color: ThemeConstants.TITLE_COLOR,
                              fontSize: ThemeConstants.fontSize16,
                              fontWeight: FontWeight.w500),
                          maxLines: 2,
                        ),
                      ),
                      isFromBookmarkScreen == true
                          ? SizedBox.shrink()
                          : Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    child: Icon(
                                      Icons.share,
                                      color: Colors.grey,
                                    ),
                                    onTap: () async {
                                      await Share.share(
                                        imageUrl.toString(),
                                        subject: title,
                                      );
                                    },
                                  ),
                                  isBookmarked == true
                                      ? InkWell(
                                          child: Icon(
                                            Icons.bookmark,
                                            color: ThemeConstants.PRIMARY_COLOR,
                                          ),
                                          onTap: () {
                                            Get.rawSnackbar(
                                              message: 'Already in Bookmark',
                                              borderRadius: 10,
                                              margin: EdgeInsets.all(15),
                                            );
                                          },
                                        )
                                      : InkWell(
                                          child: Icon(
                                            Icons.bookmark_outline,
                                            color: Colors.grey,
                                          ),
                                          onTap: () {
                                            Get.rawSnackbar(
                                              message: 'Added to Bookmark',
                                              borderRadius: 10,
                                              margin: EdgeInsets.all(15),
                                            );
                                            CommonService.instance.bookMarksList
                                                .add({
                                              'title': title,
                                              'imageUrl': imageUrl,
                                              'description': description,
                                              'isBookmarked': isBookmarked
                                            });

                                            homeController
                                                    .articlesList[index ?? 0]
                                                ['isBookmarked'] = true;
                                            CommonService.instance
                                                    .bookMarksList[index ?? 0]
                                                ['isBookmarked'] = true;
                                            homeController.articlesList
                                                .refresh();
                                          },
                                        )
                                ],
                              ))
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
