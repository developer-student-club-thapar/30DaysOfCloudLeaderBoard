// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gcloud_leaderboard/Models/auth.dart';
import 'package:gcloud_leaderboard/Models/user.dart';
import 'package:gcloud_leaderboard/UI/Widgets/addbutton.dart';

import 'package:provider/provider.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  bool isLoading = false;
  void listUser () async{
    await  Provider.of<UserData>(context,listen: false).getUserList();
  }
  void autoLogin()async{
    await Provider.of<Auth>(context,listen: false).checkLogin();
  }
  @override
  void initState() {
    
    super.initState();
    listUser();
    autoLogin();
  }
  @override
  Widget build(BuildContext context) {
    final listOfUsers = Provider.of<UserData>(context).users;
    return Scaffold(
      backgroundColor:  (Colors.white),
      appBar: AppBar(
        leading: Provider.of<Auth>(context).isAuth ? IconButton(onPressed: (){
          Provider.of<Auth>(context,listen: false).logout();
        }, icon: Icon(Icons.logout,color: Colors.black,)): null,
        backgroundColor: Colors.white,
        title: Center(
          
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
               Text(
                'Leaderboard',
                style: TextStyle(color: Colors.black),
              ),
              Container(height: 50,child: Image.asset('assets/leaderboard.png'))
            ],
          ),
        ),
      ),
      // floatingActionButton:
      //     AddButton(),
      body: SafeArea(
        child: isLoading ? Center(child: CircularProgressIndicator(),): RefreshIndicator(
          onRefresh: ()=>Provider.of<UserData>(context,listen: false).getUserList() ,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 220,
                margin: EdgeInsets.only(bottom: 15,),
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/30daygcp.jpeg'),fit: BoxFit.fitWidth)
                ),
              ),
              Expanded(
                child: ListView.builder(
                  
                  itemCount: listOfUsers.length,
                  itemBuilder: (ctx,index){
                    return listOfUsers.isEmpty ? Center(child: Text('Add Users'),): LeaderBoardTile(
                      index: index,
                      user: listOfUsers[index],
                    );
                  }
                  ),
              ),
            ],
          ),
        )
        ),
    );
  }
}



class LeaderBoardTile extends StatelessWidget {
  const LeaderBoardTile({
    Key? key,
    required this.index,
    required this.user
  }) : super(key: key);
  final int index;
  final User user;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
                color: Colors.black,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
        ]
      ),
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            child: Image.asset('assets/odml_logo_480.png',fit: BoxFit.cover),
          ),
          Row(
            children: [
              Flexible(
                
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user.profileImage)
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(left: 30, top: 10,bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(
                        '${index+1}. ${user.name}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18
                        ),
                      ),
                      Text(
                        'Total Points: ${user.total}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
