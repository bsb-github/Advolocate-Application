import 'package:advolocate_app/screens/lawyer_page.dart';
import 'package:flutter/material.dart';

class LawyerTile extends StatefulWidget {
  final String name;
  final String city;
  final String profession;
  final String services;
  final String probono;

  const LawyerTile(
      {Key? key,
      required this.name,
      required this.city,
      required this.profession,
      required this.services,
      required this.probono})
      : super(key: key);

  @override
  State<LawyerTile> createState() => _LawyerTileState();
}

class _LawyerTileState extends State<LawyerTile> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Padding(
      padding: EdgeInsets.only(top: height * 0.05),
      child: Container(
          height: height * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width * 0.03),
              color: Colors.grey[100],
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5.0,
                  spreadRadius: 0.1,
                  offset: Offset(
                    0.0,
                    6.0,
                  ),
                )
              ]),
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: width * 0.02),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.03),
                        image: const DecorationImage(
                            image: AssetImage('images/profile.png'),
                            fit: BoxFit.cover)),
                    height: height * 0.13,
                    width: width * 0.2,
                  ),
                  Text(
                    widget.name.length > 20
                        ? '${widget.name.substring(0, 20)}..'
                        : widget.name,
                    style: TextStyle(
                        fontSize: width * 0.045, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const Divider(
                thickness: 2.0,
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.02, left: height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Field of services',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: width * 0.05),
                    ),
                    Text(
                      widget.services,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(),
                    ),
                    Text(
                      'Nature of services',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: width * 0.05),
                    ),
                    Text(widget.probono),
                    Text(
                      'Location',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: width * 0.05),
                    ),
                    Text(widget.city),
                    Padding(
                      padding: EdgeInsets.only(right: width * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xffFCD917),
                                padding: EdgeInsets.only(
                                    left: width * 0.07, right: width * 0.07),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'View',
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
          // Row(
          //   children: [
          //     //image container
          //     Padding(
          //       padding: EdgeInsets.symmetric(horizontal: width*0.03),
          //       child: Container(
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(width * 0.03),
          //             image: const DecorationImage(
          //                 image: AssetImage('images/profile.png'),
          //                 fit: BoxFit.cover)),
          //         height: height * 0.13,
          //         width: width * 0.2,
          //       ),
          //     ),
          //
          //     // details
          //     Padding(
          //       padding:  EdgeInsets.symmetric(vertical: height*0.02),
          //       child: Column(
          //
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //
          //             widget.name.length > 20 ? '${widget.name.substring(0,20)}..' : widget.name,
          //             style: TextStyle(
          //               fontSize: width*0.045
          //             ),
          //           overflow: TextOverflow.ellipsis,
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Icon(Icons.location_on,color: Theme.of(context).primaryColor),
          //               SizedBox(width: width*0.01,),
          //               Text(widget.city, style: TextStyle(
          //               fontSize: width*0.045
          //             ),),
          //             ],
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //
          //               /// View button
          //              TextButton(
          //               style: TextButton.styleFrom(
          //                 backgroundColor: const Color(0xffFCD917),
          //                 padding: EdgeInsets.only(left: width*0.07, right: width*0.07),
          //
          //               ),
          //               onPressed: (){
          //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>LawyerPage(name: widget.name, email: widget.profession, information: widget.services, address: widget.city,probono: widget.probono,)));
          //               },
          //               child: const Text(
          //                 'View',
          //                 style: TextStyle(color: Colors.white),))
          //             ],
          //           )
          //         ],
          //       ),
          //     )
          //   ],
          // ),
          ),
    );
  }
}
