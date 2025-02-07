import '../../../../domain/entities/user_entity.dart';

abstract class AuthOnlineDataSource {
  Future<UserEntity> signInWithEmailAndPassword(String email, String password);

  Future<UserEntity> signUpWithEmailAndPassword(
      UserEntity userEntity, String password);

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<UserEntity> getUser();
}
