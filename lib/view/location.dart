import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map/controller/home_controller.dart';
import 'package:map/controller/location_controller.dart';
import 'package:map/model/destination_model.dart';
import 'package:map/view/home.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';



class Location extends StatelessWidget{

  Location_controller controller = Get.put(Location_controller());
  bool is_location;
  Location(this.is_location){
    if(is_location)
      controller.get_locations();
    else
      controller.get_dsetination();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30,),
          _Text_field("search",controller),
          //Obx(()=>controller.wait.value?CircularProgressIndicator():list_loc(controller))
          Location_list(controller,is_location)
        ],
      ),
    );
  }

}


class _Text_field extends StatelessWidget{

  TextEditingController text_controller=TextEditingController() ;
  String hint;
  Location_controller controller;
  _Text_field(this.hint,this.controller);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint+"...",
        fillColor: Colors.white,
        filled: true,
        border:OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(Icons.search,size: 30,color: Colors.black,)
        //labelText: hint
      ),
      controller: text_controller,
      textAlign: TextAlign.center,
      onChanged: (val){
        controller.search_inList(val);
      },
    );
  }

}


//----pagination list---------
// class list_loc extends StatefulWidget{
//   Location_controller controller;
//   list_loc(this.controller);
//
//   @override
//   State<StatefulWidget> createState() {
//     return _list_loc(controller);
//   }
// }

// class _list_loc extends State<list_loc>{
//   RefreshController refreshController = RefreshController(initialRefresh: false);
//   Location_controller controller;
//   late List<Destination_mode> temp;
//   _list_loc(this.controller){
//     temp= controller.search_list.value;
//   }
//   @override
//   Widget build(BuildContext context) {
//     // return Expanded(
//     //     child:SmartRefresher(
//     //       controller: refreshController,
//     //       enablePullDown: true,
//     //       enablePullUp: true,
//     //       onLoading: (){
//     //         print('hrer--------');
//     //         refreshController.refreshCompleted();
//     //       },
//     //       onRefresh: (){
//     //         print('------hrer--------');
//     //         refreshController.refreshCompleted();
//     //       },
//     //       child:
//     //       ListView.builder(
//     //           itemCount:temp.length ,
//     //           itemBuilder: (context,index){
//     //             return ListTile(
//     //               title: Text(temp[index].name!,
//     //                 style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//     //               onTap: (){
//     //
//     //               },
//     //             );
//     //           })),
//     //     ) ;
//     return Expanded(
//       child: PaginationView<Destination_mode>(
//         // preloadedItems: <Destination_mode>[
//         //   Destination_mode().name;
//         // ],
//         itemBuilder: (BuildContext context, Destination_mode user, int index) => Text(user.name!),
//         paginationViewType: PaginationViewType.listView ,// optional
//         pageFetch: controller.pagination_list ,
//         onError: (dynamic error) => Center(
//           child: Text('Some error occured'),
//         ),
//         onEmpty: Center(
//           child: Text('Sorry! This is empty'),
//         ),
//         bottomLoader: Center( // optional
//           child: CircularProgressIndicator(),
//         ),
//         initialLoader: Center( // optional
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
//
// }

class Location_list extends StatelessWidget{
  Location_controller controller;
  bool is_location;
  Location_list(this.controller,this.is_location);

  @override
  Widget build(BuildContext context) {
    return Obx(()=>controller.wait.value?CircularProgressIndicator():
    Expanded(
      child: ListView.builder(
          itemCount:controller.search_list.value.length ,
          itemBuilder: (context,index){
            return ListTile(
              title: Text(controller.search_list.value[index].name!,
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              onTap: (){
                  Home_controller c = Get.find();
                  if(is_location) {
                    c.location.value =
                    controller.search_list.value[index].name!;
                    c.loc__selected_model=controller.search_list.value[index];
                  }else{
                    c.destination.value =
                    controller.search_list.value[index].name!;
                    c.des__selected_model=controller.search_list.value[index];
                  }
                Get.back();
              },
            );
          }),
    ));
  }

}