import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopify/common/helpers/is_dark_mode.dart';
import 'package:shopify/common/widgets/action_text/action_text.dart';
import 'package:shopify/common/widgets/appbar/app_bar.dart';
import 'package:shopify/common/widgets/button/basic_app_button.dart';
import 'package:shopify/common/widgets/divider_with_text/divider_with_text.dart';
import 'package:shopify/common/widgets/layout/main_layout.dart';
import 'package:shopify/common/widgets/text_form_field/text_form_field.dart';
import 'package:shopify/core/configs/assets/app_vectors.dart';
import 'package:shopify/data/models/auth/signin_user_req.dart';
import 'package:shopify/domain/usecases/auth/signin.dart';
import 'package:shopify/presentation/auth/pages/signup.dart';
import 'package:shopify/service_locator.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: _registerText(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ActionText(
                      action: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) => SigninPage()),
                        );
                      },
                      actionText: 'Click here',
                      desText: 'If you need any support',
                      actionStyle: TextStyle(
                        color: Color(0xff38B432),
                      ),
                    ),
                  ),
                  CommonTextFormField(
                    hintText: 'Enter Email',
                    controller: _email,
                  ),
                  SizedBox(height: 20),
                  CommonTextFormField(
                    hintText: 'Password',
                    controller: _password,
                    isPassword: true,
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Recovery Password',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: context.isDarkMode ? Colors.white : Color(0xff383838),
                    ),
                  ),
                  SizedBox(height: 20),
                  BasicAppButton(
                    onPressed: () {
                      signin(context);
                    },
                    title: 'Sign In'
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            CommonDividerWithText(text: Text('Or', style: TextStyle(fontSize: 12))),
            SizedBox(height: 20),
            IconButton(
              onPressed: () {
                
              },
              icon: SvgPicture.asset(
                AppVectors.googleIcon,
                fit: BoxFit.none,
              ),
            ),
            SizedBox(height: 20),
            ActionText(
              action: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => SignupPage()),
                );
              },
              actionText: 'Regiter Now',
              desText: 'Not A Member?',
            ),

          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Sign In',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }

 Future<void> signin(BuildContext context) async {
    var result = await sl<SigninUseCase>().call(
      params: SigninUserReq(
        email: _email.text.toString(),
        password: _password.text.toString()
      )
    );

    result.fold(
      (ifLeft) {
        var snackbar = SnackBar(content: Text(ifLeft));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      },
      (ifRight) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => const MainLayout()), 
          (route) => false
        );
      }
    );
  }
}
