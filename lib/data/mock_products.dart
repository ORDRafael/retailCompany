import 'package:obramat/models/product.dart';

final List<Product> mockProducts = [
  Product(
    id: '1',
    name: 'Portland Cement CEM II 42.5 R',
    category: 'BUILDING MATERIALS',
    ref: '08-9921-X',
    brand: 'HOLCIM',
    price: 14.48,
    originalPrice: null,
    images: [
      'lib/images/cement.png',
      'lib/images/cement2.png',
      'lib/images/cement3.png',
    ],
    inStock: true,
    stockUnits: 1240,
    rating: 4.5,
    reviews: 128,
    description:
        'Our Premium Portland Cement (CEM II 42.5 R) is engineered for versatile construction applications, offering superior early strength and excellent durability.',
    features: [
      'Optimized for cold weather concreting due to high hydration heat.',
      'Low alkali content to reduce alkali-silica reaction risks.',
      'Environmentally conscious production with reduced CO2 footprint.',
      'Breathable multi-wall moisture-resistant packaging.',
    ],
    specs: {
      'STRENGTH CLASS': '42.5 R (HIGH EARLY STRENGTH)',
      'WEIGHT': '25 Kg/Bag',
      'SETTING TIME': '160 MINUTES',
      'COMPLIANCE': 'EN 197-1',
    },
  ),
  Product(
    id: '2',
    name: 'Rotary Hammer Drill 800W HR2630',
    category: 'TOOLS',
    ref: '07-4412-H',
    brand: 'MAKITA',
    price: 145.95,
    originalPrice: 189.95,
    images: [
      'lib/images/taladro.png',
    ],
    inStock: true,
    stockUnits: 45,
    rating: 4.8,
    reviews: 256,
    description:
        'Professional rotary hammer drill with 800W motor, ideal for heavy-duty drilling and chiseling in concrete, masonry and stone.',
    features: [
      'SDS-Plus chuck system for quick bit changes.',
      'Three operation modes: drilling, hammer drilling and chiseling.',
      'Variable speed control for precise work.',
      'Anti-vibration system for reduced operator fatigue.',
    ],
    specs: {
      'POWER': '800W',
      'WEIGHT': '2.9 Kg',
      'IMPACT RATE': '4,500 bpm',
      'CHUCK': 'SDS-Plus',
    },
  ),
  Product(
    id: '3',
    name: 'Galvanized Steel Rebar 12mm x 6m',
    category: 'BUILDING MATERIALS',
    ref: '25102547',
    brand: 'ARCELORMITTAL',
    price: 24.95,
    originalPrice: null,
    images: [
      'lib/images/fontaneria.png',
    ],
    inStock: true,
    stockUnits: 320,
    rating: 4.2,
    reviews: 89,
    description:
        'High-quality galvanized steel rebar for reinforced concrete structures. Complies with EN 10080 standard.',
    features: [
      'Hot-dip galvanized for superior corrosion resistance.',
      'High ductility for seismic zones.',
      'Consistent diameter tolerance.',
      'Complies with EN 10080 and ISO 6935-2.',
    ],
    specs: {
      'DIAMETER': '12mm',
      'LENGTH': '6m',
      'GRADE': 'B500SD',
      'COMPLIANCE': 'EN 10080',
    },
  ),
];