import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:obramat/models/product.dart';
import 'package:obramat/models/projects.dart';
import 'package:obramat/providers/cart_provider.dart';
import 'package:obramat/providers/project_provider.dart';
import 'package:obramat/utils/colors.dart';
import 'package:obramat/widgets/appbar.dart';

class ProjectDetailScreen extends ConsumerWidget {
  final String projectId;
  const ProjectDetailScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectByIdProvider(projectId));

    if (project == null) {
      return Scaffold(
        appBar: AppBarWidget(title: 'Proyecto'),
        body: Center(child: Text('Proyecto no encontrado')),
      );
    }

    return Scaffold(
      appBar: AppBarWidget(
        title: 'OBRAMAT',
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share_outlined, color: AppColors.primaryColor),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined,
                color: AppColors.primaryColor),
            onPressed: () => context.go('/cart'),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'IMPORTE FINAL DE LA LISTA',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.grey[500],
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '€${project.totalProject.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'IVA Inc.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // 👈 añade todos los materiales del proyecto al carrito
                  for (final material in project.materials) {
                    final product = Product(
                      id: '${project.id}-${material.ref}',
                      name: material.name,
                      category: 'PROJECT MATERIAL',
                      ref: material.ref,
                      brand: material.brand,
                      price: material.unitPrice,
                      images: [material.image],
                      inStock: material.inStock,
                      stockUnits: 0,
                      rating: 0,
                      reviews: 0,
                      description: '',
                      features: [],
                      specs: {},
                    );
                    ref.read(cartProvider.notifier).addProduct(
                      product,
                      quantity: material.quantity,
                    );
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Materiales añadidos al carrito'),
                      backgroundColor: AppColors.primaryColor,
                    ),
                  );
                  context.go('/cart');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined,
                        color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'AÑADIR TODO\nAL CARRITO',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        fontSize: 14,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'LISTA DE MATERIALES',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500],
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 4),
              Text(
                project.name,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'ID: ${project.id}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _statusLabel(project.status ),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Botón exportar PDF
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.picture_as_pdf_outlined,
                        color: AppColors.primaryColor, size: 24),
                    SizedBox(width: 12),
                    Text(
                      'EXPORTAR PRESUPUESTO A PDF',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Grid de estadísticas 2x2
              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      label: 'TOTAL ARTÍCULOS',
                      value: '${project.totalArticles}',
                      isHighlight: false,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _statCard(
                      label: 'BASE IMPONIBLE',
                      value: '€${project.baseImponible.toStringAsFixed(2)}',
                      isHighlight: false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      label: 'IVA (21%)',
                      value: '€${project.tax.toStringAsFixed(2)}', 
                      isHighlight: false,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _statCard(
                      label: 'TOTAL PROYECTO',
                      value: '€${project.totalProject.toStringAsFixed(2)}',
                      isHighlight: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
               if (project.materials.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey[300]),
                        SizedBox(height: 16),
                        Text('Aún no hay materiales en este proyecto', style: TextStyle(color: Colors.grey[500])),
                      ],
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: project.materials.length, // 👈
                  itemBuilder: (context, index) => _materialCard(project.materials[index]), // 👈
                ),
             
            ],
          ),
        ),
      ),
    );
  }

  String _statusLabel(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.active:
        return 'EN PROGRESO';
      case ProjectStatus.pending:
        return 'PENDIENTE';
      case ProjectStatus.completed:
        return 'COMPLETADO';
    }
  }

  Widget _statCard({required String label, required String value, required bool isHighlight}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isHighlight ? AppColors.primaryColor : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isHighlight ? Colors.white70 : Colors.grey[500], letterSpacing: 1.2)),
          SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: isHighlight ? Colors.white : Colors.black)),
        ],
      ),
    );
  }

  Widget _materialCard(ProjectMaterial material) { // 👈 recibe ProjectMaterial
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(material.image, width: 70, height: 70, fit: BoxFit.cover), // 👈
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(material.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)), // 👈
                    SizedBox(height: 4),
                    Text('REF: ${material.ref} • ${material.brand}', style: TextStyle(fontSize: 12, color: Colors.grey[500])), // 👈
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: material.inStock ? Colors.green[50] : Colors.red[50],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        material.inStock ? 'STOCK DISPONIBLE' : 'SIN STOCK EN ALMACÉN',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: material.inStock ? Colors.green[700] : Colors.red[700]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Icon(Icons.remove, size: 16, color: Colors.black87),
                    SizedBox(width: 16),
                    Text('${material.quantity}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), // 👈
                    SizedBox(width: 16),
                    Icon(Icons.add, size: 16, color: Colors.black87),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text('PRECIO UNIT.', style: TextStyle(fontSize: 10, color: Colors.grey[500], fontWeight: FontWeight.bold)),
                      SizedBox(width: 16),
                      Text('SUBTOTAL', style: TextStyle(fontSize: 10, color: Colors.grey[500], fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text('€${material.unitPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 14, color: Colors.grey[600])), // 👈
                      SizedBox(width: 16),
                      Text('€${material.subtotal.toStringAsFixed(2)}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.primaryColor)), // 👈
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
