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
  int limit = 0;
  List<DataOrder> list = [];
  List<DataOrder> listNew = [];

  List<int> pages = [];
  OrdersCutomer? ordersCutomer;
  Future getOrders({context, page}) async {
    list = [];
    listNew = [];
    emit(CustomerOrderLoading());
    Map<String, dynamic> header = {
      "auth-token": ShopCubit.get(context).customerToken
    };
    Map<String, dynamic> data = {
      "user_id": ShopCubit.get(context).customerId,
      "page": page
    };
   await  DioHelper.postData(url: myorder, data: data, option: header).then((value) {
      ordersCutomer = OrdersCutomer.fromJson(value.data);
      pages = List.generate(ordersCutomer!.data!.total!, (i) => i + 1);
      final res = value.data['data']['data'];
      for (var value in res) {
        final pro = list.indexWhere((element) => element.id == value["id"],);
        if (pro >= 0) {
          list[pro] = DataOrder(
              id: value["id"],
              size: value["size"],
              price: value["price"],
             readOrNow: value["read"],
              many: value["many"],
              total: value["total"],
              time: value["created_at"],
              userInfo: UserInfoOrder.fromJson(value['user_info']),
              productOrder: ProductOrder.fromJson(value['product']));
        } else {
          list.add(DataOrder(
              readOrNow: value["read"],
              id: value["id"],
              size: value["size"],
              price: value["price"],
              time: value["created_at"],
              many: value["many"],
              total: value["total"],
              userInfo: UserInfoOrder.fromJson(value['user_info']),
              productOrder: ProductOrder.fromJson(value['product'])));
          getNewList();
        }
      }
      emit(CustomerGetOrderDone());
    }).catchError((onError) {
      print(onError.toString());
      emit(CustomerGetOrderFail());
    });
  }

  void getNewList(){
    for (var x in list){
      if(x.readOrNow=="0"){
        final pro = listNew.indexWhere((element) => element.id ==x.id,);
        if (pro >= 0) {
        }else{
          listNew.add(x);
          emit(GetNewOrderCustomer());
        }
      }else{}
    }
  }
   removeIndexList(index){
     listNew.removeAt(index);
     emit(ListCustomerdone());
    return listNew;
  }
  int get itemOrder {
    return listNew.length;
  }

  List<DataOrder> search = [];
  List<dynamic> searchCustomerInOrders(String quary) {
    search = [];
    var searching = list
        .where((element) =>
        element.userInfo!.name!.toLowerCase().contains(quary.toLowerCase()))
        .toList();
    search = searching;
    // print(search[0].title);
    emit(SearchingCustomer());
    return search;
  }

  Future updateOrders({context, id}) async {
    emit(UpdateOrderCustomerLoading());
    Map<String, dynamic> header = {
      "auth-token": ShopCubit.get(context).customerToken
    };
    Map<String, dynamic> data = {
      "id": id,
    };
    await DioHelper.postData(url: updateOrder, data: data, option: header).then((value) {
      final res = value.data['msg'];
      print(res);
      emit(UpdateOrderCustomerDone());
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateOrderCustomerFail());
    });
  }




  int? selected;
  void getselected(int x) {
    print(x);
    selected = x;
    if (x == 0) {
      limit = 1;
    } else {
      limit = x + 1;
    }

    print(limit);

    emit(ChangeSelcect());
  }
}
