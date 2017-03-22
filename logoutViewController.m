//
//  logoutViewController.m
//  styler
//
//  Created by vishnu Mindbees on 21/03/17.
//  Copyright © 2017 Quickblox. All rights reserved.
//

#import "logoutViewController.h"

@interface logoutViewController ()

@end

@implementation logoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)logout
{
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"userid"];
    [defaults synchronize];
    [self performSegueWithIdentifier:@"logout" sender:self];
    
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
