import 'package:go_router/go_router.dart';
import 'package:obramat/main_shell.dart';
import 'package:obramat/screens/cart.dart';
import 'package:obramat/screens/home.dart';
import 'package:obramat/screens/pedidos.dart';
import 'package:obramat/screens/perfil.dart';
import 'package:obramat/screens/placeholder.dart';
import 'package:obramat/screens/product.dart';
import 'package:obramat/screens/projects.dart';


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
          path: '/checkout',
          builder: (context, state) => const PlaceholderScreen(title: 'Checkout'),
        ),
        GoRoute(
          path: '/product/:id',
          builder: (context, state) => ProductScreen(),
        ),
      ],
    ),
  ],
);