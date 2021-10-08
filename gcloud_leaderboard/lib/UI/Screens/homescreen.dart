import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (ctx,index){
            return LeaderBoardTile(
              index: index,
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
  }) : super(key: key);
  final index;
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
                children: const [
                  Text(
                    'Name: Sidharth Bahl',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18
                    ),
                  ),
                  Text(
                    'Total Points: 5',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
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
