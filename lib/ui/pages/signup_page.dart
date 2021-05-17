import 'dart:math';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_app/core/blocs/index.dart';

import 'package:flutter_app/generated/locale_keys.g.dart';
import 'package:flutter_app/ui/index.dart';
import 'package:flutter_app/core/extensions/index.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  final _userNameFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.bloc<AuthBloc>().add(ResetFormEvent());
  }

  @override
  void dispose() {
    _emailFieldController.dispose();
    _passwordFieldController.dispose();
    _userNameFieldController.dispose();
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
                  LocaleKeys.sign_up.tr(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30.0),
                _buildSignUpForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpForm() {
    return FormWithButton(
      buttonTitle: LocaleKeys.sign_up.tr(),
      onPressed: () {
        context.bloc<AuthBloc>().add(SignupPressedEvent(
              email: _emailFieldController.text,
              password: _passwordFieldController.text,
              userName: _userNameFieldController.text,
            ));
      },
      children: [
        _buildUserNameField(),
        const SizedBox(height: 2.0),
        _buildEmailField(),
        const SizedBox(height: 2.0),
        _buildPasswordField(),
        const SizedBox(height: 20.0),
      ],
    );
  }

  Widget _buildUserNameField() {
    return InputField(
      controller: _userNameFieldController,
      hintText: LocaleKeys.user_name.tr(),
      prefixIcon: const Icon(Icons.person),
      validator: (_) {
        return context.bloc<AuthBloc>().isUserNameValid
            ? null
            : LocaleKeys.invalid_user_name.tr();
      },
      onChanged: (userName) {
        context.bloc<AuthBloc>().add(UserNameChangedEvent(userName: userName));
      },
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
}
