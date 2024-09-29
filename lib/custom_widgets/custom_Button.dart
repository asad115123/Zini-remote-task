import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:google_fonts/google_fonts.dart';
class buttoncustom extends StatefulWidget {

  String? text;
  void Function()? onTap;
  final bool loading;
  buttoncustom({
    super.key,this.text, this.onTap,this.loading=false
  });

  @override
  State<buttoncustom> createState() => _buttoncustomState();
}

class _buttoncustomState extends State<buttoncustom> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 15),
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xff3498D8),
            borderRadius: BorderRadius.circular(10)
        ),
        child:

        Center(child:widget.loading?CircularProgressIndicator(color: Colors.white,): Text(widget.text.toString(),style: GoogleFonts.poppins(textStyle:TextStyle(color: Colors.white,fontSize: 16),),)),

      ),
    );
  }
}
