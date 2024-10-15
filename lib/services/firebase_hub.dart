
// abstract class FirebaseHub {
//   Stream<UserData> userProfile(String userEmail);
// }

// class FirebaseServices implements FirebaseHub {
//   @override
//   Stream<UserData> userProfile(String userEmail) {
//     var ref =
//         FBCollections.users.doc(userEmail).snapshots().asBroadcastStream();
//     var x = ref.map((event) => UserData.fromJson(event.data()));
//     return x;
//   }
// }
