class Product {
  final String id;
  final String name;
  final String category;
  final String ref;
  final String brand;
  final double price;
  final double? originalPrice; // precio tachado, puede ser null
  final List<String> images;
  final bool inStock;
  final int stockUnits;
  final double rating;
  final int reviews;
  final String description;
  final List<String> features; // bullets de product information
  final Map<String, String> specs; // especificaciones técnicas

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.ref,
    required this.brand,
    required this.price,
    this.originalPrice,
    required this.images,
    required this.inStock,
    required this.stockUnits,
    required this.rating,
    required this.reviews,
    required this.description,
    required this.features,
    required this.specs,
  });
}