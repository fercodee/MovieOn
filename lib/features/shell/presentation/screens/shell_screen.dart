import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:move_on/features/home/presentation/screens/home_screen.dart';
import 'package:move_on/features/library/presentation/screens/library_screen.dart';
import 'package:move_on/features/library/presentation/viewmodels/library_view_model.dart';

class ShellScreen extends ConsumerStatefulWidget {
  const ShellScreen({super.key});

  @override
  ConsumerState<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends ConsumerState<ShellScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    const pages = [HomeScreen(), LibraryScreen()];

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Catalogo',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_outline_rounded),
            selectedIcon: Icon(Icons.bookmark_rounded),
            label: 'Biblioteca',
          ),
        ],
        onDestinationSelected: (index) {
          setState(() => _index = index);

          if (index == 1) {
            ref.invalidate(libraryViewModelProvider);
          }
        },
      ),
    );
  }
}
