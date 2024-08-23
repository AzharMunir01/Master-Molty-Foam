import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:permission_handler/permission_handler.dart';
import 'app/routes/app_page.dart';
import 'app/routes/routes.dart';
import 'app/theme/color.dart';
import 'app/utils/NavigationService.dart';

Future<void> main() async {

  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  // BackgroundServices().getFormFiles();
  // BackgroundServices().getFormData();
  // BackgroundServices().getOnBoardDealer();
  // PeriodicTask periodicTask = PeriodicTask();
  // periodicTask.start();
  // Request location permissions
  await _requestLocationPermissions();

}
Future<void> _requestLocationPermissions() async {
  // Check current permission status
  PermissionStatus permissionStatus = await Permission.location.request();

  // Handle permission status
  if (permissionStatus.isDenied || permissionStatus.isRestricted) {
    // Permission denied, handle accordingly
    // For example, show a dialog explaining why location is needed and how to enable it
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Master MoltyFoam DM',
      builder: (context, child) {
        return ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(480, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        );
      },
      navigatorKey: NavigationService.navigatorKey,
      theme: ThemeData(
        fontFamily: "DM Sans",
        primaryColor: FColors.primaryDarkColor,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: FColors.primaryDarkColor, secondary: FColors.primaryDarkColor, onSurfaceVariant: Colors.grey, surfaceTint: Colors.transparent),
      ),
      debugShowCheckedModeBanner: false,
      getPages: Routes.getPages,

      // onGenerateRoute: Routes,
      initialRoute:
      // AppPages.calRecord,
      AppPages.splashScreen,
    );
  }
}

//
// https://molty.bmccrm.com:442/MoltyDMAPP/MoltyDMAPI/api/Session/MobileLogin
//
//     {
// "UserID": null,
// "LoginName": "testadmin",
// "RoleID": null,
// "UserPassword": "abc123",
// "UserPassword_Old": null,
// "UserPassword_New": null,
// "SessionID": null,
// "IsLogin": 0
// }
//
//
//
// https://molty.bmccrm.com:442/MoltyDMAPP/MoltyDMAPI/api/Admin/SyncDataGet
