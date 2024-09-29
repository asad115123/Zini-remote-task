import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/custom_Button.dart';
import '../../custom_widgets/custom_Textfield.dart';
import '../../resources/res/String.dart';
import '../../resources/res/image.dart';
import '../../utils/utilss.dart';
import '../authviewModel.dart';


class LOGINSCREEN extends StatefulWidget {
  @override
  State<LOGINSCREEN> createState() => _LOGINSCREENState();
}

class _LOGINSCREENState extends State<LOGINSCREEN> {
  ValueNotifier<bool> obsecuredpassword = ValueNotifier<bool>(true);
  TextEditingController emailController = TextEditingController();
  TextEditingController APIKeyController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode= FocusNode();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    var mediaquerry = MediaQuery.of(context).size;
    final authviewmode = Provider.of<AuthviewModel>(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: mediaquerry.height * 0.08,
              ),
              Text(
                logingtitle,
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xff252525),
                    fontWeight: FontWeight.w500),
              ),
              Text(logingsubtitle,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400,
                    textStyle: TextStyle(color: Color(0xffA5A5A5), fontSize: 16),
                  )),
              SizedBox(
                height: mediaquerry.height * 0.07,
              ),
              customTextfield(
                controller: emailController,
                focusNode: emailFocusNode,
                text: logingEmailtext,
               icon: Icons.email_outlined,
                onFieldSubmitted: (value){
                  Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                },
              ),
              SizedBox(height: 15,),
              ValueListenableBuilder(
                  valueListenable: obsecuredpassword,
                  builder: (context,value,child) {
                    return
                      Container(
                          height: 60,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Color(0xffCAC4D0)),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 24,
                                    offset: const Offset(0, 4),
                                    spreadRadius: 0,
                                    color: const Color(0xff000000).withOpacity(.1))
                              ]),
                          child:
                          TextFormField(
                            obscureText: obsecuredpassword.value,
                            obscuringCharacter: "*",
                            controller: APIKeyController,
                            focusNode: passwordFocusNode,
                            decoration: InputDecoration(
                                hintText: logingPasswordtext,
                                hintStyle:
                                TextStyle(color: Color(0xffA5A5A5), fontSize: 17),
                                prefixIcon: Icon(Icons.key,size: 22,color: Color(0xffA5A5A5),),

                                suffixIcon: InkWell(
                                    onTap: () {
                                      obsecuredpassword.value =
                                      ! obsecuredpassword.value;
                                    },
                                    child: Icon( obsecuredpassword.value ?
                                    Icons.visibility_off_sharp : Icons.visibility,
                                      color: Color(0xffA5A5A5),)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none)
                            ),
                            onFieldSubmitted: (value) {
                              Utils.fieldFocusChange(
                                  context, emailFocusNode, passwordFocusNode);
                            },
                          )
                      );

                  }
              ),


              SizedBox(height: mediaquerry.height*0.041,),
              buttoncustom(
                  text: loginbuttontext,
                  loading: authviewmode.loading,
                  onTap: (){
                    if(emailController.text.isEmpty){
                      Utils.flushbarErrormesg("Enter Email", context);
                    }
                    else if(APIKeyController.text.isEmpty){
                      Utils.flushbarErrormesg("Enter API key", context);
                    }
                    else{
                      Map data = {
                        'email':emailController.text.toString(),
                        'apiKey':APIKeyController.text.toString(),
                        // "deviceToken":"3din203rh20n4204f2n0c840f9"
                      };
                      authviewmode.LoginApi(data, context);
                    }
                  }
              ),
              SizedBox(height: 19,),
              Text("Or Continue With",
                style: TextStyle(fontSize: 16,
                    color: Color(0xff252525),
                    fontWeight: FontWeight.w500),),
              SizedBox(height: 17,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Loginpageimage2,height: 59,),
                  SizedBox(width: 15,),
                  Image.asset(Loginpageimage3,height: 59,),
                  SizedBox(width: 15,),
                  Image.asset(Loginpageimage4,height: 59,),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}