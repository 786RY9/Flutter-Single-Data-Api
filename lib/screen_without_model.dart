import 'package:flutter/material.dart';
import 'package:single_data_api/api_services.dart';

class ScreenWithoutModel extends StatefulWidget {
  const ScreenWithoutModel({super.key});

  @override
  State<ScreenWithoutModel> createState() => _ScreenWithoutModelState();
}

class _ScreenWithoutModelState extends State<ScreenWithoutModel> {
  dynamic singlePost;
  bool isReady = false;

  _getSinglePostWithoutModel() {
    isReady = true;
    ApiServices()
        .getSinglePostWithoutModel()
        .then((value) {
          setState(() {
            singlePost = value;
            isReady = false;
          });
        })
        .onError((error, StackTrace) {
          print(error);
          isReady = false;
        });
  }

  @override
  void initState() {
    _getSinglePostWithoutModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        title: Text('Single Data Api without using Model'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body:
          isReady == true
              ? Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Text(
                    singlePost['userId'].toString(),
                    style: TextStyle(color: const Color.fromARGB(255, 60, 255, 0), fontSize: 20),
                  ),
                  Text(
                    singlePost['title'].toString(),
                    style: TextStyle(color: const Color.fromARGB(255, 151, 32, 32), fontSize: 18),
                  ),
                  Text(
                    singlePost['body'].toString(),
                    style: TextStyle(color: Colors.teal, fontSize: 18),
                  ),
                ],
              ),
    );
  }
}
