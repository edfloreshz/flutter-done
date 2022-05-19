import 'package:done_flutter/providers/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoneNavigationBar extends ConsumerStatefulWidget {
  const DoneNavigationBar({Key? key}) : super(key: key);

  @override
  ConsumerState<DoneNavigationBar> createState() => _DoneNavigationBarState();
}

class _DoneNavigationBarState extends ConsumerState<DoneNavigationBar> {
  @override
  void initState() {
    super.initState();
    // "ref" can be used in all life-cycles of a StatefulWidget.
    ref.read(navigationProvider);
  }

  @override
  Widget build(BuildContext context) {
    final selectedItem = ref.watch(navigationProvider);
    return NavigationBarTheme(
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
          NavigationDestination(icon: Icon(CupertinoIcons.home), label: "Home"),
          NavigationDestination(icon: Icon(CupertinoIcons.person), label: "Me"),
        ],
      ),
    );
  }
}
