import 'package:injectable/injectable.dart';
import 'package:news_app_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:news_app_clean_architecture/features/auth/domain/repositories/auth_repository.dart';

import '../data-sources/online/contract/auth_online_data_source.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImplementation implements AuthRepository {
  final AuthOnlineDataSource _authOnlineDataSource;

  AuthRepositoryImplementation(this._authOnlineDataSource);

  @override
  Future<UserEntity> getUser() {
    // TODO: implement getUser
    return _authOnlineDataSource.getUser();
  }

  @override
  Future<bool> isSignedIn() {
    // TODO: implement isSignedIn
    return _authOnlineDataSource.isSignedIn();
  }

  @override
  Future<UserEntity> signInWithEmailAndPassword(String email, String password) {
    // TODO: implement signInWithEmailAndPassword
    return _authOnlineDataSource.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    return _authOnlineDataSource.signOut();
  }

  @override
  Future<UserEntity> signUpWithEmailAndPassword(
      UserEntity userEntity, String password) {
    // TODO: implement signUpWithEmailAndPassword
    return _authOnlineDataSource.signUpWithEmailAndPassword(
        userEntity, password);
  }

  @override
  Future<UserEntity> loginWithGoogle() {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }
}
