import 'package:flutter_app/core/services/index.dart';
import 'package:get_it/get_it.dart';

import 'navigation_service.dart';
import 'recipes_service.dart';

final _ioc = GetIt.I;

NavigationService get navigationService => _ioc.get<NavigationService>();
RecipesService get recipesService => _ioc.get<RecipesService>();
LocalStorageService get localStorageService => _ioc.get<LocalStorageService>();

class DependencyService {
  static void registerServices() {
    _ioc.registerLazySingleton(() => NavigationService());
    _ioc.registerLazySingleton(() => RecipesService());
    _ioc.registerSingletonAsync(() async {
      final localStorageService = await LocalStorageService.getInstance();
      return localStorageService;
    });
  }
}
