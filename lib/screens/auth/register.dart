import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ngaohap_pizza_app/consts/firebase_consts.dart';
import 'package:ngaohap_pizza_app/loading_manager.dart';
import 'package:ngaohap_pizza_app/screens/auth/login.dart';
import 'package:ngaohap_pizza_app/screens/btm_bar.dart';
import 'package:ngaohap_pizza_app/services/configruation.dart';
import 'package:ngaohap_pizza_app/services/global_method.dart';
import 'package:ngaohap_pizza_app/widgets/back_widget.dart';
import 'package:ngaohap_pizza_app/widgets/rounded_button.dart';
import 'package:ngaohap_pizza_app/widgets/text_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_iconly/flutter_iconly.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = '/RegisterScreen';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _addressTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  bool _obscureText = true;
  final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}');

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _addressTextController.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void _submitFormOnRegister() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.createUserWithEmailAndPassword(
            email: _emailTextController.text.toLowerCase().trim(),
            password: _passTextController.text.trim());
        final User? user = authInstance.currentUser;
        final _uid = user!.uid;
        user.updateDisplayName(_fullNameController.text);
        user.reload();
        await FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'id': _uid,
          'name': _fullNameController.text,
          'email': _emailTextController.text.toLowerCase(),
          'dia-chi': _addressTextController.text,
          'userWish': [],
          'userCart': [],
          'createdAt': Timestamp.now(),
        });
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const BottomBarScreen(),
        ));
        print('Succefully registered');
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
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 60.0,
                ),
                Row(
                  children: [
                    BackButton(),
                    Padding(
                      padding: EdgeInsets.only(left: 100.0),
                      child: Column(
                        children: [
                          TextWidget(
                            text: 'Đăng Ký',
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

                  // fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 20.0,
                ),
                SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            children: [
                              //Fullname
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(_emailFocusNode),
                                controller: _fullNameController,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Vui lòng không được bỏ trống';
                                  } else {
                                    return null;
                                  }
                                },
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: "Tên đầy đủ",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryBoxx, width: 1),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryBoxx, width: 1),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              //Email
                              TextFormField(
                                focusNode: _emailFocusNode,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(_passFocusNode),
                                controller: _emailTextController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains("@")) {
                                    return 'Vui lòng điền đúng cú pháp Email';
                                  } else {
                                    return null;
                                  }
                                },
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: "Email",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryBoxx, width: 1),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryBoxx, width: 1),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),

                              //Password
                              TextFormField(
                                focusNode: _passFocusNode,
                                obscureText: _obscureText,
                                keyboardType: TextInputType.visiblePassword,
                                controller: _passTextController,
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 7) {
                                    return 'Mật khẩu > 7 ký tự ';
                                  } else {
                                    return null;
                                  }
                                },
                                style: const TextStyle(color: Colors.black),
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(_addressFocusNode),
                                decoration: InputDecoration(
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
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryBoxx, width: 1),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryBoxx, width: 1),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              TextFormField(
                                focusNode: _addressFocusNode,
                                textInputAction: TextInputAction.done,
                                onEditingComplete: _submitFormOnRegister,
                                controller: _addressTextController,
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 10) {
                                    return 'Vui lòng điền đầy đủ thông tin địa chỉ';
                                  } else {
                                    return null;
                                  }
                                },
                                style: const TextStyle(color: Colors.black),
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                decoration: const InputDecoration(
                                  hintText: "Địa chỉ",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryBoxx, width: 1),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryBoxx, width: 1),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      RoundedButton(
                        text: 'Đăng ký',
                        fct: () {
                          _submitFormOnRegister();
                        },
                        textColor: Colors.white,
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Bạn đã có tài khoản ? ',
                                style:
                                    TextStyle(color: primaryText, fontSize: 18),
                                children: [
                                  TextSpan(
                                    text: 'Đăng nhập',
                                    style: const TextStyle(
                                      color: Colors.lightBlue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacementNamed(
                                            context, LoginScreen.routeName);
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset('assets/images/white.png'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
