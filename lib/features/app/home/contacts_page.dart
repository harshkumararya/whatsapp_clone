import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/features/app/const/page_const.dart';
import 'package:whatsapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';
import 'package:whatsapp_clone/features/chat/domain/entities/message_entity.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/user/user_cubit.dart';

class ContactsPage extends StatefulWidget {
  final String uid;
  const ContactsPage({super.key, required this.uid});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getAllUsers();
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Contacts")),
      body: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, state) {
          if (state is GetSingleUserLoaded) {
            final currentUser = state.singleUser;
            return BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  final contacts = state.users
                      .where((user) => user.uid != widget.uid)
                      .toList();

                  if (contacts.isEmpty) {
                    return Center(child: Text("No contacts found"));
                  }
                  return ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            PageConst.singleChatPage,
                            arguments: MessageEntity(
                              senderUid: currentUser.uid,
                              recipientUid: contact.uid,
                              senderName: currentUser.username,
                              recipientName: contact.username,
                              senderProfile: currentUser.profileUrl,
                              recipientProfile: contact.profileUrl,
                              uid: widget.uid,
                            ),
                          );
                        },
                        leading: SizedBox(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: profileWidget(imageUrl: contact.profileUrl),
                          ),
                        ),
                        title: Text("${contact.username}"),
                        subtitle: Text("${contact.status}"),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(color: tabColor),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator(color: tabColor));
        },
      ),
    );
  }
}

// logic to fetch contacts from device and show in contacts page

//  BlocBuilder<GetDeviceNumberCubit, GetDeviceNumberState>(
//         builder: (context, state) {
//           if(state is GetDeviceNumberLoaded){
//             final contacts = state.contacts;
//             return ListView.builder(
//             itemCount: contacts.length,
//             itemBuilder: (context, index) {
//               final contact = contacts[index];
//               return ListTile(
//                 leading: SizedBox(
//                   width: 50,
//                   height: 50,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(25),
//                     child: Image.memory(
//                       contact.photo ?? Uint8List(0),
//                       errorBuilder: (context,error,stackTrace){
//                         return Image.asset("assets/profile_default.png");
//                       },
//                     )
                    
//                     // profileWidget(),
//                   ),
//                 ),
//                 title: Text("${contact.name!.first} ${contact.name!.last}"),
//                 subtitle: Text("Hey there! I'm using WhatsApp"),
//               );
//             },
//           );

//           }
//           return Center(child: CircularProgressIndicator(color: tabColor,),);
          
//         },
//       ),
