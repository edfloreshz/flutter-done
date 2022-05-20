import 'package:done_flutter/apps/windows/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import '../../main.dart';
import '../../providers/navigation.dart';

class FluentApplication extends ConsumerWidget {
  const FluentApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(navigationProvider);
    final pages = ref.watch(pagesProvider);
    final appTheme = ref.watch(themeProvider);
    final viewKey = GlobalKey();

    return FluentApp(
      title: appTitle,
      themeMode: appTheme.mode,
      color: appTheme.color,
      theme: ThemeData(
        accentColor: appTheme.color,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen() ? 2.0 : 0.0,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: appTheme.color,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen() ? 2.0 : 0.0,
        ),
      ),
      home: NavigationView(
        key: viewKey,
        appBar: NavigationAppBar(
          automaticallyImplyLeading: false,
          title: () {
            if (kIsWeb) return const Text(appTitle);
            return const DragToMoveArea(
              child: Align(
                alignment: AlignmentDirectional.center,
                child: Text(appTitle),
              ),
            );
          }(),
          actions: kIsWeb
              ? null
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [Spacer(), WindowButtons()],
                ),
        ),
        pane: NavigationPane(
          selected: selectedItem.index,
          onChanged: (index) => ref
              .read(navigationProvider.notifier)
              .update((state) => state = NavBarItem.values.elementAt(index)),
          size: const NavigationPaneSize(
            openMinWidth: 250,
            openMaxWidth: 320,
          ),
          header: Container(
            height: kOneLineTileHeight,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: FlutterLogo(
              style: appTheme.displayMode == PaneDisplayMode.top
                  ? FlutterLogoStyle.markOnly
                  : FlutterLogoStyle.horizontal,
              size: appTheme.displayMode == PaneDisplayMode.top ? 24 : 100.0,
            ),
          ),
          displayMode: appTheme.displayMode,
          indicator: () {
            switch (appTheme.indicator) {
              case NavigationIndicators.end:
                return const EndNavigationIndicator();
              case NavigationIndicators.sticky:
              default:
                return const StickyNavigationIndicator();
            }
          }(),
          items: [
            PaneItem(
              icon: const Icon(FluentIcons.home),
              title: const Text("Home"),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.people),
              title: const Text("Me"),
            )
          ],
        ),
        content: NavigationBody(
          index: selectedItem.index,
          children: pages,
        ),
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: appTheme.textDirection,
          child: NavigationPaneTheme(
            data: NavigationPaneThemeData(
              backgroundColor:
                  appTheme.windowEffect != flutter_acrylic.WindowEffect.disabled
                      ? Colors.transparent
                      : null,
            ),
            child: child!,
          ),
        );
      },
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
