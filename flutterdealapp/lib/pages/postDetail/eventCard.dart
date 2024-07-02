import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutterdealapp/values/color.dart';

class EventCard extends StatelessWidget {
  final bool isPast;
  final child;
  const EventCard({super.key,
  required this.isPast,
  required this.child
  
  });
  

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      width: 200,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isPast ? AppColors.primaryAppbar : Colors.grey,
      borderRadius: BorderRadius.circular(10),
      ),
      child:Center(child: 
      child
      ,)

    );
  }
}