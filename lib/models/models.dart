import 'package:cloud_firestore/cloud_firestore.dart';

class UserModels {
  final String username;
  final String uid;
  final String email;
  final String bio;
  final List followers;
  final List following;
  final String photoUrl;

  UserModels({
    required this.username,
    required this.uid,
    required this.email,
    required this.bio,
    required this.followers,
    required this.following,
    required this.photoUrl,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "bio": bio,
        "followers": followers,
        "following": following,
        "photoUrl": photoUrl
      };

  static UserModels fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModels(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      bio: snapshot["bio"],
      followers: snapshot["followers"],
      following: snapshot["following"],
      photoUrl: snapshot["photoUrl"],
    );
  }
}
