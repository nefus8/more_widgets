import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberFormField extends StatelessWidget {
  final String? labelText;
  final Function onChanged;
  final FocusNode? nextFocusNode, focusNode;
  final bool isLastFocusNode;
  const PhoneNumberFormField({
    Key? key,
    this.labelText,
    this.focusNode,
    this.isLastFocusNode = false,
    this.nextFocusNode,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      autocorrect: false,
      autofillHints: const [AutofillHints.telephoneNumber],
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9+ ()]',))],
      onChanged: (String value) => onChanged(value.trim().toLowerCase()),
      focusNode: focusNode,
      validator: (value) => phoneValidator(value!),
      onEditingComplete: () => nextFocusNode != null ? nextFocusNode!.requestFocus() : isLastFocusNode ? FocusScope.of(context).unfocus() : {},
      decoration: InputDecoration(
        icon: const Icon(Icons.phone, color: Color(0xFF9E9E9E),),
        labelText: labelText ?? "Phone number",
        labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF9E9E9E))
        ),
      ),
    );
  }

  String? phoneValidator(String s) {
    if (s.trim().isNotEmpty && !(s.trim().length > 9 && s.trim().length < 17)) {
      return "Phone number not valid";
    }
  }
}
