import 'package:flutter/material.dart';

class EmailTextFormField extends StatelessWidget {
  final String? labelText;
  final String emailValidatorRequiredMessage, emailValidatorNotValidMessage;
  final Function onChanged;
  final Function? validator;
  final FocusNode? nextFocusNode, focusNode;
  final bool isLastFocusNode;
  const EmailTextFormField({
    Key? key,
    required this.onChanged,
    this.nextFocusNode,
    this.focusNode,
    this.labelText,
    this.validator,
    this.isLastFocusNode = false,
    required this.emailValidatorNotValidMessage,
    required this.emailValidatorRequiredMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      focusNode: focusNode,
      onChanged: (String value) => onChanged(value.trim().toLowerCase()),
      onEditingComplete: () => nextFocusNode != null ? nextFocusNode!.requestFocus() : isLastFocusNode ? FocusScope.of(context).unfocus() : {},
      validator: (value) => validator != null ? validator!(value) : _mailValidator(value!),
      autofillHints: const [AutofillHints.email],
      decoration: InputDecoration(
        icon: const Icon(Icons.email, color: Color(0xFF9E9E9E),),
        labelText: labelText ?? "Email",
        labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF9E9E9E))
        ),
      ),
    );
  }

  String? _mailValidator(String value) {
    if (value.trim().isEmpty) {
      return emailValidatorRequiredMessage;
    } else if (!value.contains('@') || !value.contains('.')) {
      return emailValidatorNotValidMessage;
    }
    return null;
  }
}