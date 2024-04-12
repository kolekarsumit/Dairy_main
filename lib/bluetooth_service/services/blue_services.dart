import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:developer' as dev;

import '../permission/bluetooth_permission.dart';
import '../permission/location_permission.dart';

class BlueServices {
  bool status = false;
  String blueAddressID = '';

  bool isPaired=false;
  bool isConnect=false;


  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;


  Future<bool> turnOn() async {
    getState();
    if (_bluetoothState.isEnabled) {
      dev.log('Bluetooth already enabled');

    } else {
      dev.log('requesting to turn on');
      await FlutterBluetoothSerial.instance.requestEnable();
      dev.log('enabled');
    }
    return _bluetoothState.isEnabled;
  }

  void getState() {
    FlutterBluetoothSerial.instance.state.then((state) {
      _bluetoothState = state;
    });
    dev.log(_bluetoothState.toString());
  }

  bool validateID(blueID) {
    int len = blueID.length;
    bool validID = false;

    if (len == 17) {
      final splitted = blueID.split(":");
      var listLength = splitted.length;

      if (listLength == 6) {
        for (var i = 0; i < listLength; i++) {
          if (splitted[i].length != 2) {
            validID = false;
            dev.log('Invalid');
            return validID;
          }
        }
        validID = true;
        dev.log('Valid ');
        return validID;
      } else {
        validID = false;
        dev.log('Invalid ');
        return validID;
      }
    } else {
      validID = false;
      dev.log('Invalid ');
      return validID;
    }
  }


  //single device



  BluetoothConnection? _connection;

  Future<bool> connectToDevice(String address) async {
    blueAddressID=address;

    try {
      bool isAlreadyPaired = await _isDevicePaired(address);
      if (!isAlreadyPaired) {
        isAlreadyPaired = await _pairDevice(address);
        if (!isAlreadyPaired) {
          Fluttertoast.showToast(
            msg: 'Failed to pair with the device',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          return false;
        }
      }

      // Now attempt to connect
      if(isAlreadyPaired){
        isPaired=true;
        Fluttertoast.showToast(
          msg: 'Paired and Connected',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        try{
          _connection = await BluetoothConnection.toAddress(address);
          Fluttertoast.showToast(
            msg: 'Connected to device!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }catch(e){
        }
        return true;
      }


    } catch (e) {
      return false;

    }
    return false;
  }

  Future<bool> _isDevicePaired(String address) async {
    List<BluetoothDevice> pairedDevices = await FlutterBluetoothSerial.instance.getBondedDevices();
    return pairedDevices.any((device) => device.address == address);
  }

  Future<bool> _pairDevice(String address) async {
    try {
      bool? isPairSuccess = await FlutterBluetoothSerial.instance.bondDeviceAtAddress(address);
      if (!isPairSuccess!) {
        Fluttertoast.showToast(
          msg: 'Failed to pair with the device',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      return isPairSuccess;
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error pairing with the device: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }

  Future<void> sendDataOverSingleBluetooth(String dataToSend) async {
    try {
      bool isAlreadyPaired = await _isDevicePaired(blueAddressID);

if(!isAlreadyPaired){
  Fluttertoast.showToast(
    msg: 'Device Not Paired: $dataToSend',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
  return;
}
      _connection?.output.add(utf8.encode(dataToSend+"\r\n"));
      await _connection?.output.allSent;
      Fluttertoast.showToast(
        msg: 'Data sent over Bluetooth: $dataToSend',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // BluetoothConnection.toAddress(address).then((blue)async{
      //   blue?.output.add(utf8.encode(dataToSend+"\r\n"));
      //   await blue?.output.allSent;
      //   Fluttertoast.showToast(
      //     msg: 'Data sent over Bluetooth: $dataToSend',
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.green,
      //     textColor: Colors.white,
      //     fontSize: 16.0,
      //   );
      // });
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error sending data over Bluetooth: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<bool> triggerPipelineToConnect(String blueAddress) async {
    try {
      bool isBluetoothEnabled = await turnOnBluetooth();
      if (!isBluetoothEnabled) {
        return false;
      }

      bool isConnected=   await connectToDevice(blueAddress);
return isConnected;
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error triggering pipeline: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return false;
  }

  Future<bool> turnOnBluetooth() async {
    _bluetoothState = await FlutterBluetoothSerial.instance.state;
    if (_bluetoothState.isEnabled) {
      return true;
    } else {
      try {
        await FlutterBluetoothSerial.instance.requestEnable();
        _bluetoothState = await FlutterBluetoothSerial.instance.state;
        return _bluetoothState.isEnabled;
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Error turning on Bluetooth: $e',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return false;
      }
    }

  }
}
