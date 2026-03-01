import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/global/widgets/profile_widget.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Contacts"),
      ),
      body: ListView.builder(itemCount: 20, itemBuilder: (context,index){
        return ListTile(
          leading: SizedBox(
            width: 50,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: profileWidget(),
            ),
          ),
          title: Text("Username"),
          subtitle: Text("Hey there! I'm using WhatsApp"),
        );
      }),
    );
  }
}