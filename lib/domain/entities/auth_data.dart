import 'package:equatable/equatable.dart';

class AuthData extends Equatable {
  final String communityUrl;
  final String loginUrl;
  final String identityUrl;
  final String userAgent;
  final String accessToken;
  final String communityId;
  final String userId;
  final String orgId;
  final String refreshToken;
  final String instanceUrl;
  AuthData({
    required this.communityUrl,
    required this.loginUrl,
    required this.identityUrl,
    required this.userAgent,
    required this.accessToken,
    required this.communityId,
    required this.userId,
    required this.orgId,
    required this.refreshToken,
    required this.instanceUrl,
  });

  @override
  String toString() {
    return 'AuthData(communityUrl: $communityUrl, loginUrl: $loginUrl, identityUrl: $identityUrl, userAgent: $userAgent, accessToken: $accessToken, communityId: $communityId, userId: $userId, orgId: $orgId, refreshToken: $refreshToken, instanceUrl: $instanceUrl)';
  }

  @override
  List<Object> get props {
    return [
      userId,
      orgId,
    ];
  }
}
