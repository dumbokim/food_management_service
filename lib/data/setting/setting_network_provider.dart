import 'package:food_ppopgi/domain/domain.dart';
import 'package:food_ppopgi/pages/splash/splash_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riv;
import 'package:supabase_flutter/supabase_flutter.dart';

final settingProvider = riv.Provider<SettingProvider>(
    (ref) => SettingNetworkProvider(database: ref.watch(database)));

class SettingNetworkProvider extends SettingProvider {
  SettingNetworkProvider({
    required this.database,
  });

  final SupabaseClient database;

  @override
  Future getMinimumVersion() async {
    final data = await database
        .from('app_version')
        .select('version, download_link') as List?;

    return data ?? [];
  }
}
