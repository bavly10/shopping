import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/model/cart.dart';
import 'package:shopping/modules/cart/cubit/state.dart';


class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(ShopCart_InitalState());
  static CartCubit get(context) => BlocProvider.of(context);

  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }
  int get itemcount {
    return _items.length;
  }

  void additem({required String proid, required String imgurl, required String title, required double price,required int qua}) {
    if (_items.containsKey(proid)) {
      _items.update(
          proid,
              (value) => CartItem(
              id: value.id,
              title: value.title,
              quantity: value.quantity+1,
              price: value.price,
              imgurl: value.imgurl));
    } else {
      _items.putIfAbsent(
          proid,
              () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: qua,
              price: price,
              imgurl: imgurl));
    }
    emit(ShopAddItems());
  }
  void removeitem(String proid) {
    _items.remove(proid);
    emit(ShopRemoveItems());
  }
  void removesingleitem(String proid) {
    if (!_items.containsKey(proid)) {
      return;
    }
    if (_items[proid]!.quantity > 1) {
      _items.update(proid,(value) => CartItem(
          id: value.id,
          title: value.title,
          quantity: value.quantity - 1,
          price: value.price,
          imgurl: value.imgurl));
    } else {
      _items.remove(proid);
    }
    emit(ShopRemoveItem());
  }
  void clear() {
    _items = {};
  }
  int i=1;
  void plus(){
    i++;
    emit(ShopChangeplus());
  }
  void minus(){
    if(i<=1){
      i=1;
    }else{
      i--;
    }
    emit(ShopChangeminus());
  }
}