import 'package:dots_indicator/dots_indicator.dart';
import 'package:first_project/common/values/colors.dart';
import 'package:first_project/main.dart';
import 'package:first_project/pages/welcome/bloc/welcome_blocs.dart';
import 'package:first_project/pages/welcome/bloc/welcome_events.dart';
import 'package:first_project/pages/welcome/bloc/welcome_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key : key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: BlocBuilder<WelcomeBloc,WelcomeState>(
          builder: (context,state){
            return Container(
              margin: EdgeInsets.only(top:34.h),
              width: 375.w,
              child: Stack(
                alignment: Alignment.topCenter,
                children:[
                  PageView(
                    controller: pageController,
                    onPageChanged: (index){
                      state.page = index;
                      BlocProvider.of<WelcomeBloc>(context).add(WelcomeEvent());
                      print("index value is ${index}");
                    },
                    children: [
                      _page(
                          1,
                          context,
                          "Next",
                          "First see Learning",
                          "Forget about a for of paper all knowledge in on learing",
                          "assets/images/reading.png"
                      ),
                      _page(
                          2,
                          context,
                          "Next",
                          "Connect With Everyone",
                          "Alway keep in touch with your tutor and friend. Let's get connect",
                          "assets/images/boy.png"
                      ),
                      _page(
                          3,
                          context,
                          "Get Started",
                          "Always Fascianted Learing",
                          "Anywhere, Anytime, You can make friend with anyone ",
                          "assets/images/man.png"
                      )

                    ],
                  ),
                  Positioned(
                    bottom: 80.h,
                    child: DotsIndicator(
                      position: state.page,
                      dotsCount: 3,
                      mainAxisAlignment: MainAxisAlignment.center,
                      decorator: DotsDecorator(
                          color: AppColors.primaryThirdElementText,
                          activeColor: AppColors.primaryElement,
                          size: const Size.square(8.0),
                          activeSize: const Size(15.0, 8.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)
                          )

                      ),

                    ),
                  )
                ],
              ),

            );
          },
        )

      ),
    );
  }
  Widget _page(int index, buildContext, String buttonName, String title, String subTitle ,String imagePath){
     return Column(
       children: [
         SizedBox(
           width: 345.w,
           height: 345.w,
           child: Image.asset(
               imagePath,
               fit: BoxFit.cover,
           ),
           ),

         Container(
           child: Text(
             title,
             style: TextStyle(
                 color: AppColors.primaryText,
                 fontSize: 24.sp,
                 fontWeight: FontWeight.normal
             ),
           ),
         ),
         Container(
           width: 375.w,
           padding: EdgeInsets.only(left: 30.w, right : 30.w),
           child: Text(
             subTitle,
             style: TextStyle(
                 color: AppColors.primarySecondaryElementText,
                 fontSize: 14.sp,
                 fontWeight: FontWeight.normal
             ),
           ),
         ),
         GestureDetector(
           onTap: (){
             //within 0-2 index
             if(index<3){
               //animation
               pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
             }else{
               // jump to a new page
             //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomePage()));
               Navigator.of(context).pushNamedAndRemoveUntil("signIn", (route) => false);
             }
           },
           child: Container(
             margin: EdgeInsets.only(top:100.h, left: 25.w, right: 25.w),
             width: 325.w,
             height: 50.h,
             decoration: BoxDecoration(
                 color: AppColors.primaryElement,
                 borderRadius: BorderRadius.all(Radius.circular(15.w)),
                 boxShadow:[
                   BoxShadow(
                       color: Colors.grey.withOpacity(0.5),
                       spreadRadius: 1,
                       blurRadius: 2,
                       offset: Offset(0,1)
                   )
                 ]
             ),
             child: Center(
               child:Text(buttonName,
                 style: TextStyle(
                     color: Colors.white,
                     fontSize: 20.sp,
                     fontWeight: FontWeight.normal
                 ),
               ),
             ),
           ),
         )
       ],

     );
  }

  }

