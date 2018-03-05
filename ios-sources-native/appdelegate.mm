#include "src/native_app.h"
#include "UIKit/UIKit.h"

/* IF YOU WANT TO USE THE IMPLEMENTATION, PLEASE ADD LIBRARY AT 'Build Phases' USING 'Xcode' PROGRAM. */
#import "UserNotifications/UserNotifications.h"     /* -> 'UserNotifications.framework' */
#import "AudioToolBox/AudioToolBox.h"               /* -> 'AudioToolbox.framework' */
#import "KakaoOpenSDK/KakaoOpenSDK.h"
#import "KakaoLink/KakaoLink.h"
#import "KakaoMessageTemplate/KakaoMessageTemplate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
/*********************************************/

#include <QtCore>

#define isOSVersionOver10 ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] integerValue] >= 10)

@interface SDKTask : NSObject
-(void)fetchFacebookUserInfo;
-(void)fetchKakaoUserInfo;
@end

@interface QIOSApplicationDelegate
@end

@interface QIOSApplicationDelegate(AppDelegate)
@end

@implementation SDKTask
-(void)fetchFacebookUserInfo
{
    FBSDKGraphRequest *requestMe = [[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:@{@"fields":@"id, name, email, picture"}];
    FBSDKGraphRequestConnection *connection = [[FBSDKGraphRequestConnection alloc] init];
    [connection addRequest:requestMe completionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        
        if(result)
        {
            NSString *uuid = @"";
            if([result objectForKey:@"id"]) uuid = [result objectForKey:@"id"];
            
            NSString *name = @"";
            if([result objectForKey:@"name"]) name = [result objectForKey:@"name"];
            
            NSString *email = @"";
            if([result objectForKey:@"email"]) email = [result objectForKey:@"email"];

            NSString *profileImage = @"";
            id picRst = [result objectForKey:@"picture"];
            if(picRst)
            {
                picRst = [picRst objectForKey:@"data"];
                if(picRst) {
                    picRst = [picRst objectForKey:@"url"];
                    if(picRst)
                        profileImage = (NSString*)picRst;
                }
            }
            
            NSDictionary* info = @{
                                   @"id":uuid,
                                   @"is_logined":@0,
                                   @"nickname":name,
                                   @"email":email,
                                   @"profile_image":profileImage,
                                   @"thumbnail_image":@""
                                   };
            
            NSData *infoObj = [NSJSONSerialization dataWithJSONObject:info options:0 error:nil];
            NSString *infoStr = [[NSString alloc] initWithData:infoObj encoding:NSUTF8StringEncoding];
            
            const char* qresult = [infoStr UTF8String];
            NativeApp* app = NativeApp::getInstance();
            if(!app) return;
            app->notifyLoginResult(true, qresult);
        }
        
    }];
    [connection start];
}
-(void)fetchKakaoUserInfo
{
    [KOSessionTask meTaskWithCompletionHandler:^(KOUser* result, NSError *error) {
        
        NSString *uuid = [result.ID stringValue];
        
        NSString *name = [result propertyForKey:@"nickname"];
        if(name == nil) name = @"";
        
        NSString *email = result.email;
        if(email == nil) email = @"";
        
        NSString *profileImage = [result propertyForKey:@"profile_image"];
        if(profileImage == nil) profileImage = @"";
        
        NSString *thumbnailImage = [result propertyForKey:@"thumbnail.image"];
        if(thumbnailImage == nil) thumbnailImage = @"";
        
        NSDictionary* info = @{
                               @"id":uuid,
                               @"is_logined":@0,
                               @"nickname":name,
                               @"email":email,
                               @"profile_image":profileImage,
                               @"thumbnail_image":thumbnailImage
                               };
        
        NSData *infoObj = [NSJSONSerialization dataWithJSONObject:info options:0 error:nil];
        NSString *infoStr = [[NSString alloc] initWithData:infoObj encoding:NSUTF8StringEncoding];
        
        const char* qresult = [infoStr UTF8String];
        NativeApp* app = NativeApp::getInstance();
        if(!app) return;
        app->notifyLoginResult(true, qresult);
    }];
}
@end

