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
#import "KVNProgress.h"
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
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name,email,first_name,last_name,gender,age_range,birthday"}]
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
                 
                 
                 NSString *check=[defaults objectForKey:@"reachability"];
                 NSLog(@"De connection is - %@",check);
                 if([check isEqualToString:@"online"])
                 {
                     
                     [KVNProgress show];
                     NSOperationQueue *queue = [NSOperationQueue new];
                     NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(fblogin) object:nil];
                     [queue addOperation:operation];
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
-(void)fblogin
{
    defaults=[NSUserDefaults standardUserDefaults];
    NSString *post=[NSString stringWithFormat:@"fb_id=%@",[defaults valueForKey:@"fbId"]];
    NSLog(@"ambada--%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSURL *theURL = [NSURL URLWithString:@"http://preview.proyectoweb.com/stylerapp/webservice/v1/facebooklogin"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
    
    //Specify method of request(Get or Post)
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    // Pass some default parameter(like content-type etc.)
    // [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    // [theRequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    //Now pass your own parameter
    
    [theRequest setValue:@"hhbits" forHTTPHeaderField:@"Oakey"];
    //  [theRequest setValue:@"fb" forHTTPHeaderField:@"Methoda"];
    [theRequest setHTTPBody:postData];
    
    NSURLResponse *theResponse = NULL;
    NSError *theError = NULL;
    NSData *theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
    // NSDictionary *dataDictionaryResponse;
    if (theResponseData == nil)
    {
        NSLog(@"no data grid");
    }
    else
    {
        dataDictionaryResponse = [NSJSONSerialization JSONObjectWithData:theResponseData options:0 error:&theError];
        NSLog(@"url to send request= %@",dataDictionaryResponse);
    }
    
    
    
    defaults = [NSUserDefaults standardUserDefaults];
    NSArray *vals=[dataDictionaryResponse valueForKeyPath:@"result.user_status"];
    
    
    
    //
    NSLog(@"xxx--%@",vals[0]);
    // NSString *s=[NSString stringWithFormat:@"%@",UsrSts[0]];
    if([vals[0] integerValue]==1)
    {
        NSArray *usrName=[dataDictionaryResponse valueForKeyPath:@"result.full_name"];
        NSArray *usrGndr=[dataDictionaryResponse valueForKeyPath:@"result.gender"];
        NSArray *UsrAge=[dataDictionaryResponse valueForKeyPath:@"result.user_age"];
        NSArray *UserEmail=[dataDictionaryResponse valueForKeyPath:@"result.user_email"];
        NSArray *UsrId=[dataDictionaryResponse valueForKeyPath:@"result.user_id"];
        // NSArray *UsrPsswd=[dataDictionaryResponse valueForKeyPath:@"result.user_password"];
        
        [defaults setObject:usrName[0] forKey:@"username"];
        [defaults setObject:usrGndr[0] forKey:@"userGender"];
        [defaults setObject:UsrAge[0] forKey:@"userAge"];
        [defaults setObject:UserEmail[0] forKey:@"userEmail"];
        [defaults setObject:UsrId[0] forKey:@"userId"];
        [defaults setObject:@"fb" forKey:@"usertype"];
        //        //[defaults setObject:UsrPsswd[0] forKey:@"userPasswd"];
        //        [defaults setObject:UsrSts[0] forKey:@"userStatus"];
        [self performSegueWithIdentifier:@"fbloginpush" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"fbregpush" sender:self];
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
