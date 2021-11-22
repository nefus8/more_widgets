import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:more_widgets/more_widgets.dart';
import 'package:more_widgets/src/auth_screens/custom_text_form_field.dart';
import 'package:more_widgets/src/auth_screens/name_text_form_field.dart';
import 'package:more_widgets/src/auth_screens/phone_number_form_field.dart';
import 'package:more_widgets/src/gradient_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SignupDetailsView extends StatefulWidget {
  final AlignmentGeometry begin, end;
  final List<Color> colors, darkColors;
  final List<double> stops;
  final String detailsTitle, confirmButtonText, backToSignupText, confidentialityUrl;
  final String? firstNameLabelText, lastNameLabelText, nameRequiredMessage, nicknameLabel, policyNotAcceptedMessage, policyNotAcceptedTitle;
  final Color signupTitleColor, backToLoginTextColor;
  final Function? onConfirm;

  final String? confidentialityText, confidentialityButtonText;

  const SignupDetailsView({
    Key? key,
    required this.confidentialityUrl,
    required this.onConfirm,
    this.policyNotAcceptedMessage,
    this.policyNotAcceptedTitle,
    this.begin = FractionalOffset.topLeft,
    this.end = FractionalOffset.bottomRight,
    this.colors = const [Color(0xffff9800), Color(0xfff44336)],
    this.darkColors = const [Color(0xff13191f), Color(0xff262f3c)],
    this.stops = const [0.2, 0.8],
    this.detailsTitle = "Account details",
    this.signupTitleColor = Colors.white,
    this.nameRequiredMessage,
    this.firstNameLabelText,
    this.lastNameLabelText,
    this.confidentialityButtonText,
    this.confidentialityText,
    this.nicknameLabel,
    this.backToLoginTextColor = Colors.lightBlue,
    this.confirmButtonText = "Confirm",
    this.backToSignupText = "Back to signup",
  }) : super(key: key);

  @override
  State<SignupDetailsView> createState() => _SignupDetailsViewState();
}

class _SignupDetailsViewState extends State<SignupDetailsView> {
  late ScrollController _scrollController;
  bool _hasCheckedConfidentiality = false;
  late FocusNode _nickNameNode, _phoneNumberNode;
  late String _nickName, _firstName, _lastName, _phoneNumber;

  @override
  void initState() {
    _scrollController = ScrollController();
    _phoneNumberNode = FocusNode();
    _nickNameNode = FocusNode();
    _nickName = "";
    _firstName = "";
    _lastName = "";
    _phoneNumber = "";
    super.initState();
  }

  @override
  void dispose() {
    _nickNameNode.dispose();
    _phoneNumberNode.dispose();
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
                Text(widget.detailsTitle, style: Theme.of(context).textTheme.headline3!.copyWith(color: widget.signupTitleColor),),
                RoundedContainer(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NameTextFormField(
                          onChangedFirstName: (String value) => _firstName = value.trim(),
                          onChangedLastName: (String value) => _lastName = value.trim(),
                          nameValidatorRequiredMessage: widget.nameRequiredMessage?? "This field is required",
                          firstNameLabelText: widget.firstNameLabelText?? "First name",
                          lastNameLabelText: widget.lastNameLabelText?? "Last name",
                          nextFocusNode: _nickNameNode,
                        ),
                        CustomTextFormField(
                          onChanged: (String value) => _nickName = value.trim(),
                          labelText: widget.nicknameLabel?? "Nickname",
                          focusNode: _nickNameNode,
                          nextFocusNode: _phoneNumberNode,
                        ),
                        PhoneNumberFormField(
                          onChanged: (String value) => _phoneNumber = value.trim(),
                          focusNode: _phoneNumberNode,
                          isLastFocusNode: true,
                        ),
                        CheckboxListTile(
                          title: _getRichText(context),
                          dense: true,
                          value: _hasCheckedConfidentiality,
                          onChanged: (value) => setState(() {_hasCheckedConfidentiality = value!;}),
                          //controlAffinity: ListTileControlAffinity.leading,
                        ),
                        GradientButton(
                          onPressed: () => onConfirm(context),
                          buttonText: widget.confirmButtonText,
                          darkColors: widget.darkColors,
                          colors: widget.colors,
                          stops: widget.stops,
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(widget.backToSignupText, style: TextStyle(
                              color: widget.backToLoginTextColor,
                              decoration: TextDecoration.underline)
                            ,
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

  Widget _getRichText(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey.shade700, fontSize: 13),
            text: widget.confidentialityText ?? "Do you agree with the ",
          ),
          TextSpan(
            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.red, fontSize: 13, decoration: TextDecoration.underline),
            text: widget.confidentialityButtonText ?? "policy",
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                String url = widget.confidentialityUrl;
                if (await canLaunch(url)) {
                  await launch(
                    url,
                    forceSafariVC: false,
                  );
                }
              },
          ),
        ],
      ),
    );
  }

  void onConfirm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_hasCheckedConfidentiality) {
        _formKey.currentState!.save();
        if (widget.onConfirm != null) {
          /// Call back for firstName [String], lastName [String], nickName [String?], phoneNumber [String?], hasAcceptedConfidentiality
          widget.onConfirm!(_firstName, _lastName, _nickName, _phoneNumber, _hasCheckedConfidentiality);
        }
      } else {
        Dialogs.infoDialog(context: context,
            title: widget.policyNotAcceptedTitle?? "Warning",
            message: widget.policyNotAcceptedMessage?? "You need to accept the confidentiality policy to create an account."
        );
      }
    }
  }
}
