//
//  tribeCollectionCell.h
//  styler
//
//  Created by vishnu Mindbees on 16/03/17.
//  Copyright © 2017 Quickblox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tribeCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *tribeName;
@property (weak, nonatomic) IBOutlet UIImageView *tribeImg,*cellBg,*tickImg;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
