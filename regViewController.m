//
//  regViewController.m
//  styler
//
//  Created by vishnu Mindbees on 13/03/17.
//  Copyright © 2017 Quickblox. All rights reserved.
//

#import "regViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface regViewController ()

@end

@implementation regViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)connectfbButton:(id)sender
{
    
    defaults=[NSUserDefaults standardUserDefaults];
//    if ([[defaults objectForKey:@"net"] isEqualToString:@"ON"])
//    {
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logOut];
        [login logInWithReadPermissions:@[@"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error) {
                // Process error
                NSLog(@"error %@",error);
            } else if (result.isCancelled) {
                // Handle cancellations
                NSLog(@"Cancelled");
            } else {
                if ([result.grantedPermissions containsObject:@"email"]) {
                    
                    [self fetchUserInfo];
                }
            }
        }];
//    }
//    else
//    {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Sin conexión a internet. Revisa tu conexión " delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//        [alert show];
//    }
    
}
-(void)fetchUserInfo {
    //    self.locationManager = [[CLLocationManager alloc] init];
    //    [self.locationManager setDelegate:self];
    //    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //
    //#ifdef __IPHONE_8_0
    //    if(IS_OS_8_OR_LATER) {
    //        // Use one or the other, not both. Depending on what you put in info.plist
    //        [self.locationManager requestWhenInUseAuthorization];
    //        [self.locationManager requestAlwaysAuthorization];
    //    }
    //#endif
    //    [self.locationManager startUpdatingLocation];
    if ([FBSDKAccessToken currentAccessToken]) {
        
        //   NSLog(@"Token is available");
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 
                 NSLog(@"Fetched User Information:%@", result);
                 NSLog(@"FB user first name:%@",[result objectForKey:@"id"]);
                 NSLog(@"FB user last name:%@",[result objectForKey:@"last_name"]);
                 NSLog(@"FB user first name:%@",[result objectForKey:@"first_name"]);
                 NSLog(@"FB user birthday:%@",[result objectForKey:@"birthday"]);
                 
                 NSLog(@"FB user username:%@",[result objectForKey:@"name"]);
                 NSLog(@"FB user gender:%@",[result objectForKey:@"gender"]);
                 NSLog(@"email id:%@",[result objectForKey:@"email"]);
                 
                 NSString *fbid=[result objectForKey:@"id"];
                 NSString *usrname=[result objectForKey:@"name"];
                 NSString *fisrtnm=[result objectForKey:@"first_name"];
                 NSString *lastnm=[result objectForKey:@"last_name"];
                 NSString *emailval=[result objectForKey:@"email"];
                 NSString *gendr=[result objectForKey:@"gender"];
                 NSString *bdayval=[result objectForKey:@"birthday"];
                 
                 defaults=[NSUserDefaults standardUserDefaults];
                 [defaults setObject:usrname forKey:@"username"];
                 [defaults setObject:fbid forKey:@"fbId"];
                 [defaults setObject:fisrtnm forKey:@"firstname"];
                 [defaults setObject:lastnm forKey:@"lastname"];
                 
                 
                 [defaults setObject:emailval forKey:@"fbEmail"];
                 [defaults setObject:gendr forKey:@"ugender"];
                 [defaults setObject:bdayval forKey:@"ubirthday"];
                 [defaults synchronize];
                 
                 
                 if ([[defaults objectForKey:@"net"] isEqualToString:@"ON"]) {
                     
                    
                   //  [HUD showWhileExecuting:@selector(fblogin) onTarget:self withObject:nil animated:YES];
                     
                 }
                 else {
                     UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Sin conexión a internet. Revisa tu conexión" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                     [alert show];
                 }
                 
                 
                 
                 
             }
             else
             {
                 NSLog(@"Error %@",error);
             }
         }];
        
    } else
    {
        
        NSLog(@"User is not Logged in");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
