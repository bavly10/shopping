import 'package:flutter_easyloading/flutter_easyloading.dart';

myToast({required String message}) => EasyLoading.showToast(message,
    toastPosition: EasyLoadingToastPosition.bottom,
    duration: const Duration(seconds: 1));