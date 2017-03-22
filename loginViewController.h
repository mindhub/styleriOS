//
//  loginViewController.h
//  styler
//
//  Created by vishnu Mindbees on 21/03/17.
//  Copyright © 2017 Quickblox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginViewController : UIViewController
{
    NSUserDefaults *defaults;
    NSDictionary *dataDictionaryResponse;
    UITextField *activeField;
}
@property (nonatomic, retain) IBOutlet UITextField *usrNmeTxt,*pwdTxt;
@property (nonatomic, retain) IBOutlet UIView *usrnmAlrtVw,*pwdAlrtVw;
@end
