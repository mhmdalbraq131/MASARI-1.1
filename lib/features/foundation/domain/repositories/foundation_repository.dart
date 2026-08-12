import '../entities/user_session.dart';

/// Foundation Repository Contract
abstract class FoundationRepository {
  Future<UserSession> getCurrentSession();
  Future<void> updateLanguage(String languageCode);
}
