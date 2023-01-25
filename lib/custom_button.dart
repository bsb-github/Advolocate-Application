import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  CustomImage(
      {Key? key,
      this.borderColor,
      required this.Image,
      this.borderwidth,
      this.conwidth,
      this.conheight,
      this.borderRadwidth})
      : super(key: key);

  final Image;
  Color? borderColor;
  double? conheight;
  double? conwidth;
  double? borderwidth;
  double? borderRadwidth;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: conheight,
      width: conwidth,
      decoration: BoxDecoration(
          border: Border.all(
              color: borderColor ?? Colors.white, width: borderwidth ?? 0),
          borderRadius: BorderRadius.circular(borderRadwidth ?? 0),
          image: DecorationImage(image: AssetImage(Image), fit: BoxFit.cover)),
    );
  }
}

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    this.borderRadius,
    this.TextColor,
    required this.buttonText,
    required this.onTap,
    this.image,
    this.btncolor,
  }) : super(key: key);

  VoidCallback onTap;
  Color? TextColor;
  Color? btncolor;
  double? borderRadius;
  String buttonText;
  final image;

  @override
  Widget build(BuildContext context) {
    bool loading = false;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Center(
      child: SizedBox(
          height: height * 0.08,
          width: width * 0.85,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              // shadowColor: Colors.black,
              // elevation: 15,
              backgroundColor: btncolor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width * 0.05), // <-- Radius
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  image,
                  height: height * 0.6,
                  width: width * 0.1,
                ),
                loading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        buttonText,
                        style: TextStyle(
                          fontSize: width * 0.05,
                          color: TextColor,
                        ),
                      ),
                //      SizedBox(width: width*0.04,),
                const Icon(Icons.arrow_forward_ios_sharp),
              ],
            ),
          )),
    );
  }
}


// Widget textbutton( btntext,textColor,textsize,onTap){
//   return TextButton(onPressed: onTap, child: Text(btntext,style: TextStyle(
//     color: textColor,fontSize: textsize,
//   ),));
// }

