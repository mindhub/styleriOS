//
//  reg3.h
//  styler
//
//  Created by vishnu Mindbees on 20/03/17.
//  Copyright © 2017 Quickblox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface reg3 : UIViewController
{
    NSUserDefaults *defaults;
    NSDictionary *dataDictionaryResponse;
}
@property (nonatomic, retain) IBOutlet UITextField *brands,*stylIcons,*dntgoout;
@property (nonatomic, retain) IBOutlet NSString *userId;
@property (nonatomic, retain) IBOutlet UIView *brandAlrtVw,*stlIcnAlrtVw,*brdDislikeAlrtVw;
@property (nonatomic, retain) IBOutlet UIScrollView *mainScroll;
@end
