#include "src/native_app.h"
#include "UIKit/UIKit.h"

/* IF YOU WANT TO USE THE IMPLEMENTATION, PLEASE ADD LIBRARY AT 'Build Phases' USING 'Xcode' PROGRAM. */
#import "UserNotifications/UserNotifications.h"     /* -> 'UserNotifications.framework' */
#import "AudioToolBox/AudioToolBox.h"               /* -> 'AudioToolbox.framework' */
/*********************************************/

#include <QtCore>

#define isOSVersionOver10 ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] integerValue] >= 10)

@interface QIOSApplicationDelegate
@end

@interface QIOSApplicationDelegate(AppDelegate)
@end

@implementation QIOSApplicationDelegate (AppDelegate)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
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
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionBadge);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
