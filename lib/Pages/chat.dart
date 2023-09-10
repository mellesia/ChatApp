import 'package:chat_app/Pages/cubits/chat_cubit.dart';
import 'package:chat_app/Widgets/ChatBuble.dart';
import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  final _controller = ScrollController();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            const Text('Chat'),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesList =
                    BlocProvider.of<ChatCubit>(context).messageList;
                return ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBuble(
                              message: messagesList[index],
                            )
                          : ChatBubleForFriend(message: messagesList[index]);
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: data, email: email.toString());
                // print(email);
                controller.clear();
                _controller.animateTo(0,
                    //el 7eta ely hay3rdha aly howa a5er message
                    // _controller.position.maxScrollExtent,
                    duration: Duration(seconds: 1),
                    //el animation
                    curve: Curves.fastOutSlowIn);
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.clear();
                    _controller.animateTo(0,
                        //el 7eta ely hay3rdha aly howa a5er message
                        // _controller.position.maxScrollExtent,
                        duration: Duration(seconds: 1),
                        //el animation
                        curve: Curves.fastOutSlowIn);
                  },
                  icon: const Icon(
                    Icons.send,
                    color: kPrimaryColor,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// return StreamBuilder<QuerySnapshot>(
// stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
// builder: (context, snapshot) {
// if (snapshot.hasData) {
// List<Message> messagesList = [];
// for (int i = 0; i < snapshot.data!.docs.length; i++) {
// messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
// }
