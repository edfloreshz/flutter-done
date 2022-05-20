import 'package:adwaita/adwaita.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:libadwaita_bitsdojo/libadwaita_bitsdojo.dart';

import '../../providers/navigation.dart';

class LinuxApplication extends ConsumerWidget {
  const LinuxApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(navigationProvider);
    final pages = ref.watch(pagesProvider);

    return MaterialApp(
      theme: AdwaitaThemeData.light(),
      darkTheme: AdwaitaThemeData.dark(),
      home: AdwScaffold(
        start: const [
          AdwHeaderButton(icon: Icon(Icons.view_sidebar_outlined, size: 19)),
        ],
        actions: AdwActions().bitsdojo,
        title: const Text("Done"),
        flap: (isDrawer) => AdwSidebar(
            currentIndex: selectedItem.index,
            isDrawer: isDrawer,
            onSelected: (index) => {
                  ref.read(navigationProvider.notifier).update(
                      (state) => state = NavBarItem.values.elementAt(index))
                },
            children: const [
              AdwSidebarItem(label: "Home"),
              AdwSidebarItem(label: "Me"),
            ]),
        body: AdwViewStack(
          animationDuration: const Duration(milliseconds: 100),
          index: selectedItem.index,
          children: pages,
        ),
      ),
    );
  }
}
