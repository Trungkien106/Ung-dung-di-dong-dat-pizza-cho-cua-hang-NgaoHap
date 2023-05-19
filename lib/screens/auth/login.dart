import 'package:firebase_auth/firebase_auth.dart';
import 'package:ngaohap_pizza_app/consts/firebase_consts.dart';
import 'package:ngaohap_pizza_app/loading_manager.dart';
import 'package:ngaohap_pizza_app/screens/auth/forget_password.dart';
import 'package:ngaohap_pizza_app/screens/auth/register.dart';
import 'package:ngaohap_pizza_app/screens/btm_bar.dart';
import 'package:ngaohap_pizza_app/services/global_method.dart';
import 'package:ngaohap_pizza_app/widgets/rounded_button.dart';
import 'package:ngaohap_pizza_app/services/configruation.dart';
import 'package:ngaohap_pizza_app/widgets/text_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _obscureText = true;
  final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}');
  @override
  void dispose() {
    _emailTextController.dispose();
    _passTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  void _submidFormOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });
    if (isValid) {
      _formKey.currentState!.save();

      try {
        await authInstance.signInWithEmailAndPassword(
            email: _emailTextController.text.toLowerCase().trim(),
            password: _passTextController.text.trim());
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const BottomBarScreen(),
          ),
        );
        print('Đăng nhập thành công');
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
              children: [
                const SizedBox(
                  height: 70.0,
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
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          children: [
                            //Email
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_passFocusNode),
                              controller: _emailTextController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]')
                                        .hasMatch(value!)) {
                                  return 'Enter correct email';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                hintText: "Email",
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: primaryBoxx, width: 1),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: primaryBoxx, width: 1),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            //Password
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () {
                                _submidFormOnLogin();
                              },
                              controller: _passTextController,
                              focusNode: _passFocusNode,
                              obscureText: _obscureText,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 7) {
                                  return 'Vui long nhap dung cu phap mat khau';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: primaryBoxx, width: 1),
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: primaryBoxx, width: 1),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: 'Mật khẩu',
                                // hintStyle: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 5.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            GlobalMethods.navigateTo(
                                ctx: context,
                                routeName: ForgetPasswordScreen.routeName);
                          },
                          child: const Text(
                            'Quên mật khẩu',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 18.0,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    RoundedButton(
                      text: 'Đăng nhập',
                      fct: _submidFormOnLogin,
                      textColor: Colors.white,
                    ),
                    // AuthButton(
                    //   fct: () {},
                    //   buttonText: 'Log in',
                    // ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              color: Colors.black,
                              thickness: 2,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TextWidget(
                            text: 'Hoặc',
                            color: Colors.black,
                            textSize: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Expanded(
                            child: Divider(
                              color: Colors.black,
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      width: size.width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 40.0),
                            backgroundColor: Colors.grey,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const BottomBarScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Tiếp tục với vai trò khách',
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Bạn chưa có tài khoản ?',
                              style:
                                  TextStyle(color: primaryText, fontSize: 18),
                              children: [
                                TextSpan(
                                    text: 'Đăng ký',
                                    style: const TextStyle(
                                      color: Colors.lightBlue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        GlobalMethods.navigateTo(
                                            ctx: context,
                                            routeName:
                                                RegisterScreen.routeName);
                                      }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Image.asset('assets/images/white.png'),
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
