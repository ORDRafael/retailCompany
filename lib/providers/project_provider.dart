import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:obramat/data/mock_projects.dart';
import 'package:obramat/models/projects.dart';

class ProjectsNotifier extends StateNotifier<List<Project>> {
  ProjectsNotifier() : super(mockProjects);

  void addProject(Project project) {
    state = [...state, project];
  }

  void removeProject(String id) {
    state = state.where((p) => p.id != id).toList();
  }

  void updateProject(Project updatedProject) {
    state = [
      for (final project in state)
        if (project.id == updatedProject.id) updatedProject else project,
    ];
  }
}

final projectsProvider =
    StateNotifierProvider<ProjectsNotifier, List<Project>>((ref) {
  return ProjectsNotifier();
});

final projectByIdProvider = Provider.family<Project?, String>((ref, id) {
  final projects = ref.watch(projectsProvider);
  try {
    return projects.firstWhere((p) => p.id == id);
  } catch (e) {
    return null;
  }
});

final projectsByStatusProvider =
    Provider.family<List<Project>, ProjectStatus>((ref, status) {
  final projects = ref.watch(projectsProvider);
  return projects.where((p) => p.status == status).toList();
});

final totalInvestmentProvider = Provider<double>((ref) {
  final projects = ref.watch(projectsProvider);
  return projects.fold(0.0, (sum, p) => sum + p.totalProject);
});