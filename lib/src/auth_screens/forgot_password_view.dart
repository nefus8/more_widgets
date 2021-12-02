import 'package:flutter/material.dart';
import 'package:more_widgets/more_widgets.dart';
import 'package:more_widgets/src/auth_screens/email_text_form_field.dart';

import '../gradient_button.dart';

class ForgotPasswordView extends StatelessWidget {
  final AlignmentGeometry begin, end;
  final List<Color> colors, darkColors;
  final List<double> stops;
  final String forgotPasswordTitle, sendButtonText, backToLoginText;
  final String? emailLabelText, emailNotValidMessage, emailRequiredMessage;
  final Color titleColor, backToLoginTextColor;
  final Function onSendRecoveryEmail;

  String _email = "";

  ForgotPasswordView({
    Key? key,
    this.begin = FractionalOffset.topLeft,
    this.end = FractionalOffset.bottomRight,
    this.colors = const [Color(0xffff9800), Color(0xfff44336)],
    this.darkColors = const [Color(0xff13191f), Color(0xff262f3c)],
    this.stops = const [0.2, 0.8],
    this.forgotPasswordTitle = "Forgot password ?",
    this.titleColor = Colors.white,
    this.emailRequiredMessage,
    this.emailNotValidMessage,
    this.emailLabelText,
    required this.onSendRecoveryEmail,
    this.backToLoginTextColor = Colors.lightBlue,
    this.sendButtonText = "Send recovery email",
    this.backToLoginText = "Back to login",
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
        key: key,
        begin: begin,
        end: end,
        colors: colors,
        darkColors: darkColors,
        stops: stops,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(child: Text(forgotPasswordTitle, style: Theme.of(context).textTheme.headline3!.copyWith(color: titleColor, fontSize: 30),)),
                RoundedContainer(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EmailTextFormField(
                          onChanged: (value) => _email = value,
                          key: key,
                          labelText: emailLabelText,
                          emailValidatorNotValidMessage: emailNotValidMessage ?? "Email not valid",
                          emailValidatorRequiredMessage: emailRequiredMessage ?? "Can't be empty",
                          isLastFocusNode: true,
                        ),
                        const SizedBox(height: 15,),
                        GradientButton(
                          onPressed: () => _onSendRecoveryEmail(),
                          buttonText: sendButtonText,
                          darkColors: darkColors,
                          colors: colors,
                          stops: stops,
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(backToLoginText, style: TextStyle(
                              color: backToLoginTextColor,
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

  void _onSendRecoveryEmail() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      onSendRecoveryEmail(_email);
    }
  }
}
