import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class StyledTextField extends StatelessWidget {
  final String name;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final BorderSide? focusedBorderSide;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final String? initialValue;
  final bool obscureText;
  final bool readOnly;
  final int? minLines;
  final int? maxLength;
  final ValueChanged<String?>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final String? Function(String?)? onSubmitted;
  final Function? onEditingComplete;
  final bool enabled;
  final bool isMaxLines;
  final int? maxLines;
  final Widget? suffixIcon;

  const StyledTextField({
    Key? key,
    required this.name,
    this.initialValue,
    this.obscureText = false,
    this.keyboardType,
    this.focusNode,
    this.validator,
    this.hintText,
    this.labelText,
    this.focusedBorderSide,
    this.prefixIcon,
    this.readOnly = false,
    this.minLines,
    this.maxLength,
    this.onChanged,
    this.inputFormatters,
    this.onSubmitted,
    this.onEditingComplete,
    this.textEditingController,
    this.enabled = true,
    this.suffixIcon,
    this.maxLines,
    this.isMaxLines = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete as void Function()?,
      maxLines: isMaxLines == false ? 1 : maxLines!,
      minLines: minLines,
      maxLength: maxLength,
      onChanged: onChanged,
      readOnly: readOnly,
      controller: textEditingController,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      initialValue: initialValue,
      textInputAction: TextInputAction.next,
      name: name,
      enabled: enabled,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          counter: const SizedBox(),
          prefix: prefixIcon,
          labelText: labelText,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(10))),
    );
  }
}
