import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ngaohap_pizza_app/consts/firebase_consts.dart';
import 'package:ngaohap_pizza_app/loading_manager.dart';
import 'package:ngaohap_pizza_app/screens/auth/forget_password.dart';
import 'package:ngaohap_pizza_app/screens/auth/login.dart';
import 'package:ngaohap_pizza_app/screens/orders/orders_screen.dart';
import 'package:ngaohap_pizza_app/screens/viewed_recently/viewed_screen.dart';
import 'package:ngaohap_pizza_app/services/configruation.dart';
import 'package:ngaohap_pizza_app/services/global_method.dart';
import 'package:ngaohap_pizza_app/widgets/text_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController =
      TextEditingController(text: '');
  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  String? _email;
  String? _name;
  String? address;
  bool _isLoading = false;
  final User? user = authInstance.currentUser;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      String _uid = user!.uid;

      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      if (userDoc == null) {
        return;
      } else {
        _email = userDoc.get('email');
        _name = userDoc.get('name');
        address = userDoc.get('dia-chi');
        _addressTextController.text = userDoc.get('dia-chi');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    height: 70.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Xin chào, ',
                            style: TextStyle(
                              color: primaryText,
                              fontSize: 27,
                              fontWeight: FontWeight.normal,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: _name == null ? 'user' : _name,
                                  style: TextStyle(
                                    color: primaryText,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print('My name is pressesd');
                                    }),
                            ],
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 70,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/user.jpg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextWidget(
                    text: _email == null ? 'Email' : _email!,
                    color: primaryText,
                    textSize: 18,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  _listTiles(
                    title: 'Địa chỉ',
                    subtitle: address,
                    icon: IconlyLight.profile,
                    onPressed: () async {
                      await _showAdressDialog();
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  _listTiles(
                    title: 'Đơn hàng',
                    icon: IconlyLight.bag,
                    onPressed: () {
                      GlobalMethods.navigateTo(
                          ctx: context, routeName: OrderScreen.routeName);
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  _listTiles(
                    title: 'Đã xem',
                    icon: IconlyLight.show,
                    onPressed: () {
                      GlobalMethods.navigateTo(
                          ctx: context, routeName: ViewedScreen.routeName);
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  _listTiles(
                    title: 'Quên mật khẩu',
                    icon: IconlyLight.unlock,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ForgetPasswordScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  _listTiles(
                    title: user == null ? 'Đăng nhập' : 'Đăng xuất',
                    icon: user == null ? IconlyLight.login : IconlyLight.logout,
                    onPressed: () {
                      if (user == null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                        return;
                      }
                      GlobalMethods.warningDialog(
                          title: "Thoát ra",
                          subtitle: "Bạn có muốn thoát không?",
                          fct: () async {
                            await authInstance.signOut();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          context: context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAdressDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Cập nhật'),
            content: TextField(
              // onChanged: (value) {
              //   // print(_addressTextController.text ${_addressTextController.text});
              // },
              controller: _addressTextController,
              maxLines: 5,
              decoration: InputDecoration(hintText: 'Địa chỉ của bạn'),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  String _uid = user!.uid;
                  try {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(_uid)
                        .update({'dia-chi': _addressTextController.text});
                    Navigator.pop(context);
                    setState(() {
                      address = _addressTextController.text;
                    });
                  } catch (err) {
                    GlobalMethods.errorDialog(
                        subtitle: err.toString(), context: context);
                  }
                },
                child: const Text('Cập nhật'),
              ),
            ],
          );
        });
  }

  Future<void> _showLogoutDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [const Text('Thoát')],
            ),
            content: const Text('Bạn có muốn thoát không ?'),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.cyan,
                  text: 'Quay trở lại',
                  textSize: 18,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: TextWidget(
                  color: Colors.red,
                  text: 'Có',
                  textSize: 18,
                ),
              ),
            ],
          );
        });
  }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
  }) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: primaryText,
        textSize: 22,
        isTitle: true,
      ),
      subtitle: TextWidget(
        text: subtitle == null ? "" : subtitle,
        color: primaryText,
        textSize: 18,
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
