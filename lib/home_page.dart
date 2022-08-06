import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'chat_message.dart';

class HomePage extends StatefulWidget{
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GlobalKey<AnimatedListState> _animListKey = GlobalKey<AnimatedListState>();

  TextEditingController _textEditingController = TextEditingController();

  List<String> _chats =[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Platform.isIOS
          ? PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: CupertinoNavigationBar(
        middle: Text("Chat App"), ),
          ) 
          : AppBar(
        title: Text("Chat App"),
      ),
      body: Column(
        children: [
          Expanded(
              child: AnimatedList(
            key: _animListKey,
            reverse: true,
            itemBuilder: _buildItem, )),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            //EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(hintText: "메세지 입력창"),
                    onSubmitted: _handleSubmitted,
                    ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                TextButton(
                  onPressed: (){
                    _handleSubmitted(_textEditingController.text);
                  },
                  child: Text("send"),
                )
              ],
            ),
            ),
        ],
      ),
      );
  }
  Widget _buildItem(context, index, animation){
    return ChatMessage(_chats[index], animation: animation);
  }

  void _handleSubmitted(String text){
    Logger().d(text);
    _textEditingController.clear();
    _chats.insert(0, text);
    _animListKey.currentState!.insertItem(0);
  }
}
