import 'package:flutter/material.dart';
import 'package:gcloud_leaderboard/Models/auth.dart';
import 'package:gcloud_leaderboard/UI/Screens/homescreen.dart';
import 'package:gcloud_leaderboard/UI/Widgets/custombutton.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
 

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  bool isLoading = false;
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            'Login',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.black
            )
          ),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back,color: Colors.black,),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=> HomeScreen() ));
              })),
      body: SafeArea(
        child: Center(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                                               Container(
                          margin: const EdgeInsets.only(
                              top:  20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      fontSize:
                                          20,
                                      color: const Color(0xff49484b),
                                    ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xff7f7c82).withOpacity(.34)),
                                child: TextField(
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 
                                              10),
                                      hintText: 'Enter your phone number',
                                      hintStyle:
                                          TextStyle(color: Colors.black)),
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    email = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin:const EdgeInsets.only(
                              top:  20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Password',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      fontSize:
                                          20,
                                      color: const Color(0xff49484b),
                                    ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xff7f7c82).withOpacity(.34)),
                                child: TextField(
                                  decoration:const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:  EdgeInsets.only(
                                          left: 
                                              10),
                                      hintText: 'Enter your password',
                                      hintStyle:
                                          TextStyle(color: Colors.black)),
                                  obscureText: true,
                                  onChanged: (value) {
                                    password = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 15),
                          child: Center(
                            child: CustomButton(
                                text: 'Login',
                                onTap: () async {
                                  
                                  try {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await Provider.of<Auth>(context,
                                            listen: false)
                                        .login(email, password,);
                                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=> HomeScreen() ));
                                  } catch (e) {
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            title: const Text('Error Occured'),
                                            content: Text('$e'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Ok'))
                                            ],
                                          );
                                        });
                                  } finally {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                }),
                          ),
                        )
                      ]),
                ),
        ),
      ),
    );
  }
}
