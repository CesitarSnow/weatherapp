import 'package:flutter/material.dart';

class ItemForecastWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return   Container(
      margin: EdgeInsets.only(right: 16, bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            offset: Offset(0,5),
            blurRadius: 12,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 28, horizontal: 16),

      child: Column(
        children: [
          Text(
            "10 am",
            style: TextStyle(color: Colors.white,fontSize: 16),
          ),
          SizedBox(height: 6,),
          Image.asset(
            "assets/images/nuboso.png",
            height: 38,
            color: Colors.white,
          ),
          SizedBox(height: 6,),
          Text(
            "25 °c",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
