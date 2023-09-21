import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:overwatch/constant/constdata.dart';
// import 'package:overwatch/provider/auth_provider.dart';
// import 'package:overwatch/utilities/servicelocator.dart';
// import 'package:overwatch/widgets/common/customelevatedbutton.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:lottie/lottie.dart';

import '../../../constant/colors.dart';
import '../../provider/authprovider.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass.baseColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const SizedBox(
              //   height: 50,
              // ),
              Center(
                child: SvgPicture.asset(
                'assets/images/gs_logo.svg',
                color: Colors.white,
              ), // Replace with your animation file path
              ),
              // SvgPicture.asset(
              //   'assets/images/gs_logo.svg',
              //   color: Colors.white,
              // ),
              // const SizedBox(height: 20),
              // const Text(
              //   'Franchise Owner App',
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.w600,
              //     color: Colors.white,
              //   ),
              // ),
              // const SizedBox(height: 20),
              // context.read<AuthProvider>().updateUrl != null
              //     ? CustomElevatedButton(
              //         text: 'Update Now',
              //         width: 200,
              //         color: Colors.white,
              //         textcolor: ColorClass.baseColor,
              //         onPressed: () async {
              //           await launchUrl(
              //               Uri.parse(context.read<AuthProvider>().updateUrl!),
              //               mode: LaunchMode.externalApplication);
              //         },
              //       )
              //     : SizedBox(
              //         child: Text(context.read<AuthProvider>().updateUrl ?? ''),
              //       ),
            ],
          ),
        ),
      ),
      // floatingActionButton: Text(
      //     'Version v.${serviceLocator<SharedPreferences>().getString('version')}',
      //     style: TextStyle(color: Colors.white)),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
