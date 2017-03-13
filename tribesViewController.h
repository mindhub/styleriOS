//
//  tribesViewController.h
//  styler
//
//  Created by vishnu Mindbees on 13/03/17.
//  Copyright © 2017 Quickblox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ethnicityCell.h"
@interface tribesViewController : UIViewController
{
    ethnicityCell *ethnctyCell;
    NSUserDefaults *defaults;
    NSDictionary *dataDictionaryResponse;
    NSMutableArray *tribeNameAry,*tribeIdAry;
    NSString *tribeIdval;
}
@property (nonatomic, retain) IBOutlet UITableView *tribeTbl;
@property (nonatomic, retain) IBOutlet UIView *tribeVw;
@property (nonatomic, retain) IBOutlet UITextField *tribeName;
@end
