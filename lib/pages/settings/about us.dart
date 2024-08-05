import 'package:flutter/material.dart';

import '../../components/custom_text.dart';
import '../../components/switch_tile.dart';
import 'aboutuspage.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

  List<bool> tileValues = [false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [

            SizedBox(
              height: 150,
            ),



            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 20
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Notification', style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),

                      Icon(Icons.notification_add)
                    ],
                  ),
                ),
              ),
            ),




            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Aboutuspage();
                  }));
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text('About Us', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),)),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return AboutUs();
                  }));
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text('Contact Us', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),)),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
