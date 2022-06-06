import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bike_observation_deck/ui/views/SplashScreen/SplashScreenView.dart';

import 'package:flutter/material.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:stacked/stacked.dart';

import 'ui/theme/AppColors.dart';
import 'package:responsive_framework/responsive_framework.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //FlutterUxcam.optIntoSchematicRecordings();
//     //FlutterUxcam.startWithKey("mopuajsvo8nu4wt");
//     return ViewModelBuilder<AppModel>.reactive(
//       builder: (context, model, child) {
//         return MaterialApp(home: SplashScreenView());
//       },
//       viewModelBuilder: () => AppModel(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // AwesomeNotifications()
    //     .actionStream
    //     .listen((ReceivedNotification receivedNotification) {
    //   print("NOTIFICATION: $receivedNotification");
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => WeeklyTimelineView()),
    //   );
    // });

    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      home: SplashScreenView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
