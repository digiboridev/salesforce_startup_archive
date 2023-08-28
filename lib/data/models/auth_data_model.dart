import 'package:salesforce.startup/domain/entities/auth_data.dart';

class AuthDataModel extends AuthData {
  AuthDataModel({
    required String communityUrl,
    required String loginUrl,
    required String identityUrl,
    required String userAgent,
    required String accessToken,
    required String communityId,
    required String userId,
    required String orgId,
    required String refreshToken,
    required String instanceUrl,
  }) : super(
            communityUrl: communityUrl,
            loginUrl: loginUrl,
            identityUrl: identityUrl,
            userAgent: userAgent,
            accessToken: accessToken,
            communityId: communityId,
            userId: userId,
            orgId: orgId,
            refreshToken: refreshToken,
            instanceUrl: instanceUrl);

  factory AuthDataModel.fromMap(Map<String, dynamic> map) {
    return AuthDataModel(
      communityUrl: map['communityUrl'] ?? '',
      loginUrl: map['loginUrl'] ?? '',
      identityUrl: map['identityUrl'] ?? '',
      userAgent: map['userAgent'] ?? '',
      accessToken: map['accessToken'] ?? '',
      communityId: map['communityId'] ?? '',
      userId: map['userId'] ?? '',
      orgId: map['orgId'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      instanceUrl: map['instanceUrl'] ?? '',
    );
  }
}
