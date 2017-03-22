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
    NSMutableArray *tribeNameAry,*tribeImgAry,*tribeIdAry,*tribNmValAry,*tribIdValAry,*tribImgValAry,*slctImgAry;
    NSString *tribeIdval,*tribeNameVal,*tribImgVal,*tribOut,*otherVal;
    NSIndexPath *slctVal;
    
}
@property (nonatomic, retain) IBOutlet UITableView *tribeTbl;
@property (nonatomic, retain) IBOutlet UIView *tribeVw,*othrView;
@property (nonatomic, retain) IBOutlet UITextField *tribeName,*othrTxt;
@property (nonatomic, retain) IBOutlet UIImageView *tribeBigImg;
@property (weak, nonatomic) IBOutlet UICollectionView *tribeColln;
@property (nonatomic, retain) IBOutlet NSString *userId,*usrGndr;
@end
