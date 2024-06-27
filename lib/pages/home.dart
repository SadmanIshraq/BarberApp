import 'package:barberapp/services/shared_pref.dart';
import 'package:barberapp/pages/booking.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String? name,image;

  getthedatafromsharedpref()async{
    name= await SharedpreferenceHelper().getUserName();
    image= await SharedpreferenceHelper().getUserImage();
    setState(() {

    });
  }
  getontheload()async{
    await getthedatafromsharedpref();
    setState(() {

    });
  }
  @override
  void initState() {
   getontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        body: Container(
           margin:EdgeInsets.only(top: 40,left: 15,right: 10),
          child: Column(

            children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween ,
            children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("hello,",style:TextStyle(color: Colors.black87, fontSize:34,fontWeight:FontWeight.w500),
                ),
                Text(name!,style:TextStyle(color: Colors.black87, fontSize:34,fontWeight:FontWeight.bold),
                ),
             ],
            ),
            ClipRRect(
             borderRadius: BorderRadius.circular(20),
              child:Image.network(image!,height:95,width:75,fit:BoxFit.cover,),
            ),
              ],
          ),
          SizedBox(height: 15,),
          Divider(color: Colors.blue,height: 15,thickness: 5,
          ),
          SizedBox(height: 15,),
          Text("Services",style:TextStyle(color: Colors.black87, fontSize:34,fontWeight:FontWeight.bold),
          ),
              SizedBox(height: 15,),
              Row(
                children: [
                  GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>Booking(service:'Hair Cutting')
                    )
                    );
        },

                    child: Container(
                      height: 155,width: 175,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)
                      ),

                      child:Column
                        (children:
                      [   Image.asset("images/cutting.png", height: 110,),
                        SizedBox(height: 5,),
                        Text("Hair Cutting",style:TextStyle(color: Colors.black87, fontSize:23,fontWeight:FontWeight.bold),
                        ),
                      ],
                      ),
                    ),
                  ),
                  SizedBox(width: 13,),
                  GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => Booking(service: 'Beard Trimming')
          )
          );
        },
                    child: Container(
                      height: 155,width: 175,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)
                      ),

                      child:Column
                        (children:
                      [   Image.asset("images/beard.png", height: 110,),
                        SizedBox(height: 5,),
                        Text("Beard Trimming",style:TextStyle(color: Colors.black87, fontSize:23,fontWeight:FontWeight.bold),
                        ),
                      ],
                      ),
                    ),
                  ),

                ],
              ),
          SizedBox(height: 15,),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Booking(service: 'Classic Shaving')
                  )
                  );
                },
                child: Container(
                  height: 155,width: 175,
                  decoration: BoxDecoration(
                    color: Colors.green,
                      borderRadius: BorderRadius.circular(20)
                  ),

                  child:Column
                    (children:
                  [   Image.asset("images/shaving.jpeg", height: 110,),
                     SizedBox(height: 5,),
                     Text("Classic Shaving",style:TextStyle(color: Colors.black87, fontSize:23,fontWeight:FontWeight.bold),
                     ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 13,),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Booking(service: 'Hair Washing')
                  )
                  );
                },
                child: Container(
                  height: 155,width: 175,
                  decoration: BoxDecoration(
                      color: Colors.green,
                    borderRadius: BorderRadius.circular(20)
                  ),

                  child:Column
                    (children:
                  [   Image.asset("images/hair.png", height: 110,),
                    SizedBox(height: 5,),
                    Text("Hair Washing",style:TextStyle(color: Colors.black87, fontSize:23,fontWeight:FontWeight.bold),
                    ),
                  ],
                  ),
                ),
              ),

            ],
          ),

              SizedBox(height: 15,),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Booking(service: 'KidsHairCutting')
                      )
                      );
                    },
                    child: Container(
                      height: 155,width: 175,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)
                      ),

                      child:Column
                        (children:
                      [   Image.asset("images/kids.jpg", height: 110,),
                        SizedBox(height: 5,),
                        Text("kids HairCutting",style:TextStyle(color: Colors.black87, fontSize:23,fontWeight:FontWeight.bold),
                        ),
                      ],
                      ),
                    ),
                  ),
                  SizedBox(width: 13,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Booking(service: 'Facials')
                      )
                      );
                    },
                    child: Container(
                      height: 155,width: 175,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)
                      ),

                      child:Column
                        (children:
                      [   Image.asset("images/facials.jpg", height: 110,),
                        SizedBox(height: 5,),
                        Text("Facials",style:TextStyle(color: Colors.black87, fontSize:23,fontWeight:FontWeight.bold),
                        ),
                      ],
                      ),
                    ),
                  ),

                ],
              ),
            ],
    ),
        ),
    );
  }
}
