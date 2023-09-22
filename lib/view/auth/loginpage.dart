import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:lottie/lottie.dart';
// import 'package:overwatch/widgets/common/footer.dart';
// import 'package:overwatch/widgets/dialogs/loadingdialog.dart';
import 'package:provider/provider.dart';

import '../../constant/colors.dart';
import '../../provider/authprovider.dart';
import '../../widget/common/customeelevatedbutton.dart';
import '../../widget/common/footer.dart';


class YourPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Future<void> _animationFuture;

  @override
  void initState() {
    super.initState();
    _animationFuture = _waitForAnimation();
  }

  Future<void> _waitForAnimation() async {
    await Future.delayed(const Duration(seconds: 0));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _animationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(), // Your animation path
          );
        } else {
          return LoginForm(); // Replace this with your container content
        }
      },
    );
  }
}

class LoginForm extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: ColorClass.baseColor,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    SvgPicture.asset(
                      'assets/images/blitzlogo.svg',
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 50,
              ),
              Consumer<AuthProvider>(builder: (context, authProvider, child) {
                return Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            'Username',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: ColorClass.darkGrey.withOpacity(0.8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            // height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter username';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                counterText: "",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(width: 0)),
                                contentPadding: const EdgeInsets.only(left: 15),
                                hintText: 'Enter Username',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorClass.darkGrey.withOpacity(0.7),
                                ),
                              ),
                              onChanged: (value) {
                                authProvider.setUserName(value);
                              },
                            )),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: ColorClass.darkGrey.withOpacity(0.8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            // height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                counterText: "",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(width: 0)),
                                contentPadding: const EdgeInsets.only(left: 15),
                                hintText: 'Enter Password',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorClass.darkGrey.withOpacity(0.7),
                                ),
                              ),
                              onChanged: (value) {
                                authProvider.setPassword(value);
                              },
                            )),
                        const SizedBox(height: 15),
                        CustomElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                authProvider.login().then((value) => {
                                      if (value)
                                        {
                                          authProvider.loadconfig(),
                                          Navigator.pushNamed(
                                            context,
                                            '/home',
                                          )
                                        }
                                      else
                                        {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  authProvider.errormessage),
                                              backgroundColor:
                                                  ColorClass.appred,
                                            ),
                                          )
                                        }
                                    });
                              }
                            },
                            color: ColorClass.baseColor,
                            textcolor: Colors.white,
                            width: MediaQuery.of(context).size.width * 0.9,
                            isDisabled: false,
                            text: 'Login'),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
      backgroundColor: Colors.white,
    );
  }
}
