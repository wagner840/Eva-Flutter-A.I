import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_agricultura_urbana/models/forum_post.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addForumPost(ForumPost post) async {
    await _db.collection('forum_posts').add(post.toJson());
  }

  Stream<List<ForumPost>> getForumPosts() {
    return _db.collection('forum_posts').orderBy('timestamp', descending: true).snapshots().map((snapshot) => snapshot.docs.map((doc) => ForumPost.fromJson(doc.data() as Map<String, dynamic>)).toList());
  }

  Future<void> updateForumPost(ForumPost post) async {
    await _db.collection('forum_posts').doc(post.postId).update(post.toJson());
  }

  Future<void> deleteForumPost(String postId) async {
    await _db.collection('forum_posts').doc(postId).delete();
  }
}