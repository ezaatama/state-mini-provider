import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_provider/model/user.dart';
import 'package:state_provider/provider/user_state.dart';
import 'package:state_provider/repository/http.dart';

class Userpage extends StatefulWidget {
  const Userpage({Key? key}) : super(key: key);

  @override
  State<Userpage> createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  _showSnackbar(String message, {Color? bgColor}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: bgColor ?? Colors.red,
    ));
  }

  _hideSnackbar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  _getUser() async {
    var provider = Provider.of<UserState>(context, listen: false);
    var response = await ApiUrl.getUsers(1);

    if (response!.isSuccessful) {
      provider.setUserList(response.data!);
    } else {
      _showSnackbar(response.message!);
    }
    provider.setIsProcessing(false);
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
        body: SafeArea(
            child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Consumer<UserState>(
        builder: (_, provider, __) => provider.isProcessing ? Center() : ListView.builder(
            itemBuilder: (_, index) {
              Datum user = provider.getUserByIndex(index);
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.avatar.toString()),
                  radius: 25,
                ),
                title: Text(user.firstName.toString()),
                subtitle: Text(user.email.toString()),
              );
            },
            itemCount: provider.userList.length,
        ),
      ),
    )));
  }
}