@implementation QIOSApplicationDelegate (AppDelegate)

QString NativeApp::getDeviceId()
{
    return "123456789101110";
}
void NativeApp::joinKakao()
{
    loginKakao();
}
void NativeApp::loginKakao()
{
    SDKTask *sdk = [SDKTask alloc];
    if([KOSession sharedSession].accessToken != nil)
    {
        [sdk fetchKakaoUserInfo];
        return;
    }
    
    [[KOSession sharedSession] close];
    [[KOSession sharedSession] openWithCompletionHandler:^(NSError *error) {

        if([[KOSession sharedSession] isOpen]) {
            //login success
            NSLog(@"login succeed.");
            [sdk fetchKakaoUserInfo];
            
        } else {
            //failed
            NSLog(@"login failed.");
            notifyLogoutResult(true);
        }
        
    } authType:(KOAuthType)KOAuthTypeTalk, nil];
}

void NativeApp::withdrawKakao()
{
//    logoutKakao();
    [KOSessionTask unlinkTaskWithCompletionHandler:^(BOOL success, NSError *error) {
        if(success) {
            NSLog(@"app disconnection success.");
            notifyWithdrawResult(true);
        } else {
            NSLog(@"app disconnection failed.");
        }
    }];
}

void NativeApp::logoutKakao()
{
    [[KOSession sharedSession] logoutAndCloseWithCompletionHandler:^(BOOL success, NSError *error) {
        if (success) {
            // logout success.
            NSLog(@"logout success.");
            notifyLogoutResult(true);
        } else {
            // failed
            NSLog(@"failed to logout.");
        }
    }];
}

void NativeApp::inviteKakao(QString senderId, QString image, QString title, QString desc, QString link)
{
    // Feed 타입 템플릿 오브젝트 생성
    KMTTemplate *template1 = [KMTFeedTemplate feedTemplateWithBuilderBlock:^(KMTFeedTemplateBuilder * _Nonnull feedTemplateBuilder) {
        
        // 컨텐츠
        feedTemplateBuilder.content = [KMTContentObject contentObjectWithBuilderBlock:^(KMTContentBuilder * _Nonnull contentBuilder) {
            contentBuilder.title = @"딸기 치즈 케익";
            contentBuilder.desc = @"#케익 #딸기 #삼평동 #까페 #분위기 #소개팅";
            contentBuilder.imageURL = [NSURL URLWithString:@"http://mud-kage.kakao.co.kr/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png"];
            contentBuilder.link = [KMTLinkObject linkObjectWithBuilderBlock:^(KMTLinkBuilder * _Nonnull linkBuilder) {
                linkBuilder.mobileWebURL = [NSURL URLWithString:@"https://developers.kakao.com"];
            }];
        }];
        
        // 소셜
        feedTemplateBuilder.social = [KMTSocialObject socialObjectWithBuilderBlock:^(KMTSocialBuilder * _Nonnull socialBuilder) {
            socialBuilder.likeCount = @(286);
            socialBuilder.commnentCount = @(45);
            socialBuilder.sharedCount = @(845);
        }];
        
        // 버튼
        [feedTemplateBuilder addButton:[KMTButtonObject buttonObjectWithBuilderBlock:^(KMTButtonBuilder * _Nonnull buttonBuilder) {
            buttonBuilder.title = @"웹으로 보기";
            buttonBuilder.link = [KMTLinkObject linkObjectWithBuilderBlock:^(KMTLinkBuilder * _Nonnull linkBuilder) {
                linkBuilder.mobileWebURL = [NSURL URLWithString:@"https://developers.kakao.com"];
            }];
        }]];
        [feedTemplateBuilder addButton:[KMTButtonObject buttonObjectWithBuilderBlock:^(KMTButtonBuilder * _Nonnull buttonBuilder) {
            buttonBuilder.title = @"앱으로 보기";
            buttonBuilder.link = [KMTLinkObject linkObjectWithBuilderBlock:^(KMTLinkBuilder * _Nonnull linkBuilder) {
                linkBuilder.iosExecutionParams = @"param1=value1&param2=value2";
                linkBuilder.androidExecutionParams = @"param1=value1&param2=value2";
            }];
        }]];
    }];
    NSLog(@"%@", template1);
    
    // 카카오링크 실행
//    [self.view startLoading];
    [[KLKTalkLinkCenter sharedCenter] sendDefaultWithTemplate:template1 success:^(NSDictionary<NSString *,NSString *> * _Nullable warningMsg, NSDictionary<NSString *,NSString *> * _Nullable argumentMsg) {
        
        // 성공
//        [self.view stopLoading];
        NSLog(@"warning message: %@", warningMsg);
        NSLog(@"argument message: %@", argumentMsg);
        
    } failure:^(NSError * _Nonnull error) {
        
        // 실패
//        [self.view stopLoading];
//        [self alertWithMessage:error.description];
        NSLog(@"error: %@", error);
        
    }];
}

