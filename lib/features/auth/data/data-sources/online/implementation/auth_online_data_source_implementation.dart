import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app_clean_architecture/core/utils/mapper.dart';
import 'package:news_app_clean_architecture/features/auth/domain/entities/user_entity.dart';
import '../../../models/user_model.dart';
import '../contract/auth_online_data_source.dart';

@Injectable(as: AuthOnlineDataSource)
class AuthOnlineDataSourceImplementation implements AuthOnlineDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthOnlineDataSourceImplementation(
      this._firebaseAuth, this._firebaseFirestore);

  @override
  Future<UserEntity> getUser() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) {
      throw Exception("No user is currently signed in.");
    }
    // Retrieve the Firestore document corresponding to the user.
    final docSnapshot = await _firebaseFirestore
        .collection('users')
        .doc(firebaseUser.uid)
        .get();
    if (!docSnapshot.exists) {
      throw Exception("User data not found in Firestore.");
    }
    // Convert the Firestore document into a UserModel.
    final userModel = UserModel.fromFirestore(docSnapshot);
    // Return a UserEntity by mapping the model.
    return userModel.toEntity();
  }

  @override
  Future<bool> isSignedIn() async {
    return _firebaseAuth.currentUser != null;
  }

  @override
  Future<UserEntity> signInWithEmailAndPassword(
      String email, String password) async {
    final UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final firebaseUser = userCredential.user;
    if (firebaseUser == null) {
      throw Exception("Sign in failed.");
    }
    // Retrieve the user document from Firestore.
    final docSnapshot = await _firebaseFirestore
        .collection('users')
        .doc(firebaseUser.uid)
        .get();
    if (!docSnapshot.exists) {
      throw Exception("User data not found in Firestore.");
    }
    final userModel = UserModel.fromFirestore(docSnapshot);
    return userModel.toEntity();
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<UserEntity> signUpWithEmailAndPassword(
      UserEntity userEntity, String password) async {
    // TODO: implement signUpWithEmailAndPassword
    try {
      final formattedPhoneNumber =
          userEntity.phone.replaceAll(RegExp(r'\s+'), "".trim());
      final emailExists = await _firebaseFirestore
          .collection('users')
          .where('email', isEqualTo: userEntity.email)
          .get()
          .then((value) => value.docs.isNotEmpty);
      if (emailExists) {
        throw "An account with the same email already exists";
      }
      final phoneNumberExists = await _firebaseFirestore
          .collection('users')
          .where('phone', isEqualTo: formattedPhoneNumber)
          .get()
          .then((value) => value.docs.isNotEmpty);
      if (phoneNumberExists) {
        throw "An account with the same phone already exists";
      }
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: userEntity.email,
        password: password,
      );
      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw Exception("Sign up failed.");
      }
      // Convert the UserEntity into a UserModel.
      final userModel = UserModel(
        id: firebaseUser.uid,
        email: userEntity.email,
        fullname: userEntity.fullname,
        username: userEntity.username,
        phone: userEntity.phone,
      );
      // Save the user data to Firestore.
      await _firebaseFirestore.collection('users').doc(firebaseUser.uid).set(
            userModel.toMap(),
          );
      return userModel.toEntity();
    } catch (e) {
      throw Exception(e);
    }
  }
}
