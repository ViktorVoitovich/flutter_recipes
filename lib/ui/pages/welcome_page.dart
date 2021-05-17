import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/core/blocs/index.dart';
import 'package:flutter_app/generated/locale_keys.g.dart';
import 'package:flutter_app/ui/widgets/index.dart';
import 'package:flutter_app/core/extensions/index.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 200.0),
              _buildWelcomeMessage(),
              const Spacer(),
              _buildLoginButton(context: context),
              const SizedBox(height: 30.0),
              _buildSignUpButton(context: context),
              const SizedBox(height: 80.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeMessage() {
    return const Text(
      LocaleKeys.welcome,
      style: TextStyle(
        fontSize: 35.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ).tr();
  }

  Widget _buildLoginButton({
    @required BuildContext context,
  }) {
    return RoundedButton(
      title: LocaleKeys.login.tr().toUpperCase(),
      onPressed: () => context.bloc<WelcomeBloc>().add(TapOnLoginButtonEvent()),
      textColor: Colors.white,
      backgroundColor: Colors.red,
      width: 350.0,
      height: 60.0,
    );
  }

  Widget _buildSignUpButton({
    @required BuildContext context,
  }) {
    return RoundedButton(
      title: LocaleKeys.sign_up.tr().toUpperCase(),
      onPressed: () =>
          context.bloc<WelcomeBloc>().add(TapOnSignUpButtonEvent()),
      textColor: Colors.red,
      backgroundColor: Colors.white,
      width: 350.0,
      height: 60.0,
    );
  }
}
