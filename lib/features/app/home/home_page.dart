import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/const/page_const.dart';
import 'package:whatsapp_clone/features/app/home/contacts_page.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';
import 'package:whatsapp_clone/features/call/presentation/pages/call_contacts_page.dart';
import 'package:whatsapp_clone/features/call/presentation/pages/call_history_page.dart';
import 'package:whatsapp_clone/features/chat/presentation/pages/chat_page.dart';
import 'package:whatsapp_clone/features/status/presentation/pages/status_page.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({super.key, required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController!.addListener(() {
      setState(() {
        _currentTabIndex = _tabController!.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WhatsApp",
          style: TextStyle(
            fontSize: 20,
            color: greyColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Row(
            children: [
              Icon(Icons.camera_alt_outlined, color: greyColor, size: 28),
              SizedBox(width: 25),
              Icon(Icons.search, color: greyColor, size: 28),
              SizedBox(width: 10),
              // Icon(Icons.more_vert,color: greyColor,size: 28,)
              PopupMenuButton(
                icon: Icon(Icons.more_vert, color: greyColor, size: 28),
                color: appBarColor,
                iconSize: 28,
                onSelected: (value) {},
                itemBuilder: (context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: "Settings",
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          PageConst.settingsPage,
                          arguments: widget.uid,
                        );
                      },
                      child: Text("Settings"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
        bottom: TabBar(
          labelColor: tabColor,
          unselectedLabelColor: greyColor,
          indicatorColor: tabColor,
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                "Chats",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Tab(
              child: Text(
                "Status",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Tab(
              child: Text(
                "Calls",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: switchFloatingActionButtonOnTabIndex(
        _currentTabIndex,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [ChatPage(), StatusPage(), CallHistoryPage()],
      ),
    );
  }

  switchFloatingActionButtonOnTabIndex(int index) {
    switch (index) {
      case 0:
        {
          return FloatingActionButton(
            backgroundColor: tabColor,
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactsPage()));

              Navigator.pushNamed(context, PageConst.contactUsersPage);
            },
            child: Icon(Icons.message, color: Colors.white),
          );
        }
      case 1:
        {
          return FloatingActionButton(
            backgroundColor: tabColor,
            onPressed: () {},
            child: Icon(Icons.camera_alt, color: Colors.white),
          );
        }
      case 2:
        {
          return FloatingActionButton(
            backgroundColor: tabColor,
            onPressed: () {
              Navigator.pushNamed(context, PageConst.callContactsPage);
            },
            child: Icon(Icons.add_call, color: Colors.white),
          );
        }
      default:
        {
          return FloatingActionButton(
            backgroundColor: tabColor,
            onPressed: () {},
            child: Icon(Icons.message, color: Colors.white),
          );
        }
    }
  }
}
