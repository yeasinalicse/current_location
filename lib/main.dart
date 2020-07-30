import 'dart:developer';

import 'package:current_location/model/UserLocation.dart';
import 'package:current_location/service/location_service.dart';
import 'package:current_location/utils/AlertToast.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  UserLocation userLocation = UserLocation(
    latitude: 0.0,
    longitude: 0.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Location"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your Current Location',
            ),
            Text("Lat-> "+userLocation.latitude.toString()+" Lon-> "+userLocation.longitude.toString(),
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getCurrentLocation,
        child: Icon(Icons.my_location),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  getCurrentLocation() async {
    LocationService().getLocation().then((value) {
      if(value.latitude>0.0){
        setState(() {
          userLocation = value;
        });
        AlertToast.showSuccess("Lat-> "+userLocation.latitude.toString()+" Lon-> "+userLocation.longitude.toString());
      }else{
        AlertToast.showError("Please try again");
      }

    });

  }
}
