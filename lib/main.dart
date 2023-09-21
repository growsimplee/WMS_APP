import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wms_app/constant/routes.dart';
import 'package:wms_app/provider/authprovider.dart';
import 'package:wms_app/provider/picklistprovider.dart';
import 'package:wms_app/provider/scanprovider.dart';
import 'package:wms_app/utilities/authwrapper.dart';
import 'package:wms_app/utilities/servicelocator.dart';
import 'package:provider/provider.dart';

import 'constant/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  await initDependencies();
  runApp(const WMSAPP());
}

class WMSAPP extends StatelessWidget {
  const WMSAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
         ChangeNotifierProvider(create: (_) => ScanProvider()),
        ChangeNotifierProvider(create: (_) => PicklistProvider()),
      ],
      child: MaterialApp(
        builder: (context, child) {
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(
            data: data.copyWith(
                textScaleFactor:
                    data.textScaleFactor > 1.0 ? 1.0 : data.textScaleFactor),
            child: child!,
          );
        },
        routes: routes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: ColorClass.baseMaterialColor)
              .copyWith(
            background: ColorClass.baseColor.withOpacity(0.05),
          ),
        ),
        home: AuthWrapper(),
      ),
    );
  }
}
