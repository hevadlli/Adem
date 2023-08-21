class ManualModeManager {
  static final ManualModeManager _instance = ManualModeManager._internal();

  factory ManualModeManager() {
    return _instance;
  }

  ManualModeManager._internal();

  bool _manualMode = false;

  bool get manualMode => _manualMode;

  void setManualMode(bool value) {
    _manualMode = value;
  }
}
