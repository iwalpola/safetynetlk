import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safetynetlk/Widgets/social_icons.dart';
import 'package:safetynetlk/custom_icons.dart';
import 'package:provider/provider.dart';
import 'package:safetynetlk/models/user_model.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _signUpActive = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newEmailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  void _changeToSignUp() {
    setState(() {
      _signUpActive = true;
    });
  }

  void _changeToSignIn() {
    setState(() {
      _signUpActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height),
      designSize: const Size(750, 1304),
      // orientation: Orientation.portrait
    );
    UserModel userModel = context.watch<UserModel>();
    return Column(
      children: <Widget>[
        SizedBox(
          child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(Model._logoTitle, style: CustomTextStyle.title(context)),
                  Text(
                    Model._logoSubTitle,
                    style: CustomTextStyle.subTitle(context),
                  ),
                ],
              )),
          width: ScreenUtil().setWidth(750),
          height: ScreenUtil().setHeight(190),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(60),
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: IntrinsicWidth(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  OutlinedButton(
                    onPressed: _changeToSignIn,
                    child: Text(Model._signInMenuButton,
                        style: !_signUpActive
                            ? TextStyle(
                                fontSize: 22,
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold)
                            : TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.normal)),
                  ),
                  OutlinedButton(
                    onPressed: _changeToSignUp,
                    child: Text(Model._signUpMenuButton,
                        style: _signUpActive
                            ? TextStyle(
                                fontSize: 22,
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold)
                            : TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.normal)),
                  )
                ],
              ),
            ),
          ),
          width: ScreenUtil().setWidth(750),
          height: ScreenUtil().setHeight(170),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        SizedBox(
          child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: !_signUpActive
                  ? _showSignIn(context, userModel)
                  : _showSignUp(context, userModel)),
          width: ScreenUtil().setWidth(750),
          height: ScreenUtil().setHeight(778),
        ),
      ],
    );
  }

  Widget _showSignIn(context, UserModel userModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: ScreenUtil().setHeight(30),
        ),
        Padding(
          padding: const EdgeInsets.only(),
          child: TextField(
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            controller: _emailController,
            decoration: InputDecoration(
              hintText: Model._hintTextEmail,
              hintStyle: CustomTextStyle.formField(context),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1.0)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1.0)),
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.white,
              ),
            ),
            obscureText: false,
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(50),
        ),
        Padding(
          padding: const EdgeInsets.only(),
          child: TextField(
            obscureText: true,
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            controller: _passwordController,
            decoration: InputDecoration(
              //Add th Hint text here.
              hintText: Model._hintTextPassword,
              hintStyle: CustomTextStyle.formField(context),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1.0)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1.0)),
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(80),
        ),
        Padding(
          padding: const EdgeInsets.only(),
          child: ElevatedButton(
            child: Row(
              children: <Widget>[
                const SocialIcon(iconData: CustomIcons.email),
                Expanded(
                  child: Text(
                    Model._signInWithEmailButtonText,
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.button(context),
                  ),
                )
              ],
            ),
            style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
            onPressed: () => userModel.signIn(
                email: _emailController.text,
                password: _passwordController.text),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(30),
        ),
        Padding(
          padding: const EdgeInsets.only(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              horizontalLine(),
              Text(Model._alternativeLogInSeparatorText,
                  style: CustomTextStyle.body(context)),
              horizontalLine()
            ],
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(30),
        ),
        Padding(
            padding: const EdgeInsets.only(),
            child: ElevatedButton(
              child: Row(
                children: <Widget>[
                  const SocialIcon(iconData: CustomIcons.facebook),
                  Expanded(
                    child: Text(
                      Model._signInWithFacebookButtonText,
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.button(context),
                    ),
                  )
                ],
              ),
              style: ElevatedButton.styleFrom(primary: const Color(0xFF3C5A99)),
              onPressed: () {
                userModel.signInWithFacebook;
              },
            )),
      ],
    );
  }

  Widget _showSignUp(context, UserModel userModel) {
    String? message;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: ScreenUtil().setHeight(30),
        ),
        Padding(
          padding: const EdgeInsets.only(),
          child: TextField(
            obscureText: false,
            style: CustomTextStyle.formField(context),
            controller: _newEmailController,
            decoration: InputDecoration(
              //Add th Hint text here.
              hintText: Model._hintTextNewEmail,
              hintStyle: CustomTextStyle.formField(context),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1.0)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1.0)),
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(50),
        ),
        Padding(
          padding: const EdgeInsets.only(),
          child: TextField(
            obscureText: true,
            style: CustomTextStyle.formField(context),
            controller: _newPasswordController,
            decoration: InputDecoration(
              //Add the Hint text here.
              hintText: Model._hintTextNewPassword,
              hintStyle: CustomTextStyle.formField(context),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1.0)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1.0)),
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(80),
        ),
        Padding(
          padding: const EdgeInsets.only(),
          child: ElevatedButton(
            child: Text(
              Model._signUpButtonText,
              style: CustomTextStyle.button(context),
            ),
            style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
            onPressed: () async {
              String result = await userModel.signUp(
                  email: _newEmailController.text,
                  password: _newPasswordController.text);
              message = result == 'success' ? null : result;
            },
          ),
        ),
      ],
    );
  }

  Widget horizontalLine() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil().setWidth(120),
          height: 1.0,
          color: Colors.white.withOpacity(0.6),
        ),
      );

  Widget emailErrorText() => const Text(Model._emailLogInFailed);
}

class Model {
  static const String _logoTitle = "safetynetlk";
  static const String _logoSubTitle = "GROWTH * HAPPENS * TODAY";
  static const String _signInMenuButton = "SIGN IN";
  static const String _signUpMenuButton = "SIGN UP";
  static const String _hintTextEmail = "Email";
  static const String _hintTextPassword = "Password";
  static const String _hintTextNewEmail = "Enter your Email";
  static const String _hintTextNewPassword = "Enter a Password";
  static const String _signUpButtonText = "SIGN UP";
  static const String _signInWithEmailButtonText = "Sign in with Email";
  static const String _signInWithFacebookButtonText = "Sign in with Facebook";
  static const String _alternativeLogInSeparatorText = "or";
  static const String _emailLogInFailed =
      "Email or Password was incorrect. Please try again";
}

class CustomTextStyle {
  static TextStyle formField(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
        fontSize: 18.0, fontWeight: FontWeight.normal, color: Colors.white);
  }

  static TextStyle title(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
        fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white);
  }

  static TextStyle subTitle(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
        fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white);
  }

  static TextStyle button(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
        fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white);
  }

  static TextStyle body(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
        fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white);
  }
}
