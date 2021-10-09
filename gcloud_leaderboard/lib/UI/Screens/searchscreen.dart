import 'package:flutter/material.dart';
import 'package:gcloud_leaderboard/Models/user.dart';
import 'package:gcloud_leaderboard/UI/Widgets/leaderboardtile.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchUsers = Provider.of<UserData>(context).searchList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          children:  [
            const Text(
              'Search',
              style: TextStyle(color: Colors.black),
            ),
            //  Container(
            //       height: 50, child: Image.asset('assets/brackets.png',fit: BoxFit.contain,))
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:  Colors.white,
                boxShadow: const [
                  BoxShadow(
              color: Colors.black,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
                ]
            ),
            child: TextField(
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10),
                  hintText: 'Enter name to search',
                  hintStyle: TextStyle(color: Colors.black,)),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                print(value);
                Provider.of<UserData>(context,listen: false).search(value.toLowerCase());
              },
            ),
          ),
          Expanded(
                        child: ListView.builder(
                            itemCount: searchUsers.length,
                            itemBuilder: (ctx, index) {
                              return searchUsers.isEmpty
                                  ? Center(
                                      child: Text('Add Users'),
                                    )
                                  : LeaderBoardTile(
                                      index: index,
                                      user: searchUsers[index],
                                    );
                            }),
                      ),
        ],
      ),
    );
  }
}
