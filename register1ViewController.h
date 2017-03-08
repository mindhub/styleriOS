//
//  register1ViewController.h
//  styler
//
//  Created by vishnu Mindbees on 07/03/17.
//  Copyright © 2017 Quickblox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@interface register1ViewController : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MKMapViewDelegate,CLLocationManagerDelegate>
{
  UIActionSheet *profileSheet;
  UIImagePickerController *imagePicker;
  NSData *imageData;
    NSString *dateString,*locStr,*lat,*lng,*iLikeVal;
    UITapGestureRecognizer *tap;
}
@property (nonatomic, retain) IBOutlet UIScrollView *mainScroll;
@property (nonatomic, retain) IBOutlet UIImageView *profImg;
@property (nonatomic, retain) IBOutlet UIButton *maleBtn,*femaleBtn,*maleRdio,*femRdio,*bothRdio,*locbut,*donembut,*cancelmbut;
@property (nonatomic, retain) IBOutlet UITextField *emailTxt,*pwdTxt,*dobTxt,*locTxt,*heightTxt,*weightTxt,*ethnicityTxt;
@property (nonatomic, retain) IBOutlet UITextView *lookingfr;
@property (weak, nonatomic) IBOutlet UIImageView *usrImg;
@property (weak, nonatomic) IBOutlet UIView *dateBackgroundview;
@property (nonatomic,retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) CLLocationManager* locationManager;
@property (weak, nonatomic) IBOutlet UIView *getlocview,*musTypBgView;
@property (weak, nonatomic) IBOutlet MKMapView *mpView;
@end
