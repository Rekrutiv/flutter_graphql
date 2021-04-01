import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class AutoTextWidget extends StatelessWidget {

     String autoText;
     double textFontSize;
     double textStep;
    AutoTextWidget({this.autoText,this.textFontSize,this.textStep});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
        autoText,
        // _repositories[index]['capital'].toString(),
        style: TextStyle(fontSize: textFontSize),
        minFontSize: 10,
        stepGranularity: textStep,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center);
  }
}
