import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:obramat/models/projects.dart';
import 'package:obramat/providers/project_provider.dart';
import 'package:obramat/utils/colors.dart';
import 'package:obramat/widgets/appbar.dart';

class Projects extends ConsumerStatefulWidget {
  const Projects({super.key});

  @override
  ConsumerState<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends ConsumerState<Projects> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allProjects = ref.watch(projectsProvider);
    final activeProjects = ref.watch(projectsByStatusProvider(ProjectStatus.active));
    final pendingProjects = ref.watch(projectsByStatusProvider(ProjectStatus.pending));
    final totalInvestment = ref.watch(totalInvestmentProvider);
    return Scaffold(
      appBar: AppBarWidget(title: 'MY PROJECTS'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GESTION PROFESIONAL',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'MIS PROYECTOS',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add_circle_outline),
                    label: const Text('CREAR PROYECTO', style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      context.push('/create-project');
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // TabBar con chips estilo imagen
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicator: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black87,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  tabs: [
                    Tab(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Text('TODOS (${allProjects.length})'),
                      ),
                    ),
                    Tab(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text('ACTIVOS (${activeProjects.length})'),
                      ),
                    ),
                    Tab(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text('PENDIENTES (${pendingProjects.length})'),
                      ),
                    ),
                  ],
                ),
                

              ],
            ),
          ),
          // TabBarView ocupa el resto
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildProjectsList(allProjects, totalInvestment),
                _buildProjectsList(activeProjects,
                    activeProjects.fold(0.0, (sum, p) => sum + p.totalProject)),
                _buildProjectsList(pendingProjects,
                    pendingProjects.fold(0.0, (sum, p) => sum + p.totalProject)),
              ],
            ),
          ),
          
        ],
      ),
    );
  }

 Widget _buildProjectsList(List<Project> projects, double totalInvestment) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (projects.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.folder_off_outlined,
                        size: 64, color: Colors.grey[300]),
                    SizedBox(height: 16),
                    Text('No hay proyectos en esta categoría',
                        style: TextStyle(color: Colors.grey[500])),
                  ],
                ),
              ),
            )
          else
           ...projects.map((project) => projectCard(project)), // 👈 ya no necesita GestureDetector extra
        proFooter(totalInversion: '€${totalInvestment.toStringAsFixed(2)}'),
        ],
      ),
    );
  }

    Color _statusColor(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.active:
        return Colors.green;
      case ProjectStatus.pending:
        return Colors.orange;
      case ProjectStatus.completed:
        return Colors.grey;
    }
  }

  String _statusLabel(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.active:
        return 'ACTIVO';
      case ProjectStatus.pending:
        return 'PENDIENTE';
      case ProjectStatus.completed:
        return 'COMPLETADO';
    }
  }
  
  Widget proFooter({required String totalInversion}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 24),
      const Divider(),
      const SizedBox(height: 16),
      Text(
        'Optimiza tu logística',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      Text(
        'Asocia tus compras a proyectos específicos para un control de costes profesional. Genera facturas por obra y gestiona el stock por ubicación.',
        style: TextStyle(color: Colors.grey[600]),
      ),
      const SizedBox(height: 16),
      Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 18),
          const SizedBox(width: 6),
          Text('PRESUPUESTOS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(width: 16),
          Icon(Icons.check_circle, color: Colors.green, size: 18),
          const SizedBox(width: 6),
          Text('FACTURACIÓN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'INVERSIÓN TOTAL PROYECTOS',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.grey[500],
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              totalInversion, // 👈 varía según el tab
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
    ],
  );
}
  Widget projectCard(Project project) {
    return GestureDetector(
      onTap: () => context.push('/project/${project.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200]!,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header — icono + badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.folder_outlined, color: AppColors.primaryColor),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _statusColor(project.status).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _statusLabel(project.status),
                      style: TextStyle(
                        color: _statusColor(project.status),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Nombre del proyecto
              Text(
                project.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.grey[200]),
              const SizedBox(height: 8),
              // Materiales y presupuesto
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MATERIALES',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500],
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${project.totalArticles} Artículos',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'PRESUPUESTO',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500],
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '€${project.estimatedBudget.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}