import 'package:go_router/go_router.dart';
import 'package:thing_easy/screens/home_screen.dart';
import 'package:thing_easy/screens/today_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: "/home",
    routes: [
      GoRoute(
        path: "/home",
        name: "/home",
        builder: (context, state) => HomeScreen(),
      ),

      GoRoute(
        path: "/today",
        name: "/today",
        builder: (context, state) {
          final map = state.extra as Map;
          return TodayScreen(
            todayTasks: map["todayTasks"],
            pendingTasks: map["pendingTasks"],
          );
        },
      ),
    ],
  );
}
