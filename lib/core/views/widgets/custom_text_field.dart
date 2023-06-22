import 'package:flutter/material.dart';
import 'package:josequal_papers/utils/utils.dart';

class CustomTextField extends StatefulWidget {
   CustomTextField({
    super.key,
    required this.controller,
    required this.isSecure,
    required this.isReadOnly,
    required this.isFilled,
    this.fillColor,
    required this.hintText,
    required this.title,
    this.sufixAction,
    this.sufixWidget,
    this.prefixWidget,
    this.onTap,
    this.onSaved,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onChanged,
    this.validator,
    this.inputType,
  });

  TextEditingController controller;
  bool isSecure, isReadOnly, isFilled;
  String hintText, title;
  VoidCallback? sufixAction, onTap;
  Function(String?)? onSaved;
  Function(String?)? onChanged;
  Function(String?)? onFieldSubmitted;
  Function()? onEditingComplete;
  String? Function(String?)? validator;
  Widget? prefixWidget, sufixWidget;
  Color? fillColor;
  TextInputType? inputType;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    Size size = AppConsts.size;
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    letterSpacing: 1,
                  ),
            ),
          ),
          (size.height * .01).height,
          TextFormField(
            keyboardType: widget.inputType,
            style: const TextStyle(color: Colors.black87),
            cursorWidth: 1,
            cursorColor: Colors.black87,
            validator: widget.validator,
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onFieldSubmitted,
            onEditingComplete: widget.onEditingComplete,
            onSaved: widget.onSaved,
            controller: widget.controller,
            obscureText: widget.isSecure,
            readOnly: widget.isReadOnly,
            decoration: InputDecoration(
              isDense: true,
              hoverColor: Colors.black45,
              focusColor: Colors.black87,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              filled: widget.isFilled,
              fillColor: widget.fillColor,
              hintText: widget.hintText,
              suffixIcon: widget.sufixWidget,
              prefixIcon: widget.prefixWidget,
            ),
          )
        ],
      ),
    );
  }
}
