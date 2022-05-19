import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../views/home.dart';
import '../views/me.dart';

enum NavBarItem { home, chats, people, me }

final navigationProvider = StateProvider<NavBarItem>((ref) => NavBarItem.home);
final pagesProvider = StateProvider<List<Widget>>(
  (ref) => [
    const Home(),
    const Me(),
  ],
);
