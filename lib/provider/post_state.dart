import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_provider/model/post.dart';

class PostState extends ChangeNotifier{
  List<Data> dataList = [];

  void updateData(List<Data> dataList){
    this.dataList = dataList;
    notifyListeners();
  }
}