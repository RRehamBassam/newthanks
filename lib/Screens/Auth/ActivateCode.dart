
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:provider/provider.dart';
import 'package:thanks/Screens/Auth/CreateAccount.dart';
import 'package:thanks/Screens/Home.dart';
import 'package:thanks/api/NetworkRequest.dart';
import 'package:thanks/models/User.dart';
import 'package:thanks/models/providerUser.dart';
import 'package:thanks/services/helperFunctions.dart';
import 'package:thanks/widget/backgroungtextfielid.dart';
import 'package:thanks/widget/buttonUnfill.dart';

class ActivateCode extends StatefulWidget {


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<ActivateCode> {
  String smsOTP;
  String phoneNumber;
  String changePass;
  NetworkRequest networkRequest=new NetworkRequest();
  @override
  Widget build(BuildContext context) {
    String tokenUser =
        Provider.of<providerUser>(context, listen: true).tokenUser;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      //  resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              height: MediaQuery.of(context).size.height * 0.888,
              width:MediaQuery.of(context).size.width ,
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(40), bottomLeft: Radius.circular(40)),
                  boxShadow: [BoxShadow(
                      color: Color.fromRGBO(34, 134, 234, .3),
                      blurRadius: 20,
                      offset: Offset(0, 10)
                  )]
              ),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height *0.03,
                    child: Row(
                      children: [
                        Container(),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 38,horizontal: 18),
                          child:InkWell (
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child:Icon(Icons.arrow_forward_ios)),
                        )
                      ],
                    ),

                  ),
                  Container(
                    height: MediaQuery.of(context).size.height *0.37,
                    child:partOne() ,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height *0.209,
                    child:partTwo() ,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height *0.259,
                    child:partThree(tokenUser) ,
                  ),
                ],
              ),
            ),

            Container(
              height: MediaQuery.of(context).size.height *0.11,
              //color:Color(0xFFDBE2ED) ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    //onTap: ()=>Navigator.push(context, new MaterialPageRoute(builder: (context)=>  CreateAccount(true))),
                      child:Text(
                        "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Tajawal",fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color:Color(0xff888a9c),
                        ),
                      ))
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
  bool _obscureText=true;
  Widget partOne(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 25,),
        Image.asset("Assets/logo.png"),
      ],
    );}
  Widget partTwo(){
    return Column(
      children: [


        Container(
          height: MediaQuery.of(context).size.height*0.06,
          child: Text(
            "من فضلك ادخل رقم جوالك لاستعادة كلمة المرور",
            style: TextStyle(
              fontFamily: "Tajawal",fontWeight: FontWeight.w700,
              fontSize: 14,
              color:Color(0xff4b4a4a),
            ),
          ),
        ),
        SizedBox(height: 16,),
        new Container(

            height: MediaQuery.of(context).size.height*0.08,
            width: MediaQuery.of(context).size.width*0.82,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.00),
            ),
            child:
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // padding: EdgeInsets.only(top: 15),
                 //  width: MediaQuery.of(context).size.width* 0.75,
                    child:  Center(
                      child: PinEntryTextField(
                        fields: 6,

                        showFieldAsBox: true, onSubmit: (String pin){
                        setState(() {
                          smsOTP=pin;
                          // ActiationCode=pin;
                        });
                        // showDialog(context: context, builder: (context){
                        //           return AlertDialog(
                        //             title: Text("Pin"),
                        //             content: Text('Pin entered is $pin'),
                        //           );}
                        //           );
                      },),
                    ),
                  ),
                ],
              ),
            )
        ),
        SizedBox(height: 8,),

        SizedBox(height: 16,),
        // Container(
        //   width: MediaQuery.of(context).size.width* 0.8,
        //   child: Align(
        //     alignment:Alignment.centerRight,
        //     child: new Text(
        //       "نسيت كلمة المرور؟",
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //         fontFamily: "Tajawal",fontWeight: FontWeight.w500,
        //         fontSize: 16,
        //         color:Color(0xffa6bcd0),
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
  Widget partThree(String tokenUser){
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        message!=null?Text(message,style: TextStyle(color: Colors.red),):Container(),
        SizedBox(height: 20,),
        button(phoneNumber,changePass,tokenUser),
        SizedBox(height: 8,),
        InkWell(
          //onTap: ()=>Navigator.push(context, new MaterialPageRoute(builder: (context)=>  CreateAccount(false))),
            child:
            Container(
              height: MediaQuery.of(context).size.width*0.11,
              width: MediaQuery.of(context).size.width*0.82,
              decoration: BoxDecoration(
                // color: Color(0xfff99b1d),
                border: Border.all(width: 2.00, color: Color(0x0099b1d),), borderRadius: BorderRadius.circular(36.00),
              ),
              child:  Center(
                child: Text(
                  "",
                  style: TextStyle(
                    fontFamily: "Tajawal",fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color:Color(0xff4b4a4a),
                  ),
                ),
              ),
            )),
        message!=null?SizedBox(height: 22,) :SizedBox(height: 27,),
      ],
    );
  }
  dynamic Output;
  String message;
  User user;
  bool userIsAminIn;
  getAdminInState() async {
    await HelperFunctions.getUserAdminSharedPreference().then((value){
      setState(() {
        userIsAminIn  = value;
      });
    });
  }

  getLoggedInState(String tokenUser) async {
    await networkRequest.login("966"+"$phoneNumber",changePass,tokenUser).then((value){
      setState(() {
        Output  = value;
      });
    });
    if(Output is String){
      setState(() {message=Output;});
    }else{
      user=Output;
      await  getAdminInState();
      HelperFunctions.saveUserNameSharedPreference(user.name);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_){
            return Home(userIsAminIn);
          }),(route)=> false
      );
      // Navigator.push(context, new MaterialPageRoute(builder: (context)=>  Home(false)));
    }
  }
  Future<void> signIn2(String smsCode) async{
    final AuthCredential credential = PhoneAuthProvider.getCredential(
     // verificationId: verificationId,
      smsCode: smsCode,);

    await FirebaseAuth.instance.signInWithCredential(
        credential).then((user) async {
    //  await s();

    }).catchError((e){
      // if(!LoginCode) {
      //   Fluttertoast.showToast(
      //       msg: "ادخل كود صحيح",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.BOTTOM,
      //       timeInSecForIosWeb: 1,
      //       backgroundColor: Color(0xff38056e).withOpacity(0.9),
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      // }
      print(e);
    });
  }
  Widget button(String phone ,String pass,String tokenUser){
    return InkWell(
      onTap: ()=>{
      if(smsOTP!=null)
      FirebaseAuth.instance.currentUser().then((user){

      //  Navigator.of(context).pop();
      signIn2(smsOTP);

      })
       // getLoggedInState(tokenUser)
        // if (itemCount is Map) {
        //   return [];
        //   }
        // networkRequest.login("",""),


      },
      child: new Container(
        height: MediaQuery.of(context).size.width*0.15,
        width: MediaQuery.of(context).size.width*0.82,
        decoration: BoxDecoration(
          color: Color(0xfff99b1d),borderRadius: BorderRadius.circular(50.00),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back,color: Colors.white,size: 15,),
              SizedBox(width: 6,),
              Text(
                "استعادة كلمة المرور",
                style: TextStyle(
                  fontFamily: "Tajawal",fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color:Color(0xffffffff),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
