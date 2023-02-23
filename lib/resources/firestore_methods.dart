import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/posts.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// upload post
Future<String> uploadPost(
  String description,
  Uint8List file,
  String uid,
  String username,
  String profImage,
) async {
  String res = "Some error occured";

  String postId = const Uuid().v1();
  try {
    String photoUrl =
        await StorageMethods().uploadImageToStorage("posts", file, true);

    Posts posts = Posts(
      description: description,
      uid: uid,
      username: username,
      postId: postId,
      datePublished: DateTime.now().toString(),
      postUrl: photoUrl,
      profImage: profImage,
      likes: [],
    );
  } catch (e) {}
}
