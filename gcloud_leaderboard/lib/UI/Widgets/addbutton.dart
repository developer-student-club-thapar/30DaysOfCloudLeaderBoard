import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gcloud_leaderboard/Models/auth.dart';
import 'package:gcloud_leaderboard/Models/user.dart';
import 'package:gcloud_leaderboard/UI/Screens/homescreen.dart';
import 'package:gcloud_leaderboard/UI/Screens/loginscreen.dart';
import 'package:gcloud_leaderboard/UI/Widgets/custombutton.dart';
import 'package:provider/provider.dart';
class AddButton extends StatefulWidget {
  const AddButton({
    Key? key,
  }) : super(key: key);

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  String name = '';
  String email = '';
  String qwikLabId='';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
    onPressed: (){
      if(Provider.of<Auth>(context,listen: false).isAuth){
        showDialog(context: context, builder: (ctx){
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(29)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: isLoading? Center(child: CircularProgressIndicator(),): Column(
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
                  const SizedBox(
                    height: 20,
                  ),
                 CustomButton(
                   text: "Add User",
                   onTap: ()async{
                     
                     try{
                       setState(() {
                         isLoading = true;
                       });
                       await Provider.of<UserData>(context,listen: false).addUser(email, name, qwikLabId , Provider.of<Auth>(context,listen: false).token);
                       Navigator.pop(context);
                     }catch(e){
                       //TODO: Implement error
                     }finally{
                       
                       setState(() {
                         isLoading = false;
                       });
                       Navigator.push(context, MaterialPageRoute(builder: (ctx)=> HomeScreen() ));
                     }
                     
                   }
                 )
                ],
              ),
            ),
          ),
        );
      });
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (ctx)=> LoginScreen() ));
      }
      
    }, 
    child: const Icon(Icons.add));
  }
}