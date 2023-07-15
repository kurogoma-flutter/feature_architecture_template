import 'package:flutter/material.dart';

/// デバイスの種類を判定する
enum DeviceType {
  mobile,
  tablet,
  desktop,
}

DeviceType getDeviceType(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  if (screenWidth < 430) {
    return DeviceType.mobile;
  } else if (screenWidth < 1024) {
    return DeviceType.tablet;
  } else {
    return DeviceType.desktop;
  }
}
