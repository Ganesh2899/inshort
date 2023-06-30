import 'package:get/get.dart';

class CommonService {
  static final CommonService _singleton = new CommonService._internal();
  CommonService._internal();
  static CommonService get instance => _singleton;

  RxInt selectedIndex = 0.obs;
  RxList bookMarksList = [].obs;
}
