/*
 Copyright (c) 2018-present, salesforce.com, inc. All rights reserved.

 Redistribution and use of this software in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions
 and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of
 conditions and the following disclaimer in the documentation and/or other materials provided
 with the distribution.
 * Neither the name of salesforce.com, inc. nor the names of its contributors may be used to
 endorse or promote products derived from this software without specific prior written
 permission of salesforce.com, inc.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "SFOauthFlutterBridge.h"
#import <SalesforceSDKCore/NSDictionary+SFAdditions.h>
#import <SalesforceSDKCore/SFRestAPI+Blocks.h>
#import <SalesforceSDKCore/SalesforceSDKManager.h>
#import <SalesforceSDKCore/SFUserAccountManager.h>

@implementation SFOauthFlutterBridge

- (NSString*) prefix {
    return @"oauth";
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"oauth#getAuthCredentials" isEqualToString:call.method]) {
        result([self getAuthCredentials:call.arguments]);
    } else if ([@"oauth#getClientInfo" isEqualToString:call.method]) {
       result([self getClientInfo:call.arguments]);
    } else if ([@"oauth#logoutCurrentUser" isEqualToString:call.method]) {
       result([self logoutCurrentUser:call.arguments]);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (NSString*) getAuthCredentials:(NSDictionary *)argsDict
{

    SFOAuthCredentials *creds = [SFUserAccountManager sharedInstance].currentUser.credentials;
    NSDictionary *credentialsDict = nil;
    if (nil != creds) {

            credentialsDict = @{
                               @"communityUrl": creds.communityUrl.absoluteString,
                               @"loginUrl": creds.communityUrl.absoluteString,
                               @"identityUrl": creds.identityUrl.absoluteString,
                               @"userAgent": @"",
                               @"accessToken": creds.accessToken,
                               @"communityId": creds.communityId,
                               @"userId": creds.userId,
                               @"orgId": creds.organizationId,
                               @"refreshToken": creds.refreshToken,
                               @"instanceUrl": creds.instanceUrl.absoluteString,
                               };
        }
        else
        {
            return @"No restClient - getAuthCredentials";
        }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:credentialsDict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;


}

- (SFOAuthCredentials*) getClientInfo:(NSDictionary *)argsDict
{
    SFOAuthCredentials *creds = [SFUserAccountManager sharedInstance].currentUser.credentials;
    return creds;
}

- (NSString*) logoutCurrentUser:(NSDictionary *)argsDict
{
    //[SalesforceSDKManager sharedManager].postLogoutAction = ^{
    //   [weakSelf handleSdkManagerLogout];
    //};

    return @"success";
}

@end
