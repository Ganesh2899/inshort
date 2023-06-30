import 'package:get/get.dart';

class ArticleDetailController extends GetxController {
  RxString title = ''.obs;
  RxString description = ''.obs;
  RxString image = ''.obs;
  RxBool isBookmarked = false.obs;

  @override
  void onInit() {
    super.onInit();
    print('ArticleDetailController onInit called: ${Get.arguments}');
    if (Get.arguments != null) {
      title.value = Get.arguments['title'];
      description.value = Get.arguments['description'];
      image.value = Get.arguments['image'];
      isBookmarked.value = Get.arguments['isBookmarked'];
    }
  }
}
