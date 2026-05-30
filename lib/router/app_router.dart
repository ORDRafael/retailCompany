import 'package:go_router/go_router.dart';
import 'package:obramat/main_shell.dart';
import 'package:obramat/screens/cart.dart';
import 'package:obramat/screens/createProject.dart';
import 'package:obramat/screens/home.dart';
import 'package:obramat/screens/login.dart';
import 'package:obramat/screens/orderSucces.dart';
import 'package:obramat/screens/pedidos.dart';
import 'package:obramat/screens/perfil.dart';
import 'package:obramat/screens/product.dart';
import 'package:obramat/screens/projectDetail.dart';
import 'package:obramat/screens/projects.dart';
import 'package:obramat/screens/checkout.dart';
import 'package:obramat/screens/register.dart';
import 'package:obramat/screens/orderDetails.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const Home(),
        ),
        GoRoute(
          path: '/projects',
          builder: (context, state) => const Projects(),
        ),
        GoRoute(
          path: '/cart',
          builder: (context, state) => const CartScreen(),
        ),
        GoRoute(
          path: '/orders',
          builder: (context, state) => const OrdersScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/create-project',
          builder: (context, state) => const NewProjectScreen(),
        ),
        GoRoute(
          path: '/project-detail',
          builder: (context, state) => const ProjectDetailScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) => ProductScreen(),
    ),
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const CheckoutScreen(),
    ),
    GoRoute(
      path: '/order-success',
      builder: (context, state) => const OrderSuccessScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/order-details',
      builder: (context, state) => const OrderDetailScreen(),
    ),
  ],
);