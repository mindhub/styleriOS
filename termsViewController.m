//
//  termsViewController.m
//  styler
//
//  Created by vishnu Mindbees on 04/03/17.
//  Copyright © 2017 Quickblox. All rights reserved.
//

#import "termsViewController.h"

@interface termsViewController ()

@end

@implementation termsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    defaults = [NSUserDefaults standardUserDefaults];
    NSString *check=[defaults objectForKey:@"launchchecked"];
    
    
    if([check isEqualToString:@"worked"])
    {
        
        NSLog(@"already worked");
        //_helpScrol.hidden=YES;
        
    }
    else
    {
        
       // [self helpviewing];
        NSLog(@"First time");
        [defaults setObject:@"worked" forKey:@"launchchecked"];
        
    }
        

    // Do any additional setup after loading the view.
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
