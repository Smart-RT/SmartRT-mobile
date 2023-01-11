import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class ExplainPart extends StatelessWidget {
  const ExplainPart({
    Key? key,
    required this.title,
    required this.notes,
    
  }) : super(key: key);

  final String title;
  final String notes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: smartRTTextTitle,
        ),
        Text(
          notes,
          style: smartRTTextNormal_Primary,
        ),
        
      ],
    );
  }
}
