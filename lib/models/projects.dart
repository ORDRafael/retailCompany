class ProjectMaterial {
  final String name;
  final String ref;
  final String brand;
  final String image;
  final bool inStock;
  final int quantity;
  final double unitPrice;

  const ProjectMaterial({
    required this.name,
    required this.ref,
    required this.brand,
    required this.image,
    required this.inStock,
    required this.quantity,
    required this.unitPrice,
  });

  double get subtotal => unitPrice * quantity;
}

enum ProjectStatus { active, pending, completed }

class Project {
  final String id;
  final String name;
  final String address;
  final DateTime startDate;
  final double estimatedBudget;
  final String description;
  final ProjectStatus status;
  final String image;
  final List<ProjectMaterial> materials;

  const Project({
    required this.id,
    required this.name,
    required this.address,
    required this.startDate,
    required this.estimatedBudget,
    required this.description,
    required this.status,
    required this.image,
    required this.materials,
  });

  int get totalArticles =>
      materials.fold(0, (sum, m) => sum + m.quantity);

  double get baseImponible =>
      materials.fold(0.0, (sum, m) => sum + m.subtotal);

  double get tax => baseImponible * 0.21;

  double get totalProject => baseImponible + tax;

  Project copyWith({
    String? id,
    String? name,
    String? address,
    DateTime? startDate,
    double? estimatedBudget,
    String? description,
    ProjectStatus? status,
    String? image,
    List<ProjectMaterial>? materials,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      startDate: startDate ?? this.startDate,
      estimatedBudget: estimatedBudget ?? this.estimatedBudget,
      description: description ?? this.description,
      status: status ?? this.status,
      image: image ?? this.image,
      materials: materials ?? this.materials,
    );
  }
}