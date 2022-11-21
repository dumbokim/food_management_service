import 'package:hooks_riverpod/hooks_riverpod.dart' as riv;
import 'package:package_info_plus/package_info_plus.dart';

import '../../domain/domain.dart';
import 'setting_network_provider.dart';

final settingRepository = riv.Provider<SettingRepository>((ref) =>
    SettingDataRepository(settingProvider: ref.watch(settingProvider)));

class SettingDataRepository extends SettingRepository {
  SettingDataRepository({required this.settingProvider});

  final SettingProvider settingProvider;

  @override
  Future<String> needsUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    try {
      final data = (await settingProvider.getMinimumVersion())?[0] ?? {};
      final minimumVersion = int.tryParse(data['version']) ?? 99999999;
      if ((int.tryParse(packageInfo.buildNumber) ?? 22112201) <
          minimumVersion) {
        return data['download_link'] ?? 'https://www.naver.com';
      }

      return '';
    } catch (e) {
      return 'https://www.naver.com';
    }
  }
}