void NativeApp::loginFacebook()
{
    SDKTask *sdk = [SDKTask alloc];
    if([FBSDKAccessToken currentAccessToken] != nil)
    {
        [sdk fetchFacebookUserInfo];
        return;
    }
    
    UIViewController *qCtrl = [[[UIApplication sharedApplication] keyWindow]rootViewController];
    FBSDKLoginManager* login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"public_profile", @"email"] fromViewController:qCtrl
        handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         
            NSMutableDictionary *info = [NSMutableDictionary dictionary];
            [info setObject:@0 forKey:@"is_logined"];
            
            if(error || result.isCancelled) {
                
                if(error)
                    [info setObject:error.localizedDescription forKey:@"error_message"];
                if(result.isCancelled)
                    [info setObject:@"is cancelled." forKey:@"error_message"];
                
                NSString *infoStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:info options:0 error:nil]
                                                          encoding:NSUTF8StringEncoding];
                notifyLoginResult(false, [infoStr UTF8String]);
                
            } else {
                [sdk fetchFacebookUserInfo];
            }
     }];
}

void NativeApp::logoutFacebook()
{
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    notifyLogoutResult(true);
}

void NativeApp::withdrawFacebook()
{
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me/permissions"
                                       parameters:nil
                                       HTTPMethod:@"DELETE"]
    
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if(result)
         {
             NSLog(@"withdraw facebook...");
             notifyWithdrawResult(true);
         } else {
             NSLog(@"failed withdraw facebook...");
         }
     }];
    

}

void NativeApp::inviteFacebook(QString senderId, QString image, QString title, QString desc, QString link)
{
    
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([KOSession isKakaoAccountLoginCallback:url]) {
        return [KOSession handleOpenURL:url];
    }
    
    return NO;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *,id> *)options {
    
    if([[FBSDKApplicationDelegate sharedInstance] application:application
                                                      openURL:url
                                            sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                   annotation:options[UIApplicationOpenURLOptionsAnnotationKey]])
        return NO;
    
    if ([KOSession isKakaoAccountLoginCallback:url]) {
        return [KOSession handleOpenURL:url];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [KOSession sharedSession].clientSecret = @"fJhST4AaP9qg3rCU9c9THXGPveN2WsSc";
    
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    [self initializeRemoteNotification];
    return YES;
}

- (void)initializeRemoteNotification {
    if(isOSVersionOver10) {
        NSLog(@"iOS >= 10");
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        //center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if(!error) {
                /* WHEN ENROLLED SUCCESSFULLY PUSH SERVICE, */
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            } else {
                /* WHEN WAS ABLED TO ENROLLE SUCCESSFULLY PUSH SERVICE, */
                
            }
        }];
    } else {
        NSLog(@"iOS < 10");
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)]) {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert |UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil]];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
    }
}

