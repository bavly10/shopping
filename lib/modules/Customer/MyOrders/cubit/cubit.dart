import 'dart:core';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/model/myOrderCustomer.dart';
import 'package:shopping/modules/Customer/MyOrders/cubit/state.dart';
import 'package:shopping/shared/diohelper/dioHelpoer.dart';
import 'package:shopping/shared/network.dart';

class CustomerOrderCubit extends Cubit<CustomerOrderStates> {
  CustomerOrderCubit() : super(CustomerOrder_InitalState());

  static CustomerOrderCubit get(context) => BlocProvider.of(context);

  List<DataOrder> list = [];
  List<int> pages = [];
  OrdersCutomer? ordersCutomer;
  Future getOrders({
    context,
  }) async {
    emit(CustomerOrderLoading());
    Map<String, dynamic> header = {
      "auth-token": ShopCubit.get(context).customerToken
    };
    Map<String, dynamic> data = {
      "user_id": 4,
    };
    DioHelper.postData(url: myorder, data: data, option: header).then((value) {
      ordersCutomer = OrdersCutomer.fromJson(value.data);
      pages = List.generate(ordersCutomer!.data!.total!, (i) => i + 1);
      final res = value.data['data']['data'];
      for (var value in res) {
        final pro = list.indexWhere(
          (element) => element.id == value["id"],
        );
        if (pro >= 0) {
          list[pro] = DataOrder(
              id: value["id"],
              size: value["size"],
              price: value["price"],
              many: value["many"],
              total: value["total"],
              userInfo: UserInfoOrder.fromJson(value['user_info']),
              productOrder: ProductOrder.fromJson(value['product']));
        } else {
          list.add(DataOrder(
              id: value["id"],
              size: value["size"],
              price: value["price"],
              many: value["many"],
              total: value["total"],
              userInfo: UserInfoOrder.fromJson(value['user_info']),
              productOrder: ProductOrder.fromJson(value['product'])));
        }
      }
      emit(CustomerGetOrderDone());
    }).catchError((onError) {
      print(onError.toString());
      emit(CustomerGetOrderFail());
    });
  }

  int? selected;
  void getselected(int x) {
    selected = x;
    emit(ChangeSelcect());
  }
}
