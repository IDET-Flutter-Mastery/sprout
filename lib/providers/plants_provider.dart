import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/plant.dart';
import 'plant_repository_provider.dart';

/// -----------------------------------------------------------------------
/// CP2 — Turn Plant Data Into a StreamProvider (Section 3)
/// -----------------------------------------------------------------------
/// Goal: expose the repository's live plant stream as a Riverpod
/// StreamProvider, so any widget can `ref.watch(plantsProvider)` and get
/// an AsyncValue<List<Plant>> — loading / data / error, all handled.
///
/// Do this:
///   1. Inside the builder callback, read the repository with
///      `ref.watch(plantRepositoryProvider)`.
///   2. Return `repo.watchPlants()` — a Stream<List<Plant>>.
///
/// Definition of done: `ref.watch(plantsProvider)` in CP3's screen
/// produces an AsyncValue that starts as AsyncLoading, then becomes
/// AsyncData with the four starter plants.
/// -----------------------------------------------------------------------
final plantsProvider = StreamProvider<List<Plant>>((ref) {
  // TODO (CP2): watch plantRepositoryProvider and return its stream.
  throw UnimplementedError('TODO (CP2): implement plantsProvider');
});
