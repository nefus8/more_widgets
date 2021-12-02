import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  final String? labelText, pwdValidator8CharsMsg, pwdValidatorOneNumberMsg, pwdValidatorOneLowerCharMsg, pwdValidatorOneUpperCharMsg;
  final String pwdValidatorRequiredMsg;
  final Function onChanged;
  final Function? validator;
  final FocusNode? nextFocusNode, focusNode;
  final bool atLeast8Chars, atLeastOneUpperChar, atLeastOneLowerChar, atLeastOneNumber;
  /// If true, will unfocus after editing completed
  final bool isLastFocusNode;
  const PasswordTextFormField({
    Key? key,
    required this.onChanged,
    this.nextFocusNode,
    this.focusNode,
    this.validator,
    this.labelText,
    this.isLastFocusNode = false,
    this.atLeast8Chars = true,
    this.atLeastOneLowerChar = true,
    this.atLeastOneUpperChar = true,
    this.atLeastOneNumber = true,
    required this.pwdValidatorRequiredMsg,
    this.pwdValidator8CharsMsg,
    this.pwdValidatorOneLowerCharMsg,
    this.pwdValidatorOneNumberMsg,
    this.pwdValidatorOneUpperCharMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.text,
      autocorrect: false,
      obscureText: true,
      focusNode: focusNode,
      onChanged: (String value) => onChanged(value),
      onEditingComplete: () => nextFocusNode != null ? nextFocusNode!.requestFocus() : isLastFocusNode ? FocusScope.of(context).unfocus() : {},
      validator: (value) => validator != null ? validator!(value) : _passwordValidator(value!),
      autofillHints: const [AutofillHints.password],
      decoration: InputDecoration(
        icon: const Icon(Icons.lock, color: Color(0xFF9E9E9E),),
        labelText: labelText ?? "Password",
        labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF9E9E9E))
        ),
      ),
    );
  }

  String? _passwordValidator(String value) {
    if (value.trim().isEmpty) {
      return pwdValidatorRequiredMsg;
    } else if (atLeast8Chars && value.length < 8) {
      return pwdValidator8CharsMsg?? "You need at least 8 chars";
    } else if (atLeastOneNumber && !value.contains(RegExp('[0-9]'))) {
      return pwdValidatorOneNumberMsg?? "You need a number";
    } else if (atLeastOneLowerChar && !value.contains(RegExp('[a-z]'))) {
      return pwdValidatorOneLowerCharMsg?? "You need a lower case char";
    } else if (atLeastOneLowerChar && !value.contains(RegExp('[A-Z]'))) {
      return pwdValidatorOneUpperCharMsg?? "You need an upper case char";
    }
    return null;
  }
}