//
//  regViewController.h
//  styler
//
//  Created by vishnu Mindbees on 13/03/17.
//  Copyright © 2017 Quickblox. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Reachability;
@interface regViewController : UIViewController
{
    NSUserDefaults *defaults;
    NSDictionary *dataDictionaryResponse;
    
}
@property (strong, nonatomic, readonly) Reachability *internetConnection;
@end
