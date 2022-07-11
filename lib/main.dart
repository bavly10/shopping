import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/my_observer.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/modules/Customer/login/cubit/cubit.dart';
import 'package:shopping/modules/mainScreen/screen/create_product.dart';

import 'package:shopping/modules/shppingCompany/CompanyShpping.dart';
import 'package:shopping/shared/diohelper/dioHelpoer.dart';
import 'package:shopping/shared/localization/set_localization.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:shopping/shared/shared_prefernces.dart';

import 'modules/Splash_screen/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ShopCubit()
              ..getSplashData()
              ..getCategoriesData()
              ..getShippingData()),
        BlocProvider(create: (context) => LoginCubit()),
      ],
      child: BlocBuilder<ShopCubit, ShopStates>(
        builder: (context, state) {
          final cubit = ShopCubit.get(context);
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
            title: "Shopping",
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
            home: CreateProduct(), //SplashScreen(),
            builder: EasyLoading.init(),
          );
        },
      ),
    );
  }
}
