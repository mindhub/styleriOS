//
//  register1ViewController.h
//  styler
//
//  Created by vishnu Mindbees on 07/03/17.
//  Copyright © 2017 Quickblox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ethnicityCell.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@interface register1ViewController : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MKMapViewDelegate,CLLocationManagerDelegate>
{
  UIActionSheet *profileSheet;
  UIImagePickerController *imagePicker;
  NSData *imageData;
    ethnicityCell *ethnctyCell;
    NSString *dateString,*locStr,*lat,*lng,*iLikeVal,*ethctyIdval,*privVal,*gndrVal,*userId;
    UITapGestureRecognizer *tap;
    NSUserDefaults *defaults;
    NSDictionary *dataDictionaryResponse;
    NSMutableArray *ethntyNameAry,*ethntyIdAry;
    
}
@property (nonatomic, retain) IBOutlet UIScrollView *mainScroll;
@property (nonatomic, retain) IBOutlet UIImageView *profImg;
@property (nonatomic, retain) IBOutlet UIButton *maleBtn,*femaleBtn,*maleRdio,*femRdio,*bothRdio,*locbut,*donembut,*cancelmbut,*privcyBtn,*ethnctyBtn;
@property (nonatomic, retain) IBOutlet UITextField *emailTxt,*pwdTxt,*dobTxt,*locTxt,*heightTxt,*weightTxt,*ethnicityTxt,*frstNameTxt,*lstNamTxt,*usrNameTxt;
@property (nonatomic, retain) IBOutlet UITextView *lookingfr;
@property (weak, nonatomic) IBOutlet UIImageView *usrImg;
@property (weak, nonatomic) IBOutlet UIView *dateBackgroundview,*emailAlrtVw,*pwdAlrtVw,*frstNmALrtVw,*lstNmAlrtVw,*locAlrtVw,*hghtAlrtVw,*wghtAlrtVw,*ethctyAlrtVw,*usernmeAlrtVw;
@property (nonatomic,retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) CLLocationManager* locationManager;
@property (weak, nonatomic) IBOutlet UIView *getlocview,*musTypBgView,*ethctyView;
@property (weak, nonatomic) IBOutlet MKMapView *mpView;
@property (weak, nonatomic) IBOutlet UITableView *ethnctyTbl;
@end
