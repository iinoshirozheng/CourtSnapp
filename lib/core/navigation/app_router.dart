import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:project/features/court_finder/presentation/pages/court_details_page.dart';
import 'package:project/features/court_finder/presentation/pages/court_finder_page.dart';
import 'package:project/features/auth/presentation/pages/login_page.dart';
import 'package:project/features/auth/presentation/pages/welcome_page.dart';

@singleton
class AppRouter {
  final GoRouter router = GoRouter(
    initialLocation: '/courts', // Bypass using '/courts'
    routes: [
      GoRoute(
        path: '/',
        name: 'welcome',
        builder:
            (context, state) => WelcomePage(
              toggleTheme: () {}, // This will be handled by a BLoC later
            ),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder:
            (context, state) => LoginPage(
              toggleTheme: () {}, // This will be handled by a BLoC later
            ),
      ),
      GoRoute(
        path: '/courts',
        name: 'courts',
        builder: (context, state) => const CourtFinderPage(),
      ),
      GoRoute(
        path: '/court-details',
        name: 'court-details',
        builder: (context, state) {
          final court = state.extra as Map<String, dynamic>;
          return CourtDetailsPage(court: court);
        },
      ),
    ],
  );
}
