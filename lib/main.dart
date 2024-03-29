import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myshoop/Cubit/cubit.dart';
import 'package:myshoop/Cubit/my_observer.dart';
import 'package:myshoop/Cubit/states.dart';
import 'package:myshoop/modules/Customer/MyOrders/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/login/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/products/cubit/cubit.dart';
import 'package:myshoop/modules/Splash_screen/splash.dart';
import 'package:myshoop/modules/payment/cubit/cubit.dart';
import 'package:myshoop/shared/diohelper/dioHelpoer.dart';
import 'package:myshoop/shared/localization/set_localization.dart';
import 'package:myshoop/shared/my_colors.dart';
import 'package:myshoop/shared/shared_prefernces.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Bloc.observer = MyBlocObserver();
  await CashHelper.init();
  DioHelper.init();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopCubit()..getCruunetLang()..getSplashData()..getVersion()..getLocale()..createDatabase()),
        BlocProvider(create: (context) => LoginCubit()..getPrivacyPolicy()),
        BlocProvider(create: (context) => ProductCubit()..getPrivacyPolicy()),
        BlocProvider(create: (context) => CustomerOrderCubit()..getOrders(context: context)),
        BlocProvider(create: (context) => CustomerCubit()..getStatisticCustomer(LoginCubit.get(context).loginModel?.data?.id, context)),
        BlocProvider(create: (context) => PaymentCubit()),
      ],
      child: BlocBuilder<ShopCubit, ShopStates>(
        builder: (context, state) {
          final cubit = ShopCubit.get(context);
          return Sizer (builder: (context, orientation, deviceType){
            return MaterialApp(
              locale: cubit.locale_cubit,
              localizationsDelegates: const [
                SetLocalztion.localizationsDelegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (deviceLocal, supportedLocales) {
                for (var local in supportedLocales) {
                  if (local.languageCode == deviceLocal!.languageCode &&
                      local.countryCode == deviceLocal.countryCode) {
                    return deviceLocal;
                  }
                }
                return supportedLocales.first;
              },
              supportedLocales: const [
                Locale('en', 'US'), // English, no country code
                Locale('ar', 'SA'), // Spanish, no country code
              ],
              title: "Kash5tak",
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'Cairo',
                appBarTheme: AppBarTheme(
                    titleTextStyle: TextStyle(
                        fontFamily: 'Cairo',
                        color: myBlue,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                    backgroundColor: Colors.white,
                    elevation: 0,
                    centerTitle: true,
                    systemOverlayStyle: const SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark,
                        statusBarBrightness: Brightness.dark),
                    iconTheme: IconThemeData(color: myBlue)),
                scaffoldBackgroundColor: Colors.white,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                primarySwatch: Colors.amber,
              ),
              themeMode: ThemeMode.light,
              home: const SplashScreen(),
              builder: EasyLoading.init(),
            );
          }
          );
        },
      ),
    );
  }
}
