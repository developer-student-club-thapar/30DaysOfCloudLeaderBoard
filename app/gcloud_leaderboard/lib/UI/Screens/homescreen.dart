// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:gcloud_leaderboard/Models/user.dart';
import 'package:gcloud_leaderboard/UI/Screens/chartscreen.dart';
import 'package:gcloud_leaderboard/UI/Screens/searchscreen.dart';

import 'package:gcloud_leaderboard/UI/Widgets/leaderboardtile.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  void listUser() async {
    await Provider.of<UserData>(context, listen: false).getUserList();
  }

  @override
  void initState() {
    super.initState();
    listUser();
  }

  @override
  Widget build(BuildContext context) {
    final listOfUsers = Provider.of<UserData>(context).users;
    return Scaffold(
      backgroundColor: (Colors.white),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => SearchScreen()));
            },
            icon: Icon(
              Icons.search,
              color: Colors.black,
            )),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => ChartScreen( 
                            Provider.of<UserData>(context).getMap())));
              },
              icon: Icon(
                Icons.auto_graph,
                color: Colors.black,
              )),
        ],
        backgroundColor: Colors.white,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Leaderboard',
                style: TextStyle(color: Colors.black),
              ),
              Container(
                  height: 50, child: Image.asset('assets/leaderboard.png'))
            ],
          ),
        ),
      ),
      // floatingActionButton:
      //     AddButton(),
      body: SafeArea(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () => Provider.of<UserData>(context, listen: false)
                      .getUserList(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 220,
                        margin: EdgeInsets.only(
                          bottom: 15,
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/30daygcp.jpeg'),
                                fit: BoxFit.fitWidth)),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: listOfUsers.length,
                            itemBuilder: (ctx, index) {
                              return listOfUsers.isEmpty
                                  ? Center(
                                      child: Text('Add Users'),
                                    )
                                  : LeaderBoardTile(
                                      index: index,
                                      user: listOfUsers[index],
                                    );
                            }),
                      ),
                    ],
                  ),
                )),
    );
  }
}
