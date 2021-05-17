import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/core/blocs/index.dart';
import 'package:flutter_app/generated/locale_keys.g.dart';
import 'package:flutter_app/ui/pages/index.dart';
import 'package:flutter_app/core/extensions/index.dart';

class ShellPage extends StatefulWidget {
  @override
  _ShellPageState createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShellBloc, ShellState>(
      builder: (context, shellState) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: IndexedStack(
            index: context.bloc<ShellBloc>().selectedIndex,
            children: [
              HomePage(),
              const SizedBox(),
              BookmarksPage(),
            ],
          ),
          bottomNavigationBar: _buildBottomNavigation(),
        );
      },
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      elevation: 0.0,
      currentIndex: context.bloc<ShellBloc>().selectedIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        context.bloc<ShellBloc>().add(SelectBarItemEvent(index: index));
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: LocaleKeys.home.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.search),
          label: LocaleKeys.search.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.bookmark_border),
          label: LocaleKeys.saves.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: LocaleKeys.profile.tr(),
        ),
      ],
    );
  }
}
