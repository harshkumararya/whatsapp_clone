import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/const/page_const.dart';
import 'package:whatsapp_clone/features/app/home/contacts_page.dart';
import 'package:whatsapp_clone/features/app/settings/settings_page.dart';
import 'package:whatsapp_clone/features/call/presentation/pages/call_contacts_page.dart';
import 'package:whatsapp_clone/features/chat/presentation/pages/single_chat_page.dart';
import 'package:whatsapp_clone/features/status/presentation/pages/my_status_page.dart';
import 'package:whatsapp_clone/features/user/domain/entities/user_entity.dart';
import 'package:whatsapp_clone/features/user/presentation/pages/edit_profile_page.dart';

class OnGenerateRoutes {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;
    final name = settings.name;
    switch (name) {
      case PageConst.contactUsersPage:
        {
          return materialPageBuilder(ContactsPage());
        }

      case PageConst.settingsPage:
        {
          if (args is String) {
            return materialPageBuilder(SettingsPage(uid: args));
          } else {
            return materialPageBuilder(const ErrorPage());
          }
        }

      case PageConst.editProfilePage:
        {
          if (args is UserEntity) {
            return materialPageBuilder(EditProfilePage(currentUser: args));
          } else {
            return materialPageBuilder(const ErrorPage());
          }
        }

      case PageConst.callContactsPage:
        {
          return materialPageBuilder(CallContactsPage());
        }
      case PageConst.myStatusPage:
        {
          return materialPageBuilder(MyStatusPage());
        }

      case PageConst.singleChatPage:
        {
          return materialPageBuilder(SingleChatPage());
        }
    }
  }
}

dynamic materialPageBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Error")),
      body: const Center(child: Text("Error")),
    );
  }
}
