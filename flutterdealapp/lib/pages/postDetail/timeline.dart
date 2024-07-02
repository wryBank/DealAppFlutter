import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutterdealapp/pages/postDetail/eventCard.dart';
import 'package:flutterdealapp/values/color.dart';
import 'package:timeline_tile/timeline_tile.dart';

class timelineDeal extends StatelessWidget {
  final bool isProgress;
  final bool isCompleted;
  final bool isPast;
  final eventCard;
  
  const timelineDeal({super.key
  ,
  required this.isProgress,
  required this.isCompleted,
  required this.isPast,
  required this.eventCard
  
  });

  @override
  Widget build(BuildContext context) {
  return TimelineTile(
    axis: TimelineAxis.horizontal,
    isFirst: isProgress,
    isLast: isCompleted,
    beforeLineStyle: LineStyle(
      color: isPast ? AppColors.primaryAppbar : Colors.blue.shade100,
      thickness: 2,
    ),
    indicatorStyle: IndicatorStyle(
      width: 20,
      height: 20,
      color: isPast ? AppColors.primaryAppbar : Colors.blue.shade100,
      iconStyle: IconStyle(
        color: isPast ? Colors.white : Colors.blue.shade100,
        iconData: Icons.check 
      ),
    ),
    endChild:
    EventCard(
      isPast: isPast,
      child: eventCard,
    )

  );
}}