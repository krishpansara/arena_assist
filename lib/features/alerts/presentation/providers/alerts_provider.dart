import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/alerts_repository.dart';
import '../../domain/models/alert_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

final alertsRepositoryProvider = Provider<AlertsRepository>((ref) {
  return AlertsRepository();
});

final alertsStreamProvider = StreamProvider<List<AlertModel>>((ref) {
  final authState = ref.watch(authStateChangesProvider);
  final user = authState.valueOrNull;

  if (user == null) {
    return Stream.value([]);
  }

  return ref.read(alertsRepositoryProvider).getUserAlerts(user.uid);
});
