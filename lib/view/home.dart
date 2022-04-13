import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map/controller/home_controller.dart';
import 'package:map/view/location.dart';




class Home extends StatelessWidget{

  Home_controller controller= Get.put(Home_controller());

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(30.033333, 31.233334),
    zoom: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:_Draw_drower() ,
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
            },
          ),
           Align(alignment: Alignment.topCenter,
               child: _top_box(controller)),
          Align(alignment: Alignment.bottomCenter,
              child: _Button(controller))
        ],
      ),
    );
  }

}


// draw a tob box of screen
class _top_box extends StatelessWidget{

  TextEditingController location_controller = TextEditingController();
  TextEditingController destination_controller = TextEditingController();
  Home_controller controller;
  _top_box(this.controller);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width*.9,
      height: 240,
      margin: EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.grey.shade300
      ),
      padding: EdgeInsets.all(20),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              child: const CircleAvatar(
                child: Icon(Icons.menu,size: 15,color: Colors.black,),
                backgroundColor: Colors.white,),
              onTap: (){
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          const SizedBox(height: 20,),
          _Text_field(controller,true),
          const SizedBox(height: 20,),
          _Text_field(controller, false)
        ],
      ),
    );
  }

}

class _Draw_drower extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(child: Text('Drawer Header')),
          ),
          ListTile(
            title: const Text('Item 1'),
          ),
          ListTile(
            title: const Text('Item 2'),
          ),
        ],
      ),
    );
  }

}

// text field  inside a top box
class _Text_field extends StatelessWidget {

  Home_controller controller;
  bool is_location;

  _Text_field(this.controller,this.is_location);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: Get.width*.7,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white
        ),
        child: Center(
          child: Obx(()=>Text(is_location?controller.location.value:controller.destination.value,
          style: const TextStyle(color: Colors.black,fontSize: 16),)),
        ),
      ),
      onTap: () {
        if (is_location) {
          Get.to(Location(true));
        } else {
          // Get.to(Destination());
          Get.to(Location(false));
        }
      },
    );
  }
}

// button at the bottom of screen
class _Button extends StatelessWidget{
  Home_controller controller;
  _Button(this.controller);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: Get.width*.7,
        height: 50,
        margin: EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue
        ),
        child: const Center(child: Text('REQUEST RD',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)),
      ),
      onTap: (){
        controller.get_distance();
        _show_dialog();
      },
    );
  }

  _show_dialog(){
    Get.defaultDialog(
      title: 'source/destination',
      content: Text(controller.msg)
    );
  }

}