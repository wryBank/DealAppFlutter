import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/pages/Wallet/Withdraw.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_state.dart';
import 'package:flutterdealapp/values/color.dart';
import 'package:intl/intl.dart';

import '../Profile/bloc/profile_bloc.dart';
import 'DepositPage.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  double coin = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProfileBloc>(context)
        .add(getUserData(uid: FirebaseAuth.instance.currentUser!.uid));
    //  date = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is getDataState) {
        coin = state.userModel!.coin!;
        DateFormat date = DateFormat('dd/MM/yyyy HH:mm');

        print('coin = $coin');
        print('state = $state');
        return Scaffold(
          // backgroundColor: Color.fromARGB(255, 188, 222, 255),
          body: RefreshIndicator(
            onRefresh: () {
              BlocProvider.of<ProfileBloc>(context).add(
                  getUserData(uid: FirebaseAuth.instance.currentUser!.uid));
              return Future.delayed(Duration(seconds: 1));
            },
            child: Container(
              decoration: const BoxDecoration(
                // color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    // Color.fromRGBO(207, 162, 250,100),
                    // Color.fromRGBO(194, 233, 251, 100),

                    Color.fromRGBO(224, 195, 252, 100),
                    Color.fromRGBO(142, 197, 252, 100),
                  ],
                ),
                // border: Border.all(
                //   width: 0.2,
                //   color: Colors.black,
                // ),
                // borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Container(
                  width: 300,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    border: Border.all(
                      width: 0.01,
                      // color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage('${state.userModel!.urlprofileimage}'),
                      ),
                      SizedBox(height: 10),
                      Text(
                        state.userModel!.username.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Account Balance',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      // SizedBox(height: 10),
                      Container(
                        width: 100,
                        height: 50,
                        child: Center(
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }
                                if (snapshot.hasData &&
                                    snapshot.data!.data() != null) {
                                  coin = snapshot.data!.data()!['coin'];
                                }
                                return Text(
                                  coin.toString(),
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }),
                        ),

                        //  color: Colors.red,
                      ),
                      // SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ยอดล่าสุด ${date.format(DateTime.now())}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            child: IconButton(
                              icon: Icon(
                                Icons.refresh,
                                size: 15,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                date.format(DateTime.now());
                                BlocProvider.of<ProfileBloc>(context).add(
                                    getUserData(
                                        uid: FirebaseAuth
                                            .instance.currentUser!.uid));
                              },
                            ),
                          ),
                        ],
                      ),

                      // }
                      // }),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DepositPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.lightBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text('deposit'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WithdrawPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.lightBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text('Withdraw'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }
}
