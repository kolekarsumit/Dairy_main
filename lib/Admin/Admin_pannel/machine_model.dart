
import 'package:shared_preferences/shared_preferences.dart';
class MachineInfo{
  bool isPaymentMode;
   String name;
   String mobileNo;
   String city;
   String BTname;
   String BTaddress;
   String merchantId;
   String icon1;
   String icon2;
   String background;

  MachineInfo({
    required this.isPaymentMode,
    required this.name,
    required this.mobileNo,
    required this.city,
    required this.BTname,
    required this.BTaddress,
    required this.merchantId,
    required this.icon1,
    required this.icon2,
    required this.background
});

  MachineInfo.withinfo({
    required this.isPaymentMode,
    required this.name,
    required this.mobileNo,
    required this.city,
    required this.BTname,
    required this.BTaddress,
    required this.merchantId,
    required this.icon2,
    required this.icon1,
    required this.background
});

  Map<String, dynamic> toJson() {
    return {
      'isPaymentMode':isPaymentMode??false,
      'name': name ?? '',
      'mobileNo':mobileNo ?? '',
      'city':city ?? '',
      'BTname':BTname ?? '',
      'BTaddress':BTaddress ?? '',
      'merchantId':merchantId ?? '',
      'icon2':icon2??'',
      'icon1':icon1??'',
'background':background
    };
  }
  factory MachineInfo.fromJson(Map<String,dynamic>json){
    return MachineInfo.withinfo(
      isPaymentMode:json['isPaymentMode'],
        name: json['name'],
        mobileNo: json['mobileNo'],
        city: json['city'],
        BTname: json['BTname'],
        BTaddress: json['BTaddress'],
        merchantId: json['merchantId'],
        background:json['background']??'',
        icon1:json['icon1']??'',
        icon2:json['icon2']??''
    );
  }



}