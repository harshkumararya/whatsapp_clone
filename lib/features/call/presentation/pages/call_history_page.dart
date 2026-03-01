import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/global/date/date_formats.dart';
import 'package:whatsapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';

class CallHistoryPage extends StatelessWidget {
  const CallHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Recent",
                  style: TextStyle(
                    fontSize: 15,
                    color: greyColor,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              SizedBox(height: 5,),
              ListView.builder(
                itemCount: 20,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context,index){
                  return ListTile(
                    leading: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: profileWidget(),
                      ),
                    ),
                    title: Text("Username",style: TextStyle(fontSize: 16),),
                    subtitle: Row(
                      children: [
                        Icon(Icons.call_made,color: Colors.green,),
                        SizedBox(width: 10,),
                        Text(formatDateTime(DateTime.now())),
                      ],
                    ),
                    trailing: Icon(Icons.call,color: tabColor,) ,

                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}