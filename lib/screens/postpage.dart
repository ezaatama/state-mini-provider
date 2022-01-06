import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_provider/model/post.dart';
import 'package:state_provider/provider/post_state.dart';
import 'package:state_provider/repository/post_repo.dart';

class Postpage extends StatefulWidget {
  const Postpage({Key? key}) : super(key: key);

  @override
  _PostpageState createState() => _PostpageState();
}

class _PostpageState extends State<Postpage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Consumer<PostState>(builder: (context, provider, child) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.refresh_rounded),
            onPressed: () async {
              List<Data> data = await PostRepo().getData();
              provider.updateData(data);
            },
          ),
          appBar: AppBar(
            title: const Text("Code With API Provider"),
          ),
          body: SafeArea(
              child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: size.width,
            height: size.height - AppBar().preferredSize.height,
            child: provider.dataList.isEmpty
                ? const Center(child: Text("There is No Data", style: TextStyle(fontSize: 25)))
                : ListView.builder(itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("${provider.dataList[index].title}"),
                      leading: Text("${provider.dataList[index].id}"),
                    );
                  },
                  itemCount: provider.dataList.length
              ),
          )));
    });
  }
}
