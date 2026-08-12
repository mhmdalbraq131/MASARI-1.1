import '../../domain/entities/user_session.dart';
import '../../domain/repositories/foundation_repository.dart';

/// Foundation Repository Implementation
class FoundationRepositoryImpl implements FoundationRepository {
  @override
  Future<UserSession> getCurrentSession() async {
    return UserSession.guest();
  }

  @override
  Future<void> updateLanguage(String languageCode) async {
    // Language update persistence logic
  }
}
