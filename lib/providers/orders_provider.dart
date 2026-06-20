import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:obramat/models/cart_item.dart';
import 'package:obramat/models/order.dart';

class OrdersNotifier extends StateNotifier<List<Order>> {
  OrdersNotifier() : super(_initialOrders);

  // Pedidos mock iniciales para que Orders no empiece vacío
  static final List<Order> _initialOrders = [];

  void createOrder({
    required List<CartItem> items,
    required double subtotal,
    required double shipping,
    required double tax,
    required double total,
    required String deliveryAddress,
    required String deliveryType,
  }) {
    final newOrder = Order(
      id: 'OB-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      date: DateTime.now(),
      items: items,
      subtotal: subtotal,
      shipping: shipping,
      tax: tax,
      total: total,
      status: OrderStatus.processing,
      deliveryAddress: deliveryAddress,
      deliveryType: deliveryType,
    );
    state = [newOrder, ...state]; // el más nuevo primero
  }
}

final ordersProvider =
    StateNotifierProvider<OrdersNotifier, List<Order>>((ref) {
  return OrdersNotifier();
});

final orderByIdProvider = Provider.family<Order?, String>((ref, id) {
  final orders = ref.watch(ordersProvider);
  try {
    return orders.firstWhere((o) => o.id == id);
  } catch (e) {
    return null;
  }
});