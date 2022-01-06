import 'package:flutter/cupertino.dart';
import 'package:state_provider/model/user.dart';

class UserState extends ChangeNotifier{
  bool _isProcessing = true;
  List<Datum> _userList = [];

  ///getter process
  bool get isProcessing => _isProcessing;

  ///setter process
  setIsProcessing(bool value){
    _isProcessing = value;
    notifyListeners();
  }


  List<Datum> get userList => _userList;

  setUserList(List<Datum> list){
    _userList = list;
    notifyListeners();
  }

  mergePostList(List<Datum> list){
    _userList.addAll(list);
    notifyListeners();
  }

  Datum getUserByIndex(int index) => _userList[index];
}