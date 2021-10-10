import 'package:flutter/material.dart';
import 'package:gcloud_leaderboard/Models/user.dart';
import 'package:gcloud_leaderboard/UI/Widgets/leaderboardtile.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
@override


  @override
  Widget build(BuildContext context) {
    final searchUsers = Provider.of<UserData>(context).searchList;
    return WillPopScope(
      onWillPop: ()async{
        Provider.of<UserData>(context,listen: false).emptySearchList();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(onPressed: (){
            Provider.of<UserData>(context,listen: false).emptySearchList();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,size: 18,),
          ),
    
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
      ),
    );
  }
}
