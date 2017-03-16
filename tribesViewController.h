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
    NSMutableArray *tribeNameAry,*tribeImgAry,*tribeIdAry,*tribNmValAry,*tribIdValAry,*tribImgValAry;
    NSString *tribeIdval,*tribeNameVal,*tribImgVal;
    NSIndexPath *slctVal;
    
}
@property (nonatomic, retain) IBOutlet UITableView *tribeTbl;
@property (nonatomic, retain) IBOutlet UIView *tribeVw;
@property (nonatomic, retain) IBOutlet UITextField *tribeName;
@property (nonatomic, retain) IBOutlet UIImageView *tribeBigImg;
@property (weak, nonatomic) IBOutlet UICollectionView *tribeColln;
@end
