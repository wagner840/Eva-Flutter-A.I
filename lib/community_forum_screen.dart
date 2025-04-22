import 'package:flutter/material.dart';
import 'package:eva_agricultura_urbana/services/firestore_service.dart';
import 'package:eva_agricultura_urbana/models/forum_post.dart';

class CommunityForumScreen extends StatefulWidget {
  const CommunityForumScreen({Key? key}) : super(key: key);

  @override
  _CommunityForumScreenState createState() => _CommunityForumScreenState();
}

class _CommunityForumScreenState extends State<CommunityForumScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Forum'),
      ),
      body: StreamBuilder<List<ForumPost>>(
        stream: _firestoreService.getForumPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ForumPost> posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                ForumPost post = posts[index];
                return Card(
                  child: ListTile(
                    title: Text(post.content ?? ''),
                    subtitle: Text('User: ${post.userId ?? ''} - ${post.timestamp}'),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String newPostContent = '';
              return AlertDialog(
                title: const Text('Create New Post'),
                content: TextFormField(
                  onChanged: (value) {
                    newPostContent = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your post content',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ForumPost newPost = ForumPost(
                        userId: 'placeholder_user', // Replace with actual user ID
                        content: newPostContent,
                        timestamp: DateTime.now(),
                      );
                      _firestoreService.addForumPost(newPost);
                      Navigator.pop(context);
                    },
                    child: const Text('Post'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
