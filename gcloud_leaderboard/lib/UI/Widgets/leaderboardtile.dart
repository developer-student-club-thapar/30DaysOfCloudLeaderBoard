import 'package:flutter/material.dart';
import 'package:gcloud_leaderboard/Models/user.dart';
import 'package:provider/provider.dart';

class LeaderBoardTile extends StatefulWidget {
  const LeaderBoardTile({Key? key, required this.index, required this.user,})
      : super(key: key);
  final int index;
  final User user;
  
  @override
  State<LeaderBoardTile> createState() => _LeaderBoardTileState();
}

class _LeaderBoardTileState extends State<LeaderBoardTile> {
 bool isExpanded = false ;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
      isExpanded = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    final abc = Provider.of<UserData>(context).emptyListen;
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
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
            alignment: Alignment.topRight,
            decoration: const BoxDecoration(
              image: DecorationImage(image:  AssetImage('assets/odml_logo_480.png', ),fit: BoxFit.cover,)
            ),
            child: null
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 5,
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.user.profileImage)),
              )),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.user.position}. ${widget.user.name}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    Text(
                      'Total Points: ${widget.user.total}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                    if(isExpanded)
                    Text(
                      'Track1 Points: ${widget.user.track1Points}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                    if(isExpanded)
                    Text(
                      'Track2 Points: ${widget.user.track2Points}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ],
                ),

              ),
              Flexible(
                flex: 2,
                child: IconButton(
                  onPressed: (){
                    if(isExpanded){
                      setState(() {
                        isExpanded = false;
                      });
                    }else{
                      setState(() {
                        isExpanded = true;
                      });
                    }
                  }, 
                  icon: isExpanded ? Icon(Icons.arrow_upward_sharp) : Icon(Icons.arrow_downward_sharp)
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
