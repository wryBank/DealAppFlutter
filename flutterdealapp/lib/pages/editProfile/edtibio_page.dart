import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutterdealapp/pages/editProfile/Widgets/editprofile_widget.dart';
import 'package:flutterdealapp/pages/editProfile/editprofile_image.dart';

class editbioPage extends StatefulWidget {
  const editbioPage({super.key});

  @override
  State<editbioPage> createState() => _editbioPageState();
}

class _editbioPageState extends State<editbioPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: buildAppBarEditProfile(context, "Profile"),
        body: buildTextField_EditImage("bio", "bio", Icons.abc, (value) { }),
        
      ),
    );
  }
}