import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:map/model/destination_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';




class Location_controller extends GetxController{

  RxList<Destination_mode> search_list = [Destination_mode()].obs;
  List <Destination_mode> all_data_list = [];
  RxBool wait = false.obs;



 get_locations(){

    wait.value = true;
    FirebaseFirestore.instance.collection('Source').get().then((value){
      all_data_list.clear();
      value.docs.forEach((element) {
        //all_data_list.add(Location_model.fromJson(element.data()));
        all_data_list.add(Destination_mode.fromJson(element.data()));
      });
      search_list.clear();
      search_list.addAll(all_data_list);
    }).whenComplete(() => wait.value=false);
  }
  
  get_dsetination() async {
   wait.value = true;
   all_data_list.clear();
   final response = await Dio().get('https://raw.githubusercontent.com/lutangar/cities.json/master/cities.json');
   List<dynamic> list = jsonDecode(response.data);
   list.forEach((element) => all_data_list.add(Destination_mode.fromJson(element)));
   search_list.clear();
   search_list.addAll(all_data_list);
   wait.value=false;
  }




  search_inList(String name){
    search_list.clear();
    search_list.value.addAll(all_data_list.where((element) => element.name!.toLowerCase().contains(name.toLowerCase())));
    if(name.isEmpty){
      search_list.value.addAll(all_data_list);
    }
    print(search_list.value);
  }


  // Future<List<Destination_mode>> pagination_list(int tt) async {
  //  print(tt);
  //  //if(all_data_list.length<=(index+1)*10)
  //   search_list.addAll(all_data_list.getRange(tt, tt+5));
  //
  //  wait.value=false;
  //  return await search_list.value;
  // }
  
  
}