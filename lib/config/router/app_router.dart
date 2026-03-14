import 'dart:ffi';

import 'package:cinemapedia/presentation/views/home_views/favorites_view.dart';
import 'package:cinemapedia/presentation/views/movies/homeview_view.dart';
import 'package:go_router/go_router.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
        path: '/home/:page',
        name: HomeScreen.name,
        builder: (context, state) {
          final pageIndex = state.pathParameters['page'] ?? '0';
          return HomeScreen(pageIndex: int.parse(pageIndex));
        },
        routes: [
          GoRoute(
              path: 'movie/:id',
              name: MovieScreen.name,
              builder: (context, state) {
                final id = state.pathParameters['id'] ?? 'no-id';
                return MovieScreen(movieId: id);
              }),
        ]),
    GoRoute(
      path: "/",
      redirect: (_, __) => "/home/0",
    )
  ],
);



// final appRouter = GoRouter(
//   initialLocation: '/',
//   routes: [
//     ShellRoute(
//         builder: (context, state, child) {
//           return HomeScreen(childView: child);
//         },
//         routes: [
//           GoRoute(
//               path: "/",
//               builder: (context, state) {
//                 return HomeView();
//               },
//               routes: [
//                 GoRoute(
//                     path: 'movie/:id',
//                     name: MovieScreen.name,
//                     builder: (context, state) {
//                       final id = state.pathParameters['id'] ?? 'no-id';
//                       return MovieScreen(movieId: id);
//                     }),
//               ]),
//         GoRoute(path: "/favorites",
//         builder: (context, state) => FavoritesView(),
//         )
//         ]),

    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (context, state) => HomeScreen(),
    //   routes: [
    // GoRoute(
    //     path: 'movie/:id',
    //     name: MovieScreen.name,
    //     builder: (context, state) {
    //       final id = state.pathParameters['id'] ?? 'no-id';
    //       return MovieScreen(movieId: id);
    //     }),

    //   ]
    // ),
//   ],
// );
