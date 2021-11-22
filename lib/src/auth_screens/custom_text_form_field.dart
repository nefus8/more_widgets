import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {final String? labelText;
final Function onChanged;
final Function? validator;
final FocusNode? nextFocusNode, focusNode;
final bool isLastFocusNode;
  const CustomTextFormField({
    Key? key,
    required this.onChanged,
    this.nextFocusNode,
    this.focusNode,
    this.labelText,
    this.validator,
    this.isLastFocusNode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.text,
      autocorrect: true,
      focusNode: focusNode,
      onChanged: (String value) => onChanged(value.trim().toLowerCase()),
      onEditingComplete: () => nextFocusNode != null ? nextFocusNode!.requestFocus() : isLastFocusNode ? FocusScope.of(context).unfocus() : {},
      validator: (value) => validator != null ? validator!(value) : null,
      autofillHints: const [AutofillHints.email],
      decoration: InputDecoration(
        icon: const Icon(Icons.edit, color: Color(0xFF9E9E9E),),
        labelText: labelText ?? "Custom",
        labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF9E9E9E))
        ),
      ),
    );
  }
}
