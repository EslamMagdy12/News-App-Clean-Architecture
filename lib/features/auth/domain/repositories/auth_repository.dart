import 'package:news_app_clean_architecture/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signInWithEmailAndPassword(String email, String password);

  Future<UserEntity> signUpWithEmailAndPassword(
      UserEntity UserEntity, String password);

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<UserEntity> getUser();

  Future<UserEntity> loginWithGoogle();
}
