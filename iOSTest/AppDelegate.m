//
//  AppDelegate.m
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

#import "AppDelegate.h"
#import "iOSTest-Swift.h"
#import "HexToRGBConvertor.h"

@interface AppDelegate ()
@property (nonatomic, strong) UINavigationController *navController;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    MenuViewController *mainMenuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:mainMenuViewController];
    [self.navController setNavigationBarHidden:NO];
    self.window.rootViewController = self.navController;

    UIBarButtonItem *Back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:nil];
    Back.tintColor = UIColor.whiteColor;
    self.navController.navigationBar.topItem.backBarButtonItem = Back;
    
    

    HexToRGBConvertor *controller = [[HexToRGBConvertor alloc]init];
    self.navController.navigationBar.barTintColor = [controller colorWithHexString:@"#0E5C89"];
    
    UINavigationBar *bar = [self.navController navigationBar];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    return YES;
}

@end
