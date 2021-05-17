import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:flutter_app/ui/index.dart';
import 'package:flutter_app/core/models/index.dart';
import 'package:flutter_app/core/extensions/index.dart';
import 'package:flutter_app/core/blocs/index.dart';

enum Pages {
  initial,
  login,
  signUp,
  home,
  recipeDetails,
}

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = Get.key;

  Future<dynamic> navigateTo(Pages page, {Object arguments}) {
    final route = _generateRoute(page, arguments);
    return navigatorKey.currentState.push(route);
  }

  Future<dynamic> navigateWithReplacementTo(Pages page, {Object arguments}) {
    final route = _generateRoute(page, arguments);
    return navigatorKey.currentState.pushReplacement(route);
  }

  void goBack() {
    navigatorKey.currentState.pop();
  }

  Route<dynamic> _generateRoute(Pages page, Object arguments) {
    Widget resultPage;

    switch (page) {
      case Pages.initial:
        resultPage = WelcomePage().createWithProvider(
          (context) => WelcomeBloc(),
        );
        break;
      case Pages.login:
        resultPage = LoginPage();
        break;
      case Pages.signUp:
        resultPage = SignUpPage();
        break;
      case Pages.home:
        resultPage = ShellPage().createWithMultiProvider(
          () => [
            BlocProvider<ShellBloc>(create: (_) => ShellBloc()),
            BlocProvider<CategoriesBloc>(create: (_) => CategoriesBloc()),
            BlocProvider<RecipesBloc>(create: (_) => RecipesBloc()),
          ],
        );
        break;
      case Pages.recipeDetails:
        final recipe = arguments as Recipe;
        resultPage = RecipeDetailsPage(
          recipe: recipe,
        ).createWithMultiProvider(
          () => [
            BlocProvider<RecipeDetailsBloc>(
              create: (_) => RecipeDetailsBloc(),
            ),
          ],
        );
        break;
      default:
        resultPage = ShellPage().createWithProvider((context) => ShellBloc());
        break;
    }

    return _getRoute(resultPage);
  }

  Route<dynamic> _getRoute(Widget widget, {RouteSettings settings}) {
    return MaterialPageRoute(
      builder: (_) => widget,
      settings: settings,
    );
  }
}
