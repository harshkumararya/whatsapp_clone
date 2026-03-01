import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';

class SingleChatPage extends StatefulWidget {
  const SingleChatPage({super.key});

  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {

  final TextEditingController _textMessageController = TextEditingController();

  bool _isDisplaySendButton = false;
  @override
  void dispose() {
    _textMessageController.dispose();
    super.dispose();
  }

  bool _isShowAttachWindow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text("Username"),
            Text(
              "Online",
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          Icon(Icons.videocam_rounded, size: 25),
          SizedBox(width: 25),
          Icon(Icons.call, size: 25),
          SizedBox(width: 25),
          Icon(Icons.more_vert, size: 25),
          SizedBox(width: 15),
        ],
      ),
      body: GestureDetector(
        onTap: (){
          setState(() {
            _isShowAttachWindow = false;
            
          });
        },
        child: Stack(
          children: [
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              top: 0,
              child: Image.asset(
                "assets/whatsapp_bg_image.png",
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      _messageLayout(
                        message: "hello ",
                        alignment: Alignment.centerRight,
                        createAt: Timestamp.now(),
                        isSeen: false,
                        isShowTick: true,
                        messageBgColor: messageColor,
                        onLongPress: (){},
                      ),
                       _messageLayout(
                        message: "how are you? ",
                        alignment: Alignment.centerRight,
                        createAt: Timestamp.now(),
                        isSeen: false,
                        isShowTick: true,
                        messageBgColor: messageColor,
                        onLongPress: (){},
                      ),
                       _messageLayout(
                        message: "Hi ",
                        alignment: Alignment.centerLeft,
                        createAt: Timestamp.now(),
                        isSeen: false,
                        isShowTick: false,
                        messageBgColor: senderMessageColor,
                        onLongPress: (){},
                      ),
                       _messageLayout(
                        message: "Doing good What about you? ",
                        alignment: Alignment.centerLeft,
                        createAt: Timestamp.now(),
                        isSeen: false,
                        isShowTick: false,
                        messageBgColor: senderMessageColor,
                        onLongPress: (){},
                      )
                
              
                    ],
                  ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: appBarColor,
                              borderRadius: BorderRadius.circular(25),
        
                            ),
                            height: 50,
                            child: TextField(
                              onTap: (){
                                setState(() {
                                  _isShowAttachWindow = false;
                                });
                              },
                              controller: _textMessageController,
                              onChanged: (value){
                                if(value.isNotEmpty){
                                  setState(() {
                                    _isDisplaySendButton = true;
                                  });
                                }else{
                                  setState(() {
                                    _isDisplaySendButton = false;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 15),
                                prefixIcon: Icon(Icons.emoji_emotions,color:greyColor ,),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Wrap(
                                    children: [
                                      Transform.rotate(
                                        angle: -0.5,
                                        child: GestureDetector(
                                          onTap:(){
                                            setState(() {
                                              _isShowAttachWindow = !_isShowAttachWindow;
                                            });
                                          } ,
                                          child: Icon(Icons.attach_file,color: greyColor,))),
                                      SizedBox(width: 15,),
                                      Icon(Icons.camera_alt,color: greyColor,),
                                      SizedBox(width: 10,),
                                  
                                    ],
                                  ),
                                ),
                                hintText: "Message",
                                border: InputBorder.none,
        
                              ),
                            ) ,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: tabColor,
                          ),
                          child: Center(
                            child: Icon(
                              _isDisplaySendButton ? Icons.send_outlined : Icons.mic,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  
        
                  ],
            ),
        
           _isShowAttachWindow == true ?  Positioned(
                    bottom: 65,
                    top: 340,
                    left: 15,
                    right: 15,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width*0.20,
                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 20),
                      decoration: BoxDecoration(
                        color: bottomAttachContainerColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _attachWindowItem(
                                icon : Icons.document_scanner,
                                color: Colors.deepPurpleAccent,
                                title: "Document",
                              ),
                              _attachWindowItem(
                                icon : Icons.camera_alt,
                                color: Colors.pinkAccent,
                                title: "Camera",
                              ),
                              _attachWindowItem(
                                icon : Icons.image,
                                color: Colors.purpleAccent,
                                title: "Gallery",
                              ),
        
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _attachWindowItem(
                                icon : Icons.headphones,
                                color: Colors.deepOrange,
                                title: "Audio",
                              ),
                              _attachWindowItem(
                                icon : Icons.location_on,
                                color: Colors.green,
                                title: "Location",
                              ),
                              _attachWindowItem(
                                icon : Icons.account_circle,
                                color: Colors.deepPurpleAccent,
                                title: "Gallery",
                              ),
        
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _attachWindowItem(
                                icon : Icons.bar_chart,
                                color: Colors.indigoAccent,
                                title: "Poll",
                              ),
                              _attachWindowItem(
                                icon : Icons.gif_box_outlined,
                                color: Colors.pinkAccent,
                                title: "Gif",
                                onTap: (){},
                              ),
                              _attachWindowItem(
                                icon : Icons.videocam_rounded,
                                color: Colors.green,
                                title: "Gallery",
                              ),
        
                            ],
                          ),
                        ],
                      ),
                      
                    ),
                  
        
                  ) : Container(),
        
          ],
        ),
      ),
    );
  }

  _messageLayout({
    Color? messageBgColor,
    Alignment? alignment,
    Timestamp? createAt,
    Function(DragUpdateDetails)? onSwipe,
    String? message,
    bool? isShowTick,
    bool? isSeen,
    VoidCallback? onLongPress,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: SwipeTo(
        onRightSwipe: onSwipe,
        child: GestureDetector(
          onLongPress: onLongPress,
          child: Container(
            alignment: alignment,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.only(top: 5,left: 5,bottom: 5,right: 85),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.8,
                      ),
                      decoration: BoxDecoration(
                        color: messageBgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "$message",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 3),
                  ],
                ),
                Positioned(
                  bottom: 4,
                  right: 10,
                  child: Row(
                    children: [
                      Text(
                        DateFormat.jm().format(createAt!.toDate()),
                        style: TextStyle(fontSize: 12, color: greyColor),
                      ),
                      SizedBox(width: 5),
                      isShowTick == true
                          ? Icon(
                              isSeen == true ? Icons.done_all : Icons.done,
                              size: 16,
                              color: isSeen == true ? Colors.blue : greyColor,
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  _attachWindowItem({
    IconData? icon,
    Color? color,
    String? title,
    VoidCallback? onTap,
  }){
    return GestureDetector(
      onTap:  onTap,
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: color,
            ),
            child: Icon(icon),
          ),
          SizedBox(height: 5,),
          Text(
            "$title",
            style: TextStyle(color: greyColor,fontSize: 13),
          ),
        ],
      ),
    );
  }
}
