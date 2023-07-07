import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({

    Key? key,
    required TextEditingController textController,
    required String hint,
    required IconData prefixIcon,
    TextInputType textInputType = TextInputType.text,
    bool obscureText = false,
    TextInputAction textInputAction = TextInputAction.next,
    Function(String value)? onSubmitted,
    String? Function(String? value)? validatte,
  })  : _textController = textController,
        _hint = hint,
        _prefixIcon = prefixIcon,
        _textInputType = textInputType,
        _obscureText = obscureText,
        _textInputAction = textInputAction,
        _onSubmitted = onSubmitted,
        _validate = validatte,
        super(key: key);

  final TextEditingController _textController;
  final String _hint;
  final IconData _prefixIcon;
  final TextInputType _textInputType;
  final bool _obscureText;
  final TextInputAction _textInputAction;
  final void Function(String value)? _onSubmitted;
  final String? Function(String? value)? _validate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: _validate,
      controller: _textController,
      keyboardType: _textInputType,
      textInputAction: _textInputAction,
      // onSubmitted: _onSubmitted,
      obscureText: _obscureText,
      style: GoogleFonts.nunito(),
      decoration: InputDecoration(
        hintText: _hint,
        hintStyle: GoogleFonts.nunito(),
        prefixIcon: Icon(_prefixIcon),
        enabledBorder: buildOutlineInputBorder(color: const Color(0xFF54BAB9)),
        focusedBorder: buildOutlineInputBorder(color: const Color(0xFF18978F)),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 1,
        color: color,
      ),
    );
  }
}