/* GET THE DEVICE TOKEN. */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken
{
    NSMutableString *tokenHex = [NSMutableString stringWithString:[deviceToken description]];
    [tokenHex replaceOccurrencesOfString:@"<" withString:@"" options:0 range:NSMakeRange(0, [tokenHex length])];
    [tokenHex replaceOccurrencesOfString:@">" withString:@"" options:0 range:NSMakeRange(0, [tokenHex length])];
    [tokenHex replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, [tokenHex length])];
    NSLog(@"Token origin : %@", deviceToken);
    NSLog(@"Token : %@", tokenHex);
}

/* iOS <= 9.0 : PUSH DELEGATE */
#pragma mark - Remote Notification Delegate <= iOS 9.x
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(nonnull UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

/* PROCESSING PUSH DATA */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"userInfo : %@", userInfo);
    
    /* TO RECEIVE AT PAYLOAD, PLEASE USE THE FOLLOWING LINES
     - NSDictionary* payload = [userInfo objectForKey:@"aps"];
     - NSString *message = [payload objectForKey:@"alert"];
     - NSString *soundName = [payload objectForKey:@"sound"]; */
    
    /* TO BOOL VALUE, USE LIKE THIS
     - BOOL isShow = [[userInfo objectForKey:@"show"] boolValue]; */
    
    int type = [[userInfo objectForKey:@"type"] intValue];
    NSLog(@"type : %d", type);
    
    if([UIApplication sharedApplication].applicationState == UIApplicationStateInactive)
    {
        NSLog(@"INACTIVE");
        completionHandler(UIBackgroundFetchResultNewData);
    }
    else if([UIApplication sharedApplication].applicationState == UIApplicationStateBackground)
    {
        NSLog(@"BACKGROUND");
        completionHandler(UIBackgroundFetchResultNewData);
    }
    else
    {
        NSLog(@"FOREGROUND");
        completionHandler(UIBackgroundFetchResultNewData);
    }
    
    
    /* IF WANT TO ALERT USING VIEW, PLEASE USE THE FOLLOWING LINES
     - UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ALERT" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
     - [alert show]; */
    
    /* YOU CAN SET NOTIFICATION OPTION USING THE FOLLOWING LINES
     - UILocalNotification *notification = [[UILocalNotification alloc]init];
     - notification.timeZone = [NSTimeZone systemTimeZone];
     - notification.alertBody = message;
     - [notification setSoundName:soundName];
     - notification.soundName = UILocalNotificationDefaultSoundName;
     - [[UIApplication sharedApplication] presentLocalNotificationNow:notification]; */
    
    /* USE THE FOWLLONG LINE, IF YOU WANT TO USE VIBRATE OPTION
     - AudioServicesPlayAlertSound(kSystemSoundID_Vibrate); */
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(nonnull NSError *)error {
    NSLog(@"Error : %@", error);
}

/* iOS >= 10 : PUSH DELEGATE */
#pragma mark - UNUserNotificationCenter Delegate for >= iOS 10
/* WHEN EXECUTING THE APP, PROCESS PUSH DATA */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(nonnull UNNotification *)notification withCompletionHandler:(nonnull void (^)(UNNotificationPresentationOptions))completionHandler {
    NSLog(@"Remote notification : %@", notification.request.content.userInfo);
    int type = [[notification.request.content.userInfo objectForKey:@"type"] intValue];
    NSLog(@"type : %d", type);
    
    /* FLOAT PUSH BANNER */
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionBadge);
}

/* WHEN EXECUTING THE APP BEHIND BACKGROUND OR QUITTED, PROCESS PUSH DATA */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(nonnull UNNotificationResponse *)response withCompletionHandler:(nonnull void (^)(void))completionHandler {
    NSLog(@"Remote notification : %@", response.notification.request.content.userInfo);
    int type = [[response.notification.request.content.userInfo objectForKey:@"type"] intValue];
    NSLog(@"type : %d", type);
    //    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionBadge);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [KOSession handleDidEnterBackground];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];
    [KOSession handleDidBecomeActive];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}


@end
