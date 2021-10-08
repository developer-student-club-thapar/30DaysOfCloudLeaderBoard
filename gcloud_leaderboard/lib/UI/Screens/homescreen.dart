import 'package:flutter/material.dart';
import 'package:gcloud_leaderboard/Models/user.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void listUser () async{
    await  Provider.of<UserData>(context,listen: false).getUserList();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listUser();
  }
  @override
  Widget build(BuildContext context) {
    final listOfUsers = Provider.of<UserData>(context).users;
    return Scaffold(
      backgroundColor: const Color(0xffF8F0E3),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Leaderboard',
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: (){}, child: const Icon(Icons.add)),
      body: SafeArea(
        child: ListView.builder(
          itemCount: listOfUsers.length,
          itemBuilder: (ctx,index){
            return listOfUsers.length ==0 ? Center(child: Text('Add Users'),): LeaderBoardTile(
              index: index,
              user: listOfUsers[index],
            );
          }
          )
        ),
    );
  }
}

class LeaderBoardTile extends StatelessWidget {
  const LeaderBoardTile({
    Key? key,
    this.index,
    required this.user
  }) : super(key: key);
  final index;
  final User user;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [
          Flexible(
            
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                child: Text(
                  '${index+1}'
                ),
              ),
            )),
            Container(
              margin: EdgeInsets.only(left: 30, top: 10,bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(
                    'Name: ${user.name}',
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
    );
  }
}
