import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:flutter_app/core/common/index.dart';
import 'package:flutter_app/core/services/index.dart';
import 'package:flutter_app/core/extensions/index.dart';
import 'package:flutter_app/core/blocs/index.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';
import 'core/extensions/index.dart';

// ignore: avoid_void_async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  DependencyService.registerServices();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      path: Assets.translations,
      fallbackLocale: const Locale('en'),
      child: RecipesApp().createWithMultiProvider(
        () => [
          BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(),
          ),
          BlocProvider<BookmarksBloc>(
            create: (_) => BookmarksBloc()..add(LoadBookmarks()),
          ),
        ],
      ),
    ),
  );
}

class RecipesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Recipes App',
      home: SplashScreen.callback(
        name: Assets.splashLoader,
        backgroundColor: Colors.white,
        onSuccess: (_) {
          context.bloc<AuthBloc>().add(AppStartedEvent());
        },
        onError: null,
        loopAnimation: RiveAnimations.loadingAnimation,
        until: () => Future.delayed(const Duration(seconds: 2)),
      ),
      navigatorKey: Get.key,
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
    );
  }
}
