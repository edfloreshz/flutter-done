import 'dart:io';

import 'package:done_flutter/apps/macos/app.dart';
import 'package:done_flutter/apps/material/app.dart';
import 'package:done_flutter/providers/navigation.dart';
import 'package:done_flutter/views/home.dart';
import 'package:done_flutter/views/me.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'navigation/navigation_bar.dart';
import 'package:macos_ui/macos_ui.dart' as mac;
import 'package:fluent_ui/fluent_ui.dart' as fluent;

void main() => runApp(const ProviderScope(child: Done()));

class Done extends ConsumerStatefulWidget {
  const Done({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DoneState();
}

class _DoneState extends ConsumerState<Done> {
  @override
  void initState() {
    super.initState();
    // "ref" can be used in all life-cycles of a StatefulWidget.
    ref.read(navigationProvider);
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isMacOS) {
      return const MacApp();
    } else if (Platform.isWindows) {
      return fluent.FluentApp(
        theme: fluent.ThemeData(
          visualDensity: VisualDensity.standard,
          focusTheme: fluent.FocusThemeData(
            glowFactor: fluent.is10footScreen() ? 2.0 : 0.0,
          ),
        ),
        darkTheme: fluent.ThemeData(
          brightness: Brightness.dark,
          visualDensity: VisualDensity.standard,
          focusTheme: fluent.FocusThemeData(
            glowFactor: fluent.is10footScreen() ? 2.0 : 0.0,
          ),
        ),
        home: const Scaffold(
          // body: pages[selectedItem.index],
          bottomNavigationBar: DoneNavigationBar(),
        ),
      );
    } else {
      return const MaterialApplication();
    }
  }
}
