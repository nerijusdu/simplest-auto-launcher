import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class AppsPage extends StatefulWidget {
  const AppsPage({Key? key}) : super(key: key);

  @override
  State<AppsPage> createState() => _AppsPageState();
}

class _AppsPageState extends State<AppsPage> {
  List<Application> apps = [];

  @override
  void initState() {
    loadApps();
    super.initState();
  }

  void loadApps() async {
    var apps = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    );
    apps.sort((a, b) => a.appName.compareTo(b.appName));
    setState(() {
      this.apps = apps;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (apps.isEmpty) {
      return const CircularProgressIndicator();
    }

    return ListView.builder(
      itemCount: apps.length,
      itemBuilder: (context, index) {
        final app = apps[index];
        return ListTile(
          title: Text(app.appName),
          leading: app is ApplicationWithIcon
              ? CircleAvatar(backgroundImage: MemoryImage(app.icon))
              : null,
          onTap: () => DeviceApps.openApp(app.packageName),
        );
      },
    );
  }
}
