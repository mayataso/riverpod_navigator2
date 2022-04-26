import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_sample/providers/router.dart';

class TopPage extends ConsumerWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod + Navigator2.0'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(routerProvider).setPage(PageType.first);
              },
              child: const Text('Go First Page'),
            ),
            const Gap(20),
            ElevatedButton(
              onPressed: () {
                ref.read(routerProvider).setPage(PageType.second);
              },
              child: const Text('Go Second Page'),
            ),
          ],
        ),
      ),
    );
  }
}
