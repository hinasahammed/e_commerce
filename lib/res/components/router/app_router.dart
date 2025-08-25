import 'package:e_commerce/model/subCategoryParameter/sub_catgeory_parameter.dart';
import 'package:e_commerce/view/cart/cart_view.dart';
import 'package:e_commerce/view/customNavigation/custom_navigation_view.dart';
import 'package:e_commerce/view/login/login_view.dart';
import 'package:e_commerce/view/myAdresses/my_adresses_view.dart';
import 'package:e_commerce/view/orders/orders_view.dart';
import 'package:e_commerce/view/register/register_view.dart';
import 'package:e_commerce/view/splash/splash_view.dart';
import 'package:e_commerce/view/subCategory/sub_category_view.dart';
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
      GoRoute(path: '/cart', builder: (context, state) => const CartView()),
      GoRoute(
        path: '/adress',
        builder: (context, state) => const MyAdressesView(),
      ),
      GoRoute(
        path: '/sub_category',
        builder: (context, state) =>
            SubCategoryView(parameter: state.extra as SubCatgeoryParameter),
      ),
    ],
  );
}
