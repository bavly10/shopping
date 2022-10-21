import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shopping/modules/Customer/login/cubit/cubit.dart';
import 'package:shopping/modules/Customer/login/cubit/state.dart';
import 'package:shopping/modules/Customer/customer_home_screen.dart';
import 'package:shopping/shared/compononet/blueButton.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/dialog.dart';
import 'package:shopping/shared/compononet/rowLogin.dart';
import 'package:shopping/shared/compononet/textField.dart';
import 'package:shopping/shared/error_compon.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:shopping/shared/network.dart';


class Login extends StatefulWidget {

  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey();
  @override
  void initState() {
    super.initState();
    emailcontroller=TextEditingController();
    passcontroller=TextEditingController();
  }
  @override
  void dispose() {
    emailcontroller.dispose();
    passcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (ctx, state) {
        if (state is SucessLoginState) {
          navigateToFinish(context,
              CustomerHome(id: LoginCubit.get(context).loginModel!.data!.id));
        } else if (state is ErrorLoginState) {
          if (state.code == "6004") {
            My_CustomAlertDialog(
                onPress: () => Navigator.pop(context),
                pressTitle: 'OK',
                context: context,
                icon: Icons.error,
                bigTitle: mytranslate(context, "nameApp"),
                content: mytranslate(context, "error"),
                pressColor: Colors.red,
                iconColor: Colors.red);
          } else if (state.code == "6005") {
            My_CustomAlertDialog(
                onPress: () => Navigator.pop(context),
                pressTitle: 'OK',
                context: context,
                icon: Icons.error,
                bigTitle:mytranslate(context, "nameApp"),
                content: mytranslate(context, "verfi"),
                pressColor: Colors.red,
                iconColor: Colors.red);
          }else {
            My_CustomAlertDialog(
                onPress: () => Navigator.pop(context),
                pressTitle: 'OK',
                context: context,
                icon: Icons.error,
                bigTitle: mytranslate(context, "nameApp"),
                content: mytranslate(context, "error"),
                pressColor: Colors.red,
                iconColor: Colors.red);
          }
        }else{}
      },
      builder: (ctx, state) {
        final cubit = LoginCubit.get(context);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.10,
                  ),
                  Text(
                    mytranslate(context, "loginText1"),
                    style: TextStyle(
                        color: myBlack,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    mytranslate(
                      context,
                      "loginText2",
                    ),
                    style: TextStyle(color: myBlue, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  MyTextField(
                      validate:(value) => value!.isEmpty ?mytranslate(context, "validateEmail") :validateEmail(value),
                      label: mytranslate(context, "hintogin"),
                      controller: emailcontroller,
                      prefix: Icons.account_circle,
                      type: TextInputType.emailAddress,
                      obcure: false),
                  const SizedBox(
                    height: 25,
                  ),
                  MyTextField(
                      validate: (String? s) {
                        if (s!.isEmpty) {
                          return mytranslate(context, "validatePass");
                        }
                      },
                      label: mytranslate(context, "hintpassword"),
                      controller: passcontroller,
                      prefix: Icons.lock,
                      type: TextInputType.text,
                      obcure: cubit.isPassword,
                      suffix: cubit.iconVisiblity,
                      suffixPressed: () {
                         cubit.changPasswordVisibilty();
                      }),
                  const SizedBox(
                    height: 25,
                  ),
                  TextButton(
                      onPressed: () {
                        navigateTo(context, Scaffold( appBar: AppBar(),body: InAppWebView(initialUrlRequest: URLRequest(url: Uri.parse(forgetPass)))));
                      },
                      child: Text(
                        mytranslate(context, "ForgetPassword"),
                        style: TextStyle(
                            color: myBlue,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 25,
                  ),
                  BlueButton(
                    onpress: () {
                      FocusScope.of(context).unfocus();
                      if (_form.currentState!.validate()) {
                        LoginCubit.get(context).getLogin(emailcontroller.text, passcontroller.text);
                      }
                    },
                    title: state is LoadingLoginState
                        ? CircularProgressIndicator(
                            color: myWhite,
                          )
                        : Text(
                            mytranslate(
                              context,
                              "loginText2",
                            ),
                            style: TextStyle(
                                color: myWhite,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                    hight: 0.08,
                    width: 0.80,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  MyRowLogin(
                      lable1: "text1",
                      lable2: "signup",
                      ontab: () {
                        LoginCubit.get(context).getChangeSCreen();
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
