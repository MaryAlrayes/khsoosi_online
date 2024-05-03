import 'package:khosousi_online/core/managers/languages_manager.dart';
import 'package:khosousi_online/core/utils/services/shared_preferences.dart';

import 'localize_app.dart';

class LocalizeAppImpl implements LocalizeApp {
  final kLanguage = 'LANGUAGE';

  @override
  Future<void> cacheLanguageCode(String language) async {
    await PreferenceUtils.setString(kLanguage, language);
  }

  @override
  Future<String> getCachedLanguageCode() async {
    String? lang = PreferenceUtils.getString(
      kLanguage,
    );
    if (lang != null) {
      return lang;
    } else {
      return LanguagesManager.Arabic;
    }
  }
}
