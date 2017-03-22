//
//  startViewController.m
//  styler
//
//  Created by vishnu Mindbees on 06/03/17.
//  Copyright © 2017 Quickblox. All rights reserved.
//

#import "startViewController.h"
#import "KVNProgress.h"
#import <Reachability.h>
@interface startViewController ()

@end

@implementation startViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"deflts val--%@",[defaults objectForKey:@"userid"]);
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    defaults = [NSUserDefaults standardUserDefaults];
    NSString *check=[defaults objectForKey:@"launchchecked"];
    
    
    if([check isEqualToString:@"worked"])
    {
        
        NSLog(@"already worked");
        //_helpScrol.hidden=YES;
        if ([defaults objectForKey:@"userid"]!=nil)
        {
            [self performSegueWithIdentifier:@"loggedSegue" sender:self];
            [KVNProgress dismiss];
        }
        else
        {
            [self performSegueWithIdentifier:@"myloginPush" sender:self];
            [KVNProgress dismiss];
            
        }
    }
    else
    {
        [self performSegueWithIdentifier:@"terms" sender:self];
        // [self helpviewing];
        NSLog(@"First time");
        [defaults setObject:@"worked" forKey:@"launchchecked"];
        [defaults synchronize];
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
