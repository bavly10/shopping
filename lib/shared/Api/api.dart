import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping/shared/diohelper/dioHelpoer.dart';
import 'package:shopping/shared/network.dart';

class Api{
  Future<dynamic> get(String url) async {
    try{
    var response= await DioHelper.getData(url: url);
      if(response.statusCode==200)
        {
          return response.data;
        }else{
        throw Exception('there is problem with status code ${response.statusCode}') ;
      }
    }catch(e){
      debugPrint("error 404 is  ${e.toString()}");
    }
  }

  Future<dynamic> post({required Map<String, dynamic> data,required String url}) async {
    try{
      var response= await DioHelper.postData(data: data,url: url,);
      if(response.statusCode==200)
      {
        return response.data;
      }else{
        throw Exception('there is problem with status code ${response.statusCode}') ;
      }
    }catch(e){
      debugPrint("error 404 is  ${e.toString()}");
    }
  }

}