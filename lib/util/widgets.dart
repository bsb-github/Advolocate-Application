import 'package:flutter/material.dart';

Widget Button(bgcolor, btext, textColor, width, height, onPressed) {
  return Padding(
    padding: EdgeInsets.only(left: width * 0.001, top: height * 0.02),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.09),
      decoration: BoxDecoration(
          border:
              Border.all(width: width * 0.008, color: const Color(0xffFCD917)),
          borderRadius: BorderRadius.circular(width * 0.06),
          color: bgcolor),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          btext,
          style: TextStyle(
              // letterSpacing: 1,
              color: textColor,
              fontSize: width * 0.046,
              fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

//text with icon in profile screen

Widget RowInfo(Width, height, icon, topText, bottomText, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(top: height * 0.01, left: Width * 0.1),
    child: Row(
      children: [
        Container(
            decoration: BoxDecoration(
                color: const Color(0xffFCD917),
                borderRadius: BorderRadius.circular(7)),
            padding: const EdgeInsets.all(7),
            child: Icon(
              icon,
              size: 32,
            )),
        SizedBox(
          width: Width * 0.03,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              topText,
              maxLines: 5,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              bottomText.toString(),
              // style: const TextStyle(
              //     fontWeight: FontWeight.bold, fontSize: 16)),
            )
          ],
        )
      ],
    ),
  );
}
