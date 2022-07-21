import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/model/ProductsCustomer.dart';
import 'package:shopping/modules/Customer/cubit/state.dart';
import 'package:shopping/shared/diohelper/dioHelpoer.dart';

import '../../../shared/network.dart';

class CustomerCubit extends Cubit<CustomerStates> {
  CustomerCubit() : super(Customer_InitalState());

  static CustomerCubit get(context) => BlocProvider.of(context);

// ignore: non_constant_identifier_names
  List<ProductsItem> list = [];

  Future getProductCustomer(id) async {
    emit(ProductCustomerLoading());
    list = [];
    Map<String, dynamic> data = {"user_id": id};
    await DioHelper.postData(url: getProducts, data: data).then((value) {
      final res = value.data['data'];
      for (var value in res) {
        final pro = list.indexWhere(
          (element) => element.id == value["id"].toString(),
        );
        if (pro >= 0) {
          list[pro] = ProductsItem(
            id: value["id"].toString(),
            title: value["title"],
            price: value["price"],
            desc: value["desc"],
            image: value["image"],
          );
        } else {
          list.add(ProductsItem(
            id: value["id"].toString(),
            title: value["title"],
            price: value["price"],
            desc: value["desc"],
            image: value["image"],
          ));
        }
      }
      emit(ProductCustomerDone());
    }).catchError((error) {
      print(error.toString());
      emit(ProductCustomerFail());
    });
  }

}
