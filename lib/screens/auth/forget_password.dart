import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ngaohap_pizza_app/consts/firebase_consts.dart';
import 'package:ngaohap_pizza_app/loading_manager.dart';
import 'package:ngaohap_pizza_app/services/configruation.dart';
import 'package:ngaohap_pizza_app/services/global_method.dart';
import 'package:ngaohap_pizza_app/widgets/rounded_button.dart';
import 'package:ngaohap_pizza_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../consts/contss.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgetPasswordScreen';
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailTextController = TextEditingController();
  // bool _isLoading = false;
  @override
  void dispose() {
    _emailTextController.dispose();

    super.dispose();
  }

  bool _isLoading = false;
  void _forgetPassFCT() async {
    if (_emailTextController.text.isEmpty ||
        !_emailTextController.text.contains("@")) {
      GlobalMethods.errorDialog(
          subtitle: 'Vui lòng điền đúng cú pháp email', context: context);
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.sendPasswordResetEmail(
            email: _emailTextController.text.toLowerCase());
        Fluttertoast.showToast(
          msg: "Một email đã được gửi đến địa chỉ email của bạn",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade600,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            subtitle: '${error.message}', context: context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoadingManager(
      isLoading: _isLoading,
      child: Material(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 70.0,
                ),
                Row(
                  children: [
                    BackButton(),
                    Padding(
                      padding: EdgeInsets.only(left: 60.0),
                      child: Column(
                        children: [
                          TextWidget(
                            text: 'Đặt lại mật khẩu',
                            color: primaryText,
                            textSize: 23,
                            isTitle: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/images/logo/logo-pizza.png',
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50.0,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextField(
                        controller: _emailTextController,
                        style: const TextStyle(color: primaryText),
                        decoration: const InputDecoration(
                          hintText: 'Địa chỉ email của bạn',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryText),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryText),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    RoundedButton(
                      text: 'Đặt lại mật khẩu',
                      fct: () {
                        _forgetPassFCT();
                      },
                      textColor: Colors.white,
                    ),
                    Image.asset(
                      'assets/images/white.png',
                      height: 300,
                    ),
                    // AuthButton(
                    //   fct: () {},
                    //   buttonText: 'Log in',
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
