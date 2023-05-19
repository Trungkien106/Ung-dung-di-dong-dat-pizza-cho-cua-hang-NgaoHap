import 'package:flutter/material.dart';
import 'package:ngaohap_pizza_app/inner_screens/browseall_screen.dart';
import 'package:ngaohap_pizza_app/services/configruation.dart';
import 'package:ngaohap_pizza_app/services/global_method.dart';
import 'package:ngaohap_pizza_app/widgets/text_widget.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.subtitle,
      required this.buttontext})
      : super(key: key);
  final String imagePath, title, subtitle, buttontext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: double.infinity,
                height: 400.0,
              ),
              SizedBox(
                height: 5.0,
              ),
              const Text(
                'Oops',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextWidget(
                text: title,
                color: Colors.cyan,
                textSize: 20,
              ),
              SizedBox(
                height: 5.0,
              ),
              TextWidget(
                text: subtitle,
                color: Colors.cyan,
                textSize: 20,
              ),
              SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  primary: Theme.of(context).colorScheme.secondary,
                  onPrimary: primaryText,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20.0),
                ),
                onPressed: () {
                  GlobalMethods.navigateTo(
                      ctx: context, routeName: BrowseallScreen.routeName);
                },
                child: TextWidget(
                  text: buttontext,
                  textSize: 20,
                  color: Colors.grey.shade800,
                  isTitle: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
