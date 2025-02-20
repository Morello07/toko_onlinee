import 'package:flutter/material.dart';

class ResponseDataList{
  bool status;
  String massage;
  Map? data;
  ResponseDataList({
    required this.status, 
    required this.massage, 
    required this.data
  });
}