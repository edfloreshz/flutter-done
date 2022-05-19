import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../navigation/navigation_bar.dart';
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
        bottomNavigationBar: const DoneNavigationBar(),
      ),
    );
  }
}
