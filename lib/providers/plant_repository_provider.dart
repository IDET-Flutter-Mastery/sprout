import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/plant_repository.dart';

/// -----------------------------------------------------------------------
/// plantRepositoryProvider — DONE, no edits needed.
/// -----------------------------------------------------------------------
/// A plain Provider<T> for a value that is created once and never changes
/// on its own — exactly the "Provider<T>" slide from lecture.
/// -----------------------------------------------------------------------
final plantRepositoryProvider = Provider<PlantRepository>((ref) {
  final repo = PlantRepository();
  ref.onDispose(repo.dispose);
  return repo;
});
