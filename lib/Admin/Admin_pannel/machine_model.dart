class MachineInfo{
  bool isPaymentMode;
   String name;
   String mobileNo;
   String city;
   String BTname;
   String BTaddress;
   String merchantId;

  MachineInfo({
    required this.isPaymentMode,
    required this.name,
    required this.mobileNo,
    required this.city,
    required this.BTname,
    required this.BTaddress,
    required this.merchantId,
});

  MachineInfo.withinfo({
    required this.isPaymentMode,
    required this.name,
    required this.mobileNo,
    required this.city,
    required this.BTname,
    required this.BTaddress,
    required this.merchantId,
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
    );
  }
}