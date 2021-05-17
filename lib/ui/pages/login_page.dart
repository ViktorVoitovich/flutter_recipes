import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/blocs/index.dart';

import 'package:flutter_app/generated/locale_keys.g.dart';
import 'package:flutter_app/ui/widgets/index.dart';
import 'package:flutter_app/core/extensions/index.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.bloc<AuthBloc>().add(ResetFormEvent());
  }

  @override
  void dispose() {
    _emailFieldController.dispose();
    _passwordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: BottomPanel(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30.0),
                Text(
                  LocaleKeys.login.tr(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30.0),
                _buildLoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return FormWithButton(
      buttonTitle: LocaleKeys.login.tr(),
      onPressed: () {
        context.bloc<AuthBloc>().add(LoginPressedEvent(
              email: _emailFieldController.text,
              password: _passwordFieldController.text,
            ));
      },
      children: [
        _buildEmailField(),
        const SizedBox(height: 5.0),
        _buildPasswordField(),
        _buildForgotPasswordButton(),
        const SizedBox(height: 41.0),
      ],
    );
  }

  Widget _buildEmailField() {
    return InputField(
      controller: _emailFieldController,
      hintText: LocaleKeys.email.tr(),
      prefixIcon: const Icon(Icons.email),
      validator: (_) {
        return context.bloc<AuthBloc>().isEmailValid
            ? null
            : LocaleKeys.invalid_email.tr();
      },
      onChanged: (email) {
        context.bloc<AuthBloc>().add(EmailChangedEvent(email: email));
      },
    );
  }

  Widget _buildPasswordField() {
    return InputField(
      controller: _passwordFieldController,
      hintText: LocaleKeys.password.tr(),
      prefixIcon: Transform.rotate(
        angle: -pi / 4.0,
        child: const Icon(Icons.vpn_key),
      ),
      validator: (_) {
        return context.bloc<AuthBloc>().isPasswordValid
            ? null
            : LocaleKeys.invalid_password.tr();
      },
      onChanged: (password) {
        context.bloc<AuthBloc>().add(PasswordChangedEvent(password: password));
      },
    );
  }

  Widget _buildForgotPasswordButton() {
    return Row(
      children: [
        const Spacer(),
        Opacity(
          opacity: 0.5,
          child: TextButton(
            onPressed: () => print('forgot password'),
            child: Text(
              LocaleKeys.forgot_password.tr(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
          ),
        ),
        const SizedBox(width: 30.0),
      ],
    );
  }
}
