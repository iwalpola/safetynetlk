class UserModel {
  String? fbID;
  final String? uid, name, email, city, country, photoProfile;
  final Future<void> Function() signOut, signInWithFacebook;
  final Future<String> Function(
      {required String email, required String password}) signUp, signIn;
  final Future<String> Function(
      {required String name,
      required String country,
      required String city,
      required String photoProfile,
      required String uid}) update;

  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.city,
      this.country,
      this.photoProfile,
      required this.update,
      required this.signIn,
      required this.signUp,
      required this.signInWithFacebook,
      required this.signOut});
}
