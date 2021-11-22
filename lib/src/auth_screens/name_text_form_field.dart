import 'package:flutter/material.dart';

class NameTextFormField extends StatelessWidget {
  final String? firstNameLabelText, lastNameLabelText;
  final String nameValidatorRequiredMessage;
  final Function onChangedLastName;
  final Function onChangedFirstName;
  final Function? validator;
  final FocusNode? nextFocusNode, focusNode;
  final bool isLastFocusNode;

  NameTextFormField({
    Key? key,
    required this.onChangedLastName,
    required this.onChangedFirstName,
    this.nextFocusNode,
    this.focusNode,
    this.firstNameLabelText,
    this.lastNameLabelText,
    this.validator,
    this.isLastFocusNode = false,
    required this.nameValidatorRequiredMessage,
  }) : super(key: key);

  final FocusNode lastNameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.name,
            autocorrect: false,
            focusNode: focusNode,
            onChanged: (String value) => onChangedFirstName(value.trim().toLowerCase()),
            onEditingComplete: () => lastNameFocusNode.requestFocus(),
            validator: (value) => validator != null ? validator!(value) : _nameValidator(value!),
            autofillHints: const [AutofillHints.givenName],
            decoration: InputDecoration(
              icon: const Icon(Icons.person, color: Color(0xFF9E9E9E),),
              labelText: firstNameLabelText ?? "First name",
              labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF9E9E9E))
              ),
            ),
          ),
        ),
        const SizedBox(width: 20,),
        Expanded(
          child: TextFormField(
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.name,
            autocorrect: false,
            focusNode: lastNameFocusNode,
            onChanged: (String value) => onChangedLastName(value.trim().toLowerCase()),
            onEditingComplete: () => nextFocusNode != null ? nextFocusNode!.requestFocus() : isLastFocusNode ? FocusScope.of(context).unfocus() : {},
            validator: (value) => validator != null ? validator!(value) : _nameValidator(value!),
            autofillHints: const [AutofillHints.familyName],
            decoration: InputDecoration(
              labelText: lastNameLabelText ?? "Last name",
              labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF9E9E9E))
              ),
            ),
          ),
        ),
      ],
    );
  }

  String? _nameValidator(String value) {
    if (value.trim().isEmpty) {
      return nameValidatorRequiredMessage;
    }
    return null;
  }
}