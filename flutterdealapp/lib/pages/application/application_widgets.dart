import 'package:flutter/cupertino.dart';
import 'package:flutterdealapp/pages/Deal/deal_page.dart';
import 'package:flutterdealapp/pages/Deal/filterPostDeal.dart';
import 'package:flutterdealapp/pages/Feed/Feed_page.dart';
import 'package:flutterdealapp/pages/Wallet/WalletPage.dart';
import 'package:flutterdealapp/pages/application/test.dart';
import 'package:flutterdealapp/pages/editProfile/editprofile_image.dart';
import 'package:flutterdealapp/pages/Profile/profile.dart';
import 'package:flutterdealapp/pages/postDetail/postDetail_page.dart';

Widget buildPage(int index){
  List<Widget> _widgets = [
    FeedPage(),
    
    DealPage(),
    // postDetailPage(),
    // test(),
    ProfilePage(),
    // filterPosts(),
    WalletPage(),
    // Center(child: Text("home"),),
    
  ];
  return _widgets[index];

}