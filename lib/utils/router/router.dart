// ボトムナビゲーションを非表示にしたいルートパスを指定

import 'package:go_router/go_router.dart';

import '../../features/home/home_page.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  // URLリクエストエラー時
  // errorBuilder: (context, state) {
  //   return const CommonErrorPage();
  // },

  /// ルート定義
  routes: [
    /// 起動動線
    GoRoute(
      name: HomePage.routeName,
      path: HomePage.routePath,
      builder: (_, __) => const HomePage(),
    ),

    // /// アプリホーム
    // GoRoute(
    //     name: SampleHomePage.routeName,
    //     path: SampleHomePage.routePath,
    //     pageBuilder: (context, state) => NoTransitionPage(
    //           key: state.pageKey,
    //           child: const SampleHomePage(),
    //         ),
    //     routes: [
    //       // ネストかつアニメーション込みの画面遷移
    //       GoRoute(
    //         name: SampleDetailPage.routeName,
    //         path: SampleDetailPage.routePath,
    //         pageBuilder: (context, state) => CustomTransitionPage(
    //           key: state.pageKey,
    //           child: const SampleDetailPage(),
    //           transitionDuration: const Duration(milliseconds: 300),
    //           transitionsBuilder:
    //               (context, animation, secondaryAnimation, child) {
    //             return SlideTransitionBuilder().buildTransitions(
    //               MaterialPageRoute(
    //                 builder: (context) => const SampleDetailPage(),
    //               ),
    //               context,
    //               animation,
    //               secondaryAnimation,
    //               child,
    //             );
    //           },
    //         ),
    //       ),
    //     ]),
  ],
);
