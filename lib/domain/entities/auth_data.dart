class AuthData {
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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthData &&
        other.communityUrl == communityUrl &&
        other.loginUrl == loginUrl &&
        other.identityUrl == identityUrl &&
        other.userAgent == userAgent &&
        other.accessToken == accessToken &&
        other.communityId == communityId &&
        other.userId == userId &&
        other.orgId == orgId &&
        other.refreshToken == refreshToken &&
        other.instanceUrl == instanceUrl;
  }

  @override
  int get hashCode {
    return communityUrl.hashCode ^
        loginUrl.hashCode ^
        identityUrl.hashCode ^
        userAgent.hashCode ^
        accessToken.hashCode ^
        communityId.hashCode ^
        userId.hashCode ^
        orgId.hashCode ^
        refreshToken.hashCode ^
        instanceUrl.hashCode;
  }

  @override
  String toString() {
    return 'AuthData(communityUrl: $communityUrl, loginUrl: $loginUrl, identityUrl: $identityUrl, userAgent: $userAgent, accessToken: $accessToken, communityId: $communityId, userId: $userId, orgId: $orgId, refreshToken: $refreshToken, instanceUrl: $instanceUrl)';
  }
}
