import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:obramat/data/mock_products.dart';
import 'package:obramat/models/product.dart';

// Provider de la lista completa de productos
final productsProvider = Provider<List<Product>>((ref) {
  return mockProducts;
});

// Provider de un producto por ID
final productByIdProvider = Provider.family<Product?, String>((ref, id) {
  final products = ref.watch(productsProvider);
  try {
    return products.firstWhere((p) => p.id == id);
  } catch (e) {
    return null;
  }
});

// Provider de productos por categoría
final productsByCategoryProvider =
    Provider.family<List<Product>, String>((ref, category) {
  final products = ref.watch(productsProvider);
  return products.where((p) => p.category == category).toList();
});

// Provider de best sellers (mock — los primeros 3)
final bestSellersProvider = Provider<List<Product>>((ref) {
  final products = ref.watch(productsProvider);
  return products.take(3).toList();
});