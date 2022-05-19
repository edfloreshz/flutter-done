import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macos_ui/macos_ui.dart';

import '../../providers/navigation.dart';

class MacApp extends ConsumerWidget {
  const MacApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MacosApp(
      title: 'Done',
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const Content(),
    );
  }
}

class Content extends ConsumerStatefulWidget {
  const Content({Key? key}) : super(key: key);

  @override
  ConsumerState<Content> createState() => _ContentState();
}

class _ContentState extends ConsumerState<Content> {
  @override
  void initState() {
    super.initState();
    // "ref" can be used in all life-cycles of a StatefulWidget.
    ref.read(navigationProvider);
  }

  @override
  Widget build(BuildContext context) {
    final selectedItem = ref.watch(navigationProvider);
    final pages = ref.watch(pagesProvider);

    return PlatformMenuBar(
      menus: const [
        PlatformMenu(label: "Done", menus: [
          PlatformProvidedMenuItem(type: PlatformProvidedMenuItemType.about),
          PlatformProvidedMenuItem(type: PlatformProvidedMenuItemType.quit),
        ]),
      ],
      body: MacosWindow(
        sidebar: Sidebar(
          top: MacosSearchField(
            placeholder: "Search",
            onResultSelected: (result) {
              switch (result.searchKey) {
                case "Home":
                  ref.read(navigationProvider.notifier).update(
                      (state) => state = NavBarItem.values.elementAt(0));
                  break;
                case "Me":
                  ref.read(navigationProvider.notifier).update(
                      (state) => state = NavBarItem.values.elementAt(1));
                  break;
                default:
              }
            },
            results: const [
              SearchResultItem('Home'),
              SearchResultItem('Me'),
            ],
          ),
          minWidth: 200,
          builder: (context, controller) {
            return SidebarItems(
              currentIndex: selectedItem.index,
              onChanged: (i) => ref
                  .read(navigationProvider.notifier)
                  .update((state) => state = NavBarItem.values.elementAt(i)),
              scrollController: controller,
              items: const [
                SidebarItem(
                  leading: MacosIcon(CupertinoIcons.home),
                  label: Text('Home'),
                ),
                SidebarItem(
                  leading: MacosIcon(CupertinoIcons.person),
                  label: Text('Me'),
                ),
              ],
            );
          },
          bottom: const MacosListTile(
            leading: MacosIcon(CupertinoIcons.profile_circled),
            title: Text('Tim Apple'),
            subtitle: Text('tim@apple.com'),
          ),
        ),
        child: IndexedStack(
          index: selectedItem.index,
          children: pages,
        ),
      ),
    );
  }
}
