import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';

class customTextfield extends StatelessWidget {
  String? text;
  IconData? icon;
  IconData? icon2;

  String? obscuringCharacter;
  bool obscureText;
  var onchanged;
  TextEditingController? controller;

  void Function(String)? onFieldSubmitted;
  FocusNode? focusNode;
  customTextfield({
    super.key,this.text,this.icon,this.icon2, required this.controller,this.focusNode,
    this.onFieldSubmitted,this.obscuringCharacter,this.obscureText=false,this.onchanged
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Color(0xffA5A5A5)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 24,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                  color: const Color(0xff000000).withOpacity(.1))
            ]),
        child:

        TextFormField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
              hintText: text.toString(),
              hintStyle:
              TextStyle(color: Color(0xffA5A5A5), fontSize: 17),
              prefixIcon: Icon(icon,size: 20,color: Color(0xffA5A5A5),),

              suffixIcon: Icon(icon2),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none)
          ),
          onFieldSubmitted:onFieldSubmitted ,
        )
    );
  }
}