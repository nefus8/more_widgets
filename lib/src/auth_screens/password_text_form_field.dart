import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  final String? labelText;
  final String passwordValidatorMessage;
  final Function onChanged;
  final Function? validator;
  final FocusNode? nextFocusNode, focusNode;
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
    required this.passwordValidatorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.text,
      autocorrect: false,
      obscureText: true,
      focusNode: focusNode,
      onChanged: (String value) => onChanged(value.trim().toLowerCase()),
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
      return passwordValidatorMessage;
    }
    return null;
  }
}