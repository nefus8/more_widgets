import 'package:flutter/material.dart';
import 'package:more_widgets/more_widgets.dart';
import 'package:more_widgets/src/auth_screens/email_text_form_field.dart';
import 'package:more_widgets/src/auth_screens/password_text_form_field.dart';
import 'package:more_widgets/src/gradient_button.dart';

class LoginView extends StatefulWidget {
  final AlignmentGeometry begin, end;
  final List<Color> colors, darkColors;
  final List<double> stops;
  final String loginTitle, loginButtonText, signupButtonText, forgotPasswordText;
  final String? emailLabelText, passwordLabelText, emailNotValidMessage, emailRequiredMessage, enterPasswordMessage;
  final Color loginTitleColor, forgotPasswordTextColor;
  final Function onLogin;

  final String? forgotPasswordRouteName, signupRouteName;
  final Widget? forgotPasswordView, signupView;
  final bool useRouteName;

  const LoginView({
    Key? key,
    required this.onLogin,
    this.forgotPasswordRouteName,
    this.signupRouteName,
    this.forgotPasswordView,
    this.signupView,
    this.useRouteName = true,
    this.begin = FractionalOffset.topLeft,
    this.end = FractionalOffset.bottomRight,
    this.colors = const [Color(0xffff9800), Color(0xfff44336)],
    this.darkColors = const [Color(0xff13191f), Color(0xff262f3c)],
    this.stops = const [0.2, 0.8],
    this.loginTitle = "Login",
    this.loginTitleColor = Colors.white,
    this.emailRequiredMessage,
    this.emailNotValidMessage,
    this.enterPasswordMessage,
    this.passwordLabelText,
    this.emailLabelText,
    this.forgotPasswordTextColor = Colors.lightBlue,
    this.loginButtonText = "Login",
    this.signupButtonText = "Signup",
    this.forgotPasswordText = "Forgot password ?",
  }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late ScrollController _scrollController;
  late String _email;
  late String _password;
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    _scrollController = ScrollController();
    _passwordFocusNode = FocusNode();
    _email = "";
    _password = "";
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      key: widget.key,
      begin: widget.begin,
      end: widget.end,
      colors: widget.colors,
      darkColors: widget.darkColors,
      stops: widget.stops,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.loginTitle, style: Theme.of(context).textTheme.headline3!.copyWith(color: widget.loginTitleColor),),
              RoundedContainer(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EmailTextFormField(
                        onChanged: (value) => _email = value,
                        key: widget.key,
                        labelText: widget.emailLabelText,
                        emailValidatorNotValidMessage: widget.emailNotValidMessage ?? "Email not valid",
                        emailValidatorRequiredMessage: widget.emailRequiredMessage ?? "Can't be empty",
                        nextFocusNode: _passwordFocusNode,
                      ),
                      PasswordTextFormField(
                        atLeast8Chars: false,
                        atLeastOneLowerChar: false,
                        atLeastOneNumber: false,
                        atLeastOneUpperChar: false,
                        onChanged: (value) => _password = value,
                        focusNode: _passwordFocusNode,
                        pwdValidatorRequiredMsg: widget.enterPasswordMessage ?? "Enter your password",
                        key: widget.key,
                        labelText: widget.passwordLabelText,
                        isLastFocusNode: true,
                      ),
                      const SizedBox(height: 15,),
                      GradientButton(
                        onPressed: () => onLogin(),
                        buttonText: widget.loginButtonText,
                        darkColors: widget.darkColors,
                        colors: widget.colors,
                        stops: widget.stops,
                      ),
                      GradientButton(
                        onPressed: () {
                          if (widget.useRouteName) {
                            try {
                              Navigator.pushNamed(context, widget.signupRouteName!);
                            } catch (e) {
                              throw Exception("Login view: if you want to use routename, please enter a signupRoutename.\n$e");
                            }
                          } else {
                            try {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => widget.signupView!,
                                  settings: const RouteSettings(name: "Signup")),);
                            } catch (e) {
                              throw Exception("Login view: if you don't want to use routename, please enter a signupView.\n$e");
                            }
                          }
                        },
                        buttonText: widget.signupButtonText,
                        darkColors: widget.darkColors,
                        colors: widget.colors,
                        stops: widget.stops,
                      ),
                      TextButton(
                        onPressed: () {
                          if (widget.useRouteName) {
                            try {
                              Navigator.pushNamed(context, widget.forgotPasswordRouteName!);
                            } catch (e) {
                              throw Exception("Login view: if you want to use routename, please enter a forgotPasswordRoutename.\n$e");
                            }
                          } else {
                            try {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => widget.forgotPasswordView!,
                                  settings: const RouteSettings(name: "ForgotPassword")),);
                            } catch (e) {
                              throw Exception("Login view: if you don't want to use routename, please enter a forgotPasswordView.\n$e");
                            }
                          }
                        },
                        child: Text(widget.forgotPasswordText, style: TextStyle(
                            color: widget.forgotPasswordTextColor,
                            decoration: TextDecoration.underline),
                          ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  void onLogin() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onLogin(_email, _password);
    }
  }
}

