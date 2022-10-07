// // ボトムナビゲーションを非表示にしたいルートパスを指定
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:layer_architecture_template/presentation/error/error_page.dart';

// import '../../presentation/sample/sample_home_page.dart';
// import '../../presentation/sample_detail/sample_detail_page.dart';
// import '../../presentation/splash/splash_page.dart';
// import 'slide_transitions_builder.dart';

// const denyShowBNBList = [
//   SplashPage.routePath,
// ];

// final router = GoRouter(
//   debugLogDiagnostics: true,
//   initialLocation: SplashPage.routePath,
//   // URLリクエストエラー時
//   errorBuilder: (context, state) {
//     return const CommonErrorPage();
//   },

//   /// ルート定義
//   routes: [
//     /// 起動動線
//     GoRoute(
//       name: SplashPage.routeName,
//       path: SplashPage.routePath,
//       builder: (_, __) => const SplashPage(),
//     ),

//     /// アプリホーム
//     GoRoute(
//         name: SampleHomePage.routeName,
//         path: SampleHomePage.routePath,
//         pageBuilder: (context, state) => NoTransitionPage(
//               key: state.pageKey,
//               child: const SampleHomePage(),
//             ),
//         routes: [
//           // ネストかつアニメーション込みの画面遷移
//           GoRoute(
//             name: SampleDetailPage.routeName,
//             path: SampleDetailPage.routePath,
//             pageBuilder: (context, state) => CustomTransitionPage(
//               key: state.pageKey,
//               child: const SampleDetailPage(),
//               transitionDuration: const Duration(milliseconds: 300),
//               transitionsBuilder:
//                   (context, animation, secondaryAnimation, child) {
//                 return SlideTransitionBuilder().buildTransitions(
//                   MaterialPageRoute(
//                     builder: (context) => const SampleDetailPage(),
//                   ),
//                   context,
//                   animation,
//                   secondaryAnimation,
//                   child,
//                 );
//               },
//             ),
//           ),
//         ]),
//   ],
// );
