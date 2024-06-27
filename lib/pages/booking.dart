import 'package:barberapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:barberapp/services/shared_pref.dart';

class Booking extends StatefulWidget {
  String service;
  Booking({required this.service});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String? name,image,email;

  getthedatafromsharedpref()async{
    name= await SharedpreferenceHelper().getUserName();
    image= await SharedpreferenceHelper().getUserImage();
    email= await SharedpreferenceHelper().getUserEmail();
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



  DateTime _selectedDate=DateTime.now();
  Future<void>_selectDate(BuildContext context)async{
    final DateTime? picked=await showDatePicker(context: context,initialDate: _selectedDate, firstDate: DateTime(2024), lastDate: DateTime(2025));
    if(picked!=null && picked!=_selectedDate){
      setState(() {
        _selectedDate=picked;
      });
    }
  }
  TimeOfDay _selectedTime=TimeOfDay.now();
  Future<void>_selectTime(BuildContext context) async{
    final TimeOfDay? picked=await showTimePicker(context: context, initialTime: _selectedTime);
    if(picked!=null && picked!=_selectedTime){
      setState(() {
        _selectedTime=picked;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Container(
        margin: EdgeInsets.only(left: 15.0,right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
            child:Padding(
              padding: const EdgeInsets.only(top: 45,),
              child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black,),
            ),
            ),
            SizedBox(height: 15),
            Text("Let's the\njourney begin", style: TextStyle(color: Colors.black87,fontSize: 25,fontWeight:FontWeight.w500),
            ),
            SizedBox(height: 15,),
            Container(
                width:MediaQuery.of(context).size.width,
                child:
            Image.asset("images/discount.png", fit: BoxFit.cover,)
            ),
            SizedBox(height: 18,),
            Text(widget.service, style: TextStyle(color: Colors.black87,fontSize: 30,fontWeight:FontWeight.bold),
            ),
            SizedBox(height: 13,),
            Container(
              padding: EdgeInsets.only(top: 14,bottom: 14),

              decoration: BoxDecoration(color: Colors.green,
                  borderRadius:BorderRadius.circular(24) ),
              
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text("Set a Date", style: TextStyle(color: Colors.black,fontSize: 27,fontWeight: FontWeight.w500),),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap:(){
                          _selectDate(context);
                        },

                        child: Icon(Icons.calendar_month,color: Colors.white,size: 40,),
                        ),
                      SizedBox(width: 20,),
                      Text("${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}", style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 12,),
            Container(
              padding: EdgeInsets.only(top: 14,bottom: 14),

              decoration: BoxDecoration(color: Colors.green,
                  borderRadius:BorderRadius.circular(24) ),

              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text("Set a Time", style: TextStyle(color: Colors.black,fontSize: 27,fontWeight: FontWeight.w500),),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap:(){
                          _selectTime(context);
                        },
                        child: Icon(Icons.alarm,color: Colors.white,size: 40,),
                      ),
                      SizedBox(width: 20,),
                      Text(_selectedTime.format(context), style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height:20),
            GestureDetector(
              onTap: () async {
                Map<String, dynamic> userBookingmap= {
                  "Service": widget.service,
                  "Date": "${_selectedDate.day}/${_selectedDate
                      .month}/${_selectedDate.year}".toString(),
                  "Time": _selectedTime.format(context).toString(),
                  "Username":name,
                  "Image":image,
                  "Email":email,
                };
                await DatabaseMethods().addUserBooking(userBookingmap).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Service has been booked successfully",style: TextStyle(fontSize: 20),)));
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text("Book Now",style: TextStyle(color: Colors.black87, fontSize:30,fontWeight:FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
