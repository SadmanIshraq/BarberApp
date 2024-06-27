import 'package:barberapp/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingAdmin extends StatefulWidget {
  const BookingAdmin({super.key});

  @override
  State<BookingAdmin> createState() => _BookingAdminState();
}

class _BookingAdminState extends State<BookingAdmin> {
  Stream? BookingStream;
  getontheload()async{
    BookingStream=await DatabaseMethods().getBookings();
    setState(() {

    });
  }
  @override
  void initState() {
    getontheload();
    super.initState();
  }


  Widget allBookings() {
    return StreamBuilder(
        stream: BookingStream, builder: (context, AsyncSnapshot snapshot) {
      return snapshot.hasData ? ListView.builder(padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return Material(
              child:Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.network(
                          ds["Image"], height: 90, width: 90, fit: BoxFit
                            .cover,),),
                    ],),
                  SizedBox(height: 10),
                  Text("Service:  " + ds["Service"], style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),),
                  SizedBox(height: 5),
                  Text("Name:  " + ds["Username"], style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),),
                  SizedBox(height: 5),
                  Text("Date:  " + ds["Date"], style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),),
                  SizedBox(height: 5),
                  Text("Time:  " + ds["Time"], style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: ()async{
                      await DatabaseMethods().DeleteBooking(ds.id);

                    },
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(10),),
                        child: Text("Done", style: TextStyle(color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),)

                    ),
                  ),
                  SizedBox(height: 20),
                ],),
            ),);
          }) : Container();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(

        margin:EdgeInsets.only(top:50,left:15,right:15),
        child:
        Column(
         children: [
           Center(child:Text("All Bookings", style :TextStyle(color:Colors.black,fontSize:33,fontWeight: FontWeight.bold),)),
           SizedBox(height:35 ),
         Expanded(child: allBookings()),
         ],
      ),),
    );
  }
}
