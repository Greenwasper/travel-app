import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CHAT'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Stories section
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildStoryAvatar('You'),
                _buildStoryAvatar('Sam'),
                _buildStoryAvatar('Tom'),
                _buildStoryAvatar('Jeff'),
                _buildStoryAvatar('TR'),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildChatItem('Tom', 'Hello', '1m'),
                _buildChatItem('Jeff', 'You there?', '1h'),
                _buildChatItem('Michelle', 'What?', 'Wed'),
                _buildChatItem('Sara', '', '05 Feb'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryAvatar(String name) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            child: Text(name[0]),
          ),
          SizedBox(height: 4),
          Text(name),
        ],
      ),
    );
  }

  Widget _buildChatItem(String name, String message, String time) {
    return ListTile(
      leading: CircleAvatar(child: Text(name[0])),
      title: Text(name),
      subtitle: Text(message),
      trailing: Text(time),
    );
  }
}