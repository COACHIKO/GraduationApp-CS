import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:graduation/view/screens/home_screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'core/localization/changelocal.dart';
import 'core/localization/translation.dart';
import 'core/notification/notfication.dart';
import 'core/services/auth_services.dart';
import 'core/services/services.dart';
import 'firebase_options.dart';
import 'view/screens/auth/fork_usering_page.dart';
import 'package:timezone/data/latest.dart' as tz;

AuthService authService = AuthService();
Box? mybox;

Future<Box> openHiveBox(String boxname) async {
  if (!Hive.isBoxOpen(boxname)) {
    try {
        Hive.init((await getApplicationDocumentsDirectory()).path);
    } catch (e) {
      print("Error initializing Hive: $e");
    }
  }
  return await Hive.openBox(boxname);
}

LocaleController a = LocaleController();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
MyServices myServices = Get.find();

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();

  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.init(appDocumentDirectory.path);
  }
  mybox = await openHiveBox("client");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

LocaleController langcontroller = Get.put(LocaleController());

void main() {
  initializeApp().then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, child) {
        return GetMaterialApp(
          locale: langcontroller.language,
          translations: MyTranslation(),
          localizationsDelegates: [
            // Add your localizations delegates here if needed
          ],
          initialRoute: myServices.sharedPreferences.getBool("isAuthenticated") == null ? "/forkUsering" : "/homepage",
          routes: {
            "/homepage": (context) => const HomePage(),
            "/forkUsering": (context) => const forkUseringPage(),
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
