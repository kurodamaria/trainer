import 'package:get/get.dart';

import 'settings_state.dart';
import 'package:trainer/services/settings.dart' as settings;

class SettingsLogic extends GetxController {
  final SettingsState state = SettingsState();

  void setCardPreviewMarkdown() {
    state.settingsBox.put(
      settings.cardPreviewKey,
      settings.cardPreviewMarkdown,
    );
  }

  void setPreviewPlainText() {
    state.settingsBox.put(
      settings.cardPreviewKey,
      settings.cardPreviewPlainText,
    );
  }
}
