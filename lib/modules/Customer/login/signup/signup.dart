import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopping/modules/Customer/login/cubit/cubit.dart';
import 'package:shopping/modules/Customer/login/cubit/state.dart';
import 'package:shopping/shared/compononet/blueButton.dart';
import 'package:shopping/shared/compononet/dialog.dart';
import 'package:shopping/shared/compononet/rowLogin.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Signup extends StatelessWidget {
  var pageController = PageController();
  Signup({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (ctx, state) {
        if (state is SucessSignupState) {
          if (state.response.status == false &&
              state.response.errorCode == 6003) {
            My_CustomAlertDialog(
                onPress: () => Navigator.pop(context),
                pressTitle: 'OK',
                context: context,
                icon: Icons.error,
                bigTitle: "shopping",
                content:
                    "${state.response.msg} ${mytranslate(context, "errorregister")}",
                pressColor: Colors.red,
                iconColor: Colors.red);
          } else {
            My_CustomAlertDialog(
                onPress: () => Navigator.pop(context),
                pressTitle: 'OK',
                context: context,
                icon: Icons.done,
                bigTitle: "shopping",
                content: state.response.msg,
                pressColor: Colors.lightBlueAccent,
                iconColor: Colors.green);
          }
        } else {}
      },
      builder: (ctx, state) {
        final cubit = LoginCubit.get(context);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  mytranslate(context, "signup1"),
                  style: TextStyle(
                      color: myBlack,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  mytranslate(context, "signup2"),
                  style: TextStyle(color: myBlue, fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: double.infinity,
                  color: Colors.white,
                  child: PageView.builder(
                    onPageChanged: (index) {
                      LoginCubit.get(context).getLastIndex(index);
                      LoginCubit.get(context).changeindexpager(index);
                    },
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, i) {
                      return cubit.myList[i];
                    },
                    itemCount: cubit.myList.length,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: mySmooth(cubit.myList),
                ),
                const SizedBox(
                  height: 15,
                ),
                buttonNP(pageController, context, state is LoadingSignupState),
                MyRowLogin(
                    lable1: "text1",
                    lable2: "signin",
                    ontab: () {
                      LoginCubit.get(context).getChangeSCreen();
                    })
              ],
            ),
          ),
        );
      },
    );
  }

  Widget mySmooth(myList) {
    return SmoothPageIndicator(
      controller: pageController,
      count: myList.length,
      effect: const ExpandingDotsEffect(
          expansionFactor: 4,
          dotColor: Colors.grey,
          dotWidth: 10,
          dotHeight: 10,
          spacing: 5.0),
    );
  }

  Widget buttonNP(PageController pagecontroller, context, bool state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (LoginCubit.get(context).changepager != 0)
          BlueButton(
              title: Text(mytranslate(context, "prev"),
                  style: TextStyle(
                      color: myWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              hight: 0.08,
              width: 0.35,
              icon: Icons.arrow_back,
              onpress: () {
                pagecontroller.animateToPage(pagecontroller.page!.toInt() - 1,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn);
              }),
        LoginCubit.get(context).lastIndex
            ? BlueButton(
                title: state
                    ? SpinKitCircle(
                        color: Colors.white,
                      )
                    : Text(mytranslate(context, "finish"),
                        style: TextStyle(
                            color: myWhite,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                hight: 0.09,
                width: 0.30,
                icon: Icons.done_all,
                onpress: () {
                  LoginCubit.get(context).signUp();
                })
            : BlueButton(
                title: Text(mytranslate(context, "next"),
                    style: TextStyle(
                        color: myWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                hight: 0.09,
                width: 0.30,
                onpress: () {
                  pagecontroller.animateToPage(pagecontroller.page!.toInt() + 1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeIn);
                }),
      ],
    );
  }
}
