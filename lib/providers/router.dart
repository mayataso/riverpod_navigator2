import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/pages/first.dart';
import 'package:riverpod_sample/pages/second.dart';
import 'package:riverpod_sample/pages/top.dart';
import 'package:riverpod_sample/utils/logger.dart';

final routerProvider = ChangeNotifierProvider(
  (ref) => _AppRouterDelegate(ref),
);

enum PageType { top, first, second }

// 今回の実装では AppRouterDelegate がリビルドされる可能性があるためグローバルに宣言
final _navigatorKey = GlobalKey<NavigatorState>();

class _AppRouterDelegate extends RouterDelegate<Empty> with ChangeNotifier, PopNavigatorRouterDelegateMixin<Empty> {
  _AppRouterDelegate(this.ref);

  @override
  final GlobalKey<NavigatorState>? navigatorKey = _navigatorKey;
  final ChangeNotifierProviderRef<_AppRouterDelegate> ref;
  PageType pageType = PageType.top;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        page(const TopPage()),
        if (pageType == PageType.first) page(const FirstPage()),
        if (pageType == PageType.second) page(const SecondPage())
      ],
      onPopPage: (route, result) {
        logger.info('onPop');
        pageType = PageType.top;

        return route.didPop(result);
      },
    );
  }

  void setPage(PageType type) {
    pageType = type;
    notifyListeners();
  }

  MaterialPage page(dynamic page) {
    return MaterialPage(child: page);
  }

  @override
  Future<void> setNewRoutePath(Empty configuration) async {}
}

class Empty {}
