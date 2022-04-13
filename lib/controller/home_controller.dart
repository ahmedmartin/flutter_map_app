import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:map/model/destination_model.dart';



class Home_controller extends GetxController{

  RxString location = 'Your Location'.obs;
  RxString destination = 'Destination'.obs;
  Destination_mode ?loc__selected_model;
  Destination_mode ?des__selected_model;
  String msg = '';


  get_distance(){
    if(loc__selected_model==null || des__selected_model==null){
      msg = 'Please select source/destination';
    }else {
     var temp =  Geolocator.distanceBetween(double.parse(loc__selected_model!.lat!),
          double.parse(loc__selected_model!.lng!),
          double.parse(des__selected_model!.lat!)
          , double.parse(des__selected_model!.lng!)).toInt();
     if(temp>=1000) {
       temp=(temp/1000).toInt();
       msg = '${temp} KM';
     }else{
       msg = '${temp} M';
     }


    }
  }

}