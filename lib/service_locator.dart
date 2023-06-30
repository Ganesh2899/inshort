// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:get_it/get_it.dart';
import 'package:inshort/commons/services/news_service.dart';

GetIt locator = GetIt.instance;

setupServiceLocator() {
  locator.registerLazySingleton(() => NewsService());
}
