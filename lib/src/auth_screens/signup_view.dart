import 'package:flutter/material.dart';
import 'package:more_widgets/more_widgets.dart';
import 'package:more_widgets/src/auth_screens/email_text_form_field.dart';
import 'package:more_widgets/src/auth_screens/password_text_form_field.dart';
import 'package:more_widgets/src/gradient_button.dart';

class SignupView extends StatefulWidget {
  final AlignmentGeometry begin, end;
  final List<Color> colors, darkColors;
  final List<double> stops;
  final String signupTitle, signupButtonText, backToLoginText;
  final String? emailLabelText, passwordLabelText, confirmPasswordLabelText, emailNotValidMessage, emailRequiredMessage, enterPasswordMessage, confirmPasswordMessage;
  final Color signupTitleColor, backToLoginTextColor;
  final Function? onSignup;

  final String? signupDetailsRouteName;
  final Widget? signupDetailsView;
  final bool useRouteName;
  const SignupView({
    Key? key,
    required this.onSignup,
    this.signupDetailsRouteName,
    this.signupDetailsView,
    this.useRouteName = true,
    this.begin = FractionalOffset.topLeft,
    this.end = FractionalOffset.bottomRight,
    this.colors = const [Color(0xffff9800), Color(0xfff44336)],
    this.darkColors = const [Color(0xff13191f), Color(0xff262f3c)],
    this.stops = const [0.2, 0.8],
    this.signupTitle = "Signup",
    this.signupTitleColor = Colors.white,
    this.emailRequiredMessage,
    this.emailNotValidMessage,
    this.enterPasswordMessage,
    this.confirmPasswordMessage,
    this.passwordLabelText,
    this.emailLabelText,
    this.confirmPasswordLabelText,
    this.backToLoginTextColor = Colors.lightBlue,
    this.signupButtonText = "Signup",
    this.backToLoginText = "Back to login",
  }) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late ScrollController _scrollController;
  late String _email;
  late String _password;
  late FocusNode _passwordFocusNode, _confirmPasswordFocusNode;

  @override
  void initState() {
    _scrollController = ScrollController();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    _email = "";
    _password = "";
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
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
                Text(widget.signupTitle, style: Theme.of(context).textTheme.headline3!.copyWith(color: widget.signupTitleColor),),
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
                          onChanged: (value) => _password = value,
                          focusNode: _passwordFocusNode,
                          nextFocusNode: _confirmPasswordFocusNode,
                          pwdValidatorRequiredMsg: widget.enterPasswordMessage ?? "Enter your password",
                          key: widget.key,
                          labelText: widget.passwordLabelText,
                        ),
                        PasswordTextFormField(
                          onChanged: (_) {},
                          focusNode: _confirmPasswordFocusNode,
                          validator: (String value) => value != _password ? widget.confirmPasswordMessage ?? "Password doesn't match" : null,
                          key: widget.key,
                          labelText: widget.confirmPasswordLabelText ?? "Confirm password",
                          isLastFocusNode: true,
                          pwdValidatorRequiredMsg: '',
                        ),
                        const SizedBox(height: 15,),
                        GradientButton(
                          onPressed: () => onSignup(),
                          buttonText: widget.signupButtonText,
                          darkColors: widget.darkColors,
                          colors: widget.colors,
                          stops: widget.stops,
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(widget.backToLoginText, style: TextStyle(
                              color: widget.backToLoginTextColor,
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

  void onSignup() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.onSignup != null) {
        widget.onSignup!(_email, _password);
      }
      if (widget.useRouteName) {
        try {
          Navigator.pushNamed(context, widget.signupDetailsRouteName!);
        } catch (e) {
          throw Exception("Login view: if you want to use routename, please enter a signupDetailsRoutename.\n$e");
        }
      } else {
        try {
          Navigator.push(context, MaterialPageRoute(builder: (context) => widget.signupDetailsView!,
              settings: const RouteSettings(name: "Signup")),);
        } catch (e) {
          throw Exception("Login view: if you don't want to use routename, please enter a signupDetailsView.\n$e");
        }
      }
    }
  }
}
