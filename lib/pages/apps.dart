import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_with_state.dart';

class AppsPage extends StatefulWidget {
  const AppsPage({Key? key}) : super(key: key);

  @override
  State<AppsPage> createState() => _AppsPageState();
}

class _AppsPageState extends State<AppsPage> {
  List<AppWithState> apps = [];

  @override
  void initState() {
    loadApps();
    super.initState();
  }

  void loadApps() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteApps = prefs.getStringList('favoriteApps') ?? [];
    final apps = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    );
    apps.sort((a, b) => a.appName.compareTo(b.appName));

    setState(() {
      this.apps = apps
          .map((x) => AppWithState.withIcon(
                x as ApplicationWithIcon,
                favoriteApps.contains(x.packageName),
              ))
          .toList();
    });
  }

  Future saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      'favoriteApps',
      apps.where((x) => x.isFavorite).map((x) => x.package).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (apps.isEmpty) {
      return const Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ),
      );
    }

    return ListView.builder(
      itemCount: apps.length,
      itemBuilder: (context, index) {
        final app = apps[index];
        return ListTile(
          title: Text(app.name),
          leading: CircleAvatar(backgroundImage: MemoryImage(app.icon)),
          trailing: IconButton(
            icon: Icon(app.isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              setState(() {
                app.isFavorite = !app.isFavorite;
              });
              saveFavorites();
            },
          ),
          onTap: app.open,
        );
      },
    );
  }
}
