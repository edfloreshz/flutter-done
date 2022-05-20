import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:done_flutter/providers/navigation.dart';
import 'package:flutter/cupertino.dart';
import '../../providers/navigation.dart';

class MaterialApplication extends ConsumerWidget {
  const MaterialApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(navigationProvider);
    final pages = ref.watch(pagesProvider);

    return MaterialApp(
      theme: null,
      home: Scaffold(
        body: pages[selectedItem.index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.blue.shade100,
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 12),
            ),
          ),
          child: NavigationBar(
            backgroundColor: const Color(0xFFf1f5fb),
            selectedIndex: selectedItem.index,
            onDestinationSelected: (index) => {
              ref
                  .read(navigationProvider.notifier)
                  .update((state) => state = NavBarItem.values.elementAt(index))
            },
            destinations: const [
              NavigationDestination(
                  icon: Icon(CupertinoIcons.home), label: "Home"),
              NavigationDestination(
                  icon: Icon(CupertinoIcons.person), label: "Me"),
            ],
          ),
        ),
      ),
    );
  }
}
