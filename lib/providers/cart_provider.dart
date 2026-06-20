import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:obramat/models/cart_item.dart';
import 'package:obramat/models/product.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  // Añadir producto al carrito
  void addProduct(Product product, {int quantity = 1}) {
    final existingIndex =
        state.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      // Ya existe — aumenta la cantidad
      final updatedItem = state[existingIndex].copyWith(
        quantity: state[existingIndex].quantity + quantity,
      );
      state = [
        ...state.sublist(0, existingIndex),
        updatedItem,
        ...state.sublist(existingIndex + 1),
      ];
    } else {
      // No existe — lo añade nuevo
      state = [...state, CartItem(product: product, quantity: quantity)];
    }
  }

  // Actualizar cantidad de un item
  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeProduct(productId);
      return;
    }
    state = [
      for (final item in state)
        if (item.product.id == productId)
          item.copyWith(quantity: quantity)
        else
          item,
    ];
  }

  // Incrementar cantidad
  void incrementQuantity(String productId) {
    final item = state.firstWhere((item) => item.product.id == productId);
    updateQuantity(productId, item.quantity + 1);
  }

  // Decrementar cantidad
  void decrementQuantity(String productId) {
    final item = state.firstWhere((item) => item.product.id == productId);
    updateQuantity(productId, item.quantity - 1);
  }

  // Eliminar producto del carrito
  void removeProduct(String productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  // Vaciar carrito completo
  void clearCart() {
    state = [];
  }
}

// Provider principal del carrito
final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

// Provider derivado — cantidad total de items
final cartItemCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0, (sum, item) => sum + item.quantity);
});

// Provider derivado — subtotal del carrito
final cartSubtotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0.0, (sum, item) => sum + item.subtotal);
});