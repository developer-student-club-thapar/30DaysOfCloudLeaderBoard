import 'package:flutter/material.dart';
import 'package:gcloud_leaderboard/Models/user.dart';

class LeaderBoardTile extends StatelessWidget {
  const LeaderBoardTile({Key? key, required this.index, required this.user})
      : super(key: key);
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
          ]),
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            child: Image.asset('assets/odml_logo_480.png', fit: BoxFit.cover),
          ),
          Row(
            children: [
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                    backgroundImage: NetworkImage(user.profileImage)),
              )),
              Container(
                margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.position}. ${user.name}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    Text(
                      'Total Points: ${user.total}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 14),
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
