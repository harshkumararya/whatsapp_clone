import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/features/app/const/page_const.dart';
import 'package:whatsapp_clone/features/app/global/widgets/dialog_widget.dart';
import 'package:whatsapp_clone/features/app/global/widgets/profile_widget.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:whatsapp_clone/features/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';

class SettingsPage extends StatefulWidget {
  final String uid;
  const SettingsPage({super.key, required this.uid});

  

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
              builder: (context, state) {
                if(state is GetSingleUserLoaded){
                  final singleUser = state.singleUser;
                  return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PageConst.editProfilePage,arguments: singleUser);
                      },
                      child: SizedBox(
                        width: 65,
                        height: 65,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32.5),
                          child: profileWidget(imageUrl: singleUser.profileUrl),
                        ),
                      ),
                    ),

                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${singleUser.username}", style: TextStyle(fontSize: 15)),
                          Text(
                            "${singleUser.status}",
                            style: TextStyle(color: greyColor),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.qr_code_sharp, color: tabColor),
                  ],
                );

                }

                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PageConst.editProfilePage);
                      },
                      child: SizedBox(
                        width: 65,
                        height: 65,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32.5),
                          child: profileWidget(),
                        ),
                      ),
                    ),

                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Username", style: TextStyle(fontSize: 15)),
                          Text(
                            "While true { code() }",
                            style: TextStyle(color: greyColor),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.qr_code_sharp, color: tabColor),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 2),
          Divider(height: 2, color: greyColor.withValues(alpha: 0.4)),
          SizedBox(height: 10),
          _settingsItemWidget(
            title: "Account",
            description: "Security applications, change number",
            icon: Icons.key,
            onTap: () {},
          ),
          _settingsItemWidget(
            title: "Privacy",
            description: "Block contacts, disappearing messages",
            icon: Icons.lock,
            onTap: () {},
          ),
          _settingsItemWidget(
            title: "Chats",
            description: "Theme, wallpapers, chat history",
            icon: Icons.message,
            onTap: () {},
          ),
          _settingsItemWidget(
            title: "LogOut",
            description: "LogOut from whatsApp",
            icon: Icons.exit_to_app,
            onTap: () {
              displayAlertDialog(
                context, 
                onTap: (){
                  BlocProvider.of<AuthCubit>(context).loggedOut();
                  Navigator.pushNamedAndRemoveUntil(context, PageConst.welcomePage, (Route<dynamic> route)=>false);
                }, 
                confirmTitle: "Logout", 
                content: "Are you sure you want to logout?"
              );
            },
          ),
        ],
      ),
    );
  }

  _settingsItemWidget({
    String? title,
    String? description,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Icon(icon, color: greyColor, size: 25),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$title", style: const TextStyle(fontSize: 17)),
                const SizedBox(height: 3),
                Text("$description", style: const TextStyle(color: greyColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
