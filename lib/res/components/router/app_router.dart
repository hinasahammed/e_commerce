import 'package:e_commerce/view/customNavigation/custom_navigation_view.dart';
import 'package:e_commerce/view/login/login_view.dart';
import 'package:e_commerce/view/orders/orders_view.dart';
import 'package:e_commerce/view/register/register_view.dart';
import 'package:e_commerce/view/splash/splash_view.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(path: '/login', builder: (context, state) => const LoginView()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: '/custom_navigation',
        builder: (context, state) => const CustomNavigationView(),
      ),
      GoRoute(path: '/orders', builder: (context, state) => const OrdersView()),
    ],
  );
}
