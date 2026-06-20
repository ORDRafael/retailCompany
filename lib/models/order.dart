import 'package:obramat/models/cart_item.dart';

enum OrderStatus { inTransit, delivered, processing, cancelled }

class Order {
  final String id;
  final DateTime date;
  final List<CartItem> items;
  final double subtotal;
  final double shipping;
  final double tax;
  final double total;
  final OrderStatus status;
  final String deliveryAddress;
  final String deliveryType; // 'Express', 'Standard', etc.

  const Order({
    required this.id,
    required this.date,
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.total,
    required this.status,
    required this.deliveryAddress,
    required this.deliveryType,
  });

  int get totalArticles =>
      items.fold(0, (sum, item) => sum + item.quantity);
}