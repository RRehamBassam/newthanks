import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:grafpix/pixloaders/pix_loader.dart';
import 'package:thanks/Screens/BottomNavigationBarScreens/OrdersAdminNotEmpty.dart';
import 'package:thanks/api/NetworkRequest.dart';
import 'package:thanks/items/singleOfferGride.dart';
import 'package:thanks/items/singleOrderTajer.dart';
import 'package:thanks/services/helperFunctions.dart';
import 'package:thanks/widget/loading.dart';
import 'dart:convert' as convert;
import '';
class matjerUser extends StatefulWidget {
  bool tajerAccount;

  matjerUser(this.tajerAccount);

  @override
  _matjerState createState() => _matjerState(tajerAccount);
}

class _matjerState extends State<matjerUser> {
  bool tajerAccount;
  bool Admin;

  _matjerState(this.tajerAccount);
  bool  SearchPersonBox;
  bool Empty;
  String userName;
  int chooseSearch;
  String userImage;
  String textSearch;
  List _notesForDisplay = List();
  List fi = List();
  bool stutsSearch;
  NetworkRequest networkRequest=new NetworkRequest();

  getLoggedInState() async {
    await HelperFunctions.getUserNameSharedPreference().then((value){
      setState(() {
        userName  = value;
      });
    });
  }
  List<String> list=<String>["رز مع لحم","رز مع دجاج","برجر","وجبة مشاوي","رز مع لحم ضاني","وجبة غذائية"];
  Uint8List bytes;
  getImageInState() async {
    await HelperFunctions.getUserImageSharedPreference().then((value){
      setState(() {
        userImage  = value;
        bytes = convert.base64.decode(userImage);
      });
    });
  }
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    _notesForDisplay=[];
    stutsSearch=false;
    SearchPersonBox=false;
    chooseSearch=0;
    getLoggedInState();
    getImageInState();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    Admin=tajerAccount;
    Empty=false;

    // FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    return Column(
      children: [
        BoxTop(),
       GridBox(),
      ],
    );
  }

  Widget GridBox(){
    return FutureBuilder<dynamic>(
        future: networkRequest.getUserMeals(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            fi=snapshot.data;
           if (!stutsSearch){
            _notesForDisplay=snapshot.data;}
           print(stutsSearch);
            return Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child:  RefreshIndicator(
                  onRefresh:networkRequest.getUserMeals,
                  color: Color(0xfff99b1d),
                  backgroundColor: Colors.white,
                  key: refreshKey,
                  child: GridView.count(
                    cacheExtent: 100,
                    crossAxisCount: 2,
                    childAspectRatio: 45/ 60,
                    children: List.generate(_notesForDisplay.length, (index) {
                      return Center(
                        child:singleOffer(_notesForDisplay[index]['name']==null?_notesForDisplay[index]['p_p_meal']:_notesForDisplay[index]['name'],false,false,_notesForDisplay[index],id:_notesForDisplay[index]['id']),
                      );
                    }),
                  ),
                ),
              ) ,
            ); }
          else if (snapshot.hasError) {
            return Center(child: Text("تأكد من إتصال بالإنرنت"));
          }
          // By default, show a loading spinner.
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
              Loading(),
              // Center(
              //   child: PixLoader(
              //       loaderType: LoaderType.Spinner, faceColor: Color(0xfff99b1d)),
              // )
              //CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xfff99b1d) ),)
            ],
          );});
  }
  Widget BoxTop(){
    return   Container(
      padding: EdgeInsets.all(7),
      height: SearchPersonBox?MediaQuery.of(context).size.height * 0.445: MediaQuery.of(context).size.height * 0.265,
      width:MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00,0.00),
            color: Color(0xff000000).withOpacity(0.08),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height:Platform.isIOS?18: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "أهلا بك",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Tajawal",
                  fontSize: 18,
                  color:Color(0xff748a9d),),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              userImage==null? new Container(
                    height: 38.00,
                    width: 38.00,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("Assets/profileIcon.png")
                      ),borderRadius: BorderRadius.circular(6.00),
                    ),
                  ):ClipRRect(
                    borderRadius: BorderRadius.circular(6.00),
                    child: Image.memory(bytes,fit: BoxFit.fitWidth,height: 40.0,width: 40.0,),
                    ),
                  Text(
                    userName!=null?"$userName    ":" ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Tajawal",fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color:Color(0xff3d3b39),
                    ),),
                ],
              )

            ],
          ),
          SizedBox(height:Platform.isIOS?3: 4,),
          Row(
            children: [
              tajerAccount? search():SearchPerson(),
              SizedBox(width:Platform.isIOS?8:12,),
              Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    padding: EdgeInsets.only(right: 16,left: 16),
                    height:  MediaQuery.of(context).size.height * 0.068,
                    width: MediaQuery.of(context).size.width *0.75,
                    decoration: BoxDecoration(
                      color: Color(0xfff5f6fb),borderRadius: BorderRadius.circular(8.00),
                    ),
                    child: TextFormField(//onChanged: (val)=>setState((){searchWord=val;}),
                      cursorColor: Color(0xfff99b1d),


                      onChanged: (val) {
                       // val = val.toLowerCase();

                        setState(() {
                          textSearch = val;
                          stutsSearch=true;
                          _notesForDisplay=[];
                          _notesForDisplay = fi.where((note) {
                            var noteTitle = note['p_p_meal'];
                            print(noteTitle);
                            return noteTitle.contains(val);
                          }).toList();
                        });
                      },

                      // keyboardType:TextInputType.number,
                      decoration: InputDecoration(
                        //  contentPadding: EdgeInsets.only(bottom: 8),
                          border: InputBorder.none,
                          hintText:       "ابحث عن وجبات متاحة ",
                          icon: InkWell(
                              onTap: () =>setState((){
                              }),
                              child: const Icon(Icons.search,color: Color(0xffB0B3CB))),
                          hintStyle:  TextStyle(
                            fontFamily: "Tajawal",
                            fontSize: 13,
                            color:Color(0xffb0b3cb).withOpacity(0.78),
                          ),
                          labelStyle: null
                      ),
                    ),)),
            ],
          ),
          SearchPersonBox?    Directionality(
              textDirection: TextDirection.rtl,child:Container(
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: GridView.count(
                      crossAxisCount: 4,
                      childAspectRatio: 170/ 70,
                      children: List.generate(11, (index) {
                        return Center(
                          child:index!=8?GridSingleItem(index<2?"فرد ${index+1}":index>8?"أفراد ${index}":"أفراد ${index+1}",chooseSearch==index?Color(0xff16BA75):Color(0xfff5f5f5),index):Container(height: 30.88, width: 75.00,),
                        );
                      }),
                    ),
                  ) ,
                ),
              ],
            ),
          )):Container(),

        ],
      ),
    );
  }
  Widget SearchPerson(){
    return InkWell(
        onTap: ()=>setState(()=>{SearchPersonBox=!SearchPersonBox,
          if(!SearchPersonBox)
            {stutsSearch=false}
        }),
        child: SearchPersonBox?new Container(
          height: 40.00,
          width: 40.00,
          decoration: BoxDecoration(
            color: Color(0xfff99b1d),borderRadius: BorderRadius.circular(45.00),
          ),
          child: Center(child: Icon(Icons.clear,color: Colors.white,),),
        ):Image.asset("Assets/SearchPerson.jpg"));
  }
  Widget search(){
    return new Container(
      height:  MediaQuery.of(context).size.height * 0.065,
      width: MediaQuery.of(context).size.width *0.12,
      decoration: BoxDecoration(
        color: Color(0xfff99b1d),borderRadius: BorderRadius.circular(5.00),
      ),
      child:  InkWell(

          child: Center(child:Icon(Icons.search,color: Colors.white,size: 28,))),
    );
  }
  Widget GridSingleItem(String name,Color back,int index){

    return InkWell(
      onTap: ()=>{

      _notesForDisplay=[],

        setState((){


          chooseSearch=index;
      stutsSearch=true;

        _notesForDisplay = fi.where((note) {
        var noteTitle = note['av_meals_count'];
        if(index>8){
          return noteTitle.contains("${index}");}
        else {return noteTitle.contains("${index+1}");}
        }).toList();
      }



      ),},
      child: new Container(
        height: 30.88,
        width: 75.00,
        decoration: BoxDecoration(
          color: back,borderRadius: BorderRadius.circular(6.00),
        ),
        child:
        Center(
          child: new Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Tajawal",fontWeight: FontWeight.w500,
              fontSize: 14,
              color:chooseSearch==index?Color(0xffffffff):Color(0xff888a9c),
            ),
          ),
        ),
      ),
    );
  }

}
