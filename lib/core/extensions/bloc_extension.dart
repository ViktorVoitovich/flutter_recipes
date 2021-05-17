import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BlocExtension on BuildContext {
  T bloc<T extends BlocBase<Object>>() => BlocProvider.of<T>(this);
}

extension BlocProviderWrapper on Widget {
  Widget createWithProvider<T extends BlocBase<Object>>(
      T Function(BuildContext context) createBloc,
      {Key key}) {
    return BlocProvider(
      create: createBloc,
      key: key,
      child: this,
    );
  }

  Widget createWithMultiProvider(
    List<BlocProvider> Function() createBlocs, {
    Key key,
  }) {
    return MultiBlocProvider(
      providers: createBlocs(),
      key: key,
      child: this,
    );
  }
}
