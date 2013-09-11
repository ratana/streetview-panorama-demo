#import "SVPDAppDelegate.h"
#import "SVPDViewController.h"
#import "APIKey.h"
#import <GoogleMaps/GoogleMaps.h>

@implementation SVPDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if ([APIKey length] == 0) {
        // Blow up if APIKey has not yet been set.
        NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
        NSString *reason =
        [NSString stringWithFormat:@"Configure APIKey inside APIKey.h for your bundle `%@`, see README for more information", bundleId];
        @throw [NSException exceptionWithName:@"SDKDemosAppDelegate"
                                       reason:reason
                                     userInfo:nil];
    }
    [GMSServices provideAPIKey:(NSString *)APIKey];
    
    NSLog(@"Open-source licenses info:\n%@\n", [GMSServices openSourceLicenseInfo]);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[SVPDViewController alloc] init];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}
@end