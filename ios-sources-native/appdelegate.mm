#include "src/native_app.h"
#include "UIKit/UIKit.h"

/* IF YOU WANT TO USE THE IMPLEMENTATION, PLEASE ADD LIBRARY AT 'Build Phases' USING 'Xcode' PROGRAM. */
#import "UserNotifications/UserNotifications.h"     /* -> 'UserNotifications.framework' */
#import "AudioToolBox/AudioToolBox.h"               /* -> 'AudioToolbox.framework' */
#import "KakaoOpenSDK/KakaoOpenSDK.h"

/*********************************************/

#include <QtCore>

#define isOSVersionOver10 ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] integerValue] >= 10)

@interface QIOSApplicationDelegate
@end

@interface QIOSApplicationDelegate(AppDelegate)
- (void)loginFinished:(BOOL)isSuccess result:(NSString*)resultStr;
@end

@implementation QIOSApplicationDelegate (AppDelegate)

QString NativeApp::getDeviceId() const
{
    return "123456789101110";
}

void NativeApp::loginKakao()
{
    [[KOSession sharedSession] close];
    
    [[KOSession sharedSession] openWithCompletionHandler:^(NSError *error) {
       
        if([KOSession sharedSession].accessToken == nullptr)
        {
            [KOSessionTask meTaskWithCompletionHandler:^(KOUser* result, NSError *error) {
                NSString *uuid = [result.ID stringValue];
                
                NSString *name = [result propertyForKey:@"nickname"];
                if(name == nil) name = @"";
                
                NSString *email = [result propertyForKey:@"email"];
                if(email == nil) email = @"";
                
                NSString *profileImage = [result propertyForKey:@"profile_image"];
                if(profileImage == nil) profileImage = @"";
                
                NSString *thumbnailImage = [result propertyForKey:@"thumbnail.image"];
                if(thumbnailImage == nil) thumbnailImage = @"";

                NSDictionary* info = @{
                        @"id":uuid,
                        @"is_logined":@NO,
                        @"nickname":name,
                        @"email":email,
                        @"profile_image":profileImage,
                        @"thumbnail_image":thumbnailImage
                };
                
                NSData *infoObj = [NSJSONSerialization dataWithJSONObject:info options:0 error:nil];
                NSString *infoStr = [[NSString alloc] initWithData:infoObj encoding:NSUTF8StringEncoding];

                NativeApp* app = NativeApp::getInstance();
                if(app)
                {
                    const char* qresult = [infoStr UTF8String];
                    app->notifyLoginResult(true, qresult);
                }
                
                [KOSessionTask signupTaskWithProperties:nil completionHandler:^(BOOL success, NSError *error) {
                    if([[KOSession sharedSession] isOpen]) {
                        //login success
                        NSLog(@"connected succeed.");
                        
                    } else {
                        //failed
                        NSLog(@"connected failed.");
                    }
                }];
            }];
        }
        
        if([[KOSession sharedSession] isOpen]) {
            //login success
            NSLog(@"login succeed.");
            
        } else {
            //failed
            NSLog(@"login failed.");
        }
        
    } authType:(KOAuthType)KOAuthTypeTalk, nil];
}

void NativeApp::withdrawKakao()
{
    [KOSessionTask unlinkTaskWithCompletionHandler:^(BOOL success, NSError *error) {
        if(success) {
            NSLog(@"app disconnection success.");
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
        } else {
            // failed
            NSLog(@"failed to logout.");
        }
    }];
}

void NativeApp::loginFacebook()
{
    
}

void NativeApp::logoutFacebook()
{
    
}

void NativeApp::withdrawFacebook()
{
    
}
-(void)loginFinished:(BOOL)isSuccess result:(NSString*)resultStr
{
    NativeApp* app = NativeApp::getInstance();
    if(app)
    {
        const char* qresult = [resultStr UTF8String];
        app->notifyLoginResult(isSuccess, qresult);
    }
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([KOSession isKakaoAccountLoginCallback:url]) {
        return [KOSession handleOpenURL:url];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
            options:(NSDictionary<NSString *,id> *)options {
    
    if ([KOSession isKakaoAccountLoginCallback:url]) {
        return [KOSession handleOpenURL:url];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIViewController *qtController = [[[UIApplication sharedApplication] keyWindow]rootViewController];
        [KOSession sharedSession].automaticPeriodicRefresh = YES;
    // button position
//    int xMargin = 30;
//    int marginBottom = 25;
//    CGFloat btnWidth = qtController.view.frame.size.width - xMargin * 2;
//    int btnHeight = 42;
//
//    UIButton* kakaoLoginButton
//    = [[KOLoginButton alloc] initWithFrame:CGRectMake(xMargin, qtController.view.frame.size.height-btnHeight-marginBottom, btnWidth, btnHeight)];
//    kakaoLoginButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
//
//    [qtController.view addSubview:kakaoLoginButton];
//
//    [KOSession sharedSession].automaticPeriodicRefresh = YES;
    [KOSession sharedSession].clientSecret = @"fJhST4AaP9qg3rCU9c9THXGPveN2WsSc";
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
    [KOSession handleDidBecomeActive];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

}


@end
