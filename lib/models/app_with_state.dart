import 'package:device_apps/device_apps.dart';

class AppWithState {
  final Application _app;
  bool isFavorite = false;

  AppWithState(this._app, [this.isFavorite = false]);

  AppWithState.withIcon(ApplicationWithIcon app, [this.isFavorite = false])
      : _app = app;

  String get name => _app.appName;

  String get package => _app.packageName;

  get icon => (_app as ApplicationWithIcon).icon;

  Future<bool> open() {
    return DeviceApps.openApp(_app.packageName);
  }
}
