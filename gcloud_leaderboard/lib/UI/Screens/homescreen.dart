// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gcloud_leaderboard/Models/user.dart';
import 'package:gcloud_leaderboard/UI/Widgets/custombutton.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';
  String email = '';
  String qwikLabId='';
  bool isLoading = false;
  void listUser () async{
    await  Provider.of<UserData>(context,listen: false).getUserList();
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
      backgroundColor:  (Colors.white),
      appBar: AppBar(
       
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
      floatingActionButton:
          FloatingActionButton(
          onPressed: (){
            showDialog(context: context, builder: (ctx){
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
                child: Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(29)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Add User',
                          style:  TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18
                          )
                        ),
                       const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: TextField(
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left:
                                         10),
                                hintText: 'Enter the name',
                                hintStyle: TextStyle(color: Colors.black)),
                            onChanged: (value) {
                              name = value;
                            },
                          ),
                        ),
                          Center(
                          child: TextField(
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left:
                                         10),
                                hintText: 'Enter the email',
                                hintStyle: TextStyle(color: Colors.black)),
                            onChanged: (value) {
                              email = value;
                            },  
                          ),
                        ),
                          Center(
                          child: TextField(
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left:
                                         10),
                                hintText: 'Enter the qwikLabUrl',
                                hintStyle: TextStyle(color: Colors.black)),
                            onChanged: (value) {
                              qwikLabId = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                       CustomButton(
                         text: "Add User",
                         onTap: ()async{
                           Navigator.pop(context);
                           try{
                             setState(() {
                               isLoading = true;
                             });
                             await Provider.of<UserData>(context,listen: false).addUser(email, name, qwikLabId);
                           }catch(e){
                             //TODO: Implement error
                           }finally{
                             setState(() {
                               isLoading = false;
                             });
                           }
                           
                         }
                       )
                      ],
                    ),
                  ),
                ),
              );
            });
          }, 
          child: const Icon(Icons.add)),
      body: SafeArea(
        child: isLoading ? Center(child: CircularProgressIndicator(),): Column(
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
        ],
      ),
    );
  }
}
