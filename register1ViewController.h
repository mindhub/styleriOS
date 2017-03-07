//
//  register1ViewController.h
//  styler
//
//  Created by vishnu Mindbees on 07/03/17.
//  Copyright © 2017 Quickblox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface register1ViewController : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
  UIActionSheet *profileSheet;
  UIImagePickerController *imagePicker;
  NSData *imageData;
}
@property (nonatomic, retain) IBOutlet UIScrollView *mainScroll;
@property (nonatomic, retain) IBOutlet UIImageView *profImg;
@property (nonatomic, retain) IBOutlet UIButton *maleBtn,*femaleBtn;
@property (nonatomic, retain) IBOutlet UITextField *emailTxt,*pwdTxt,*dobTxt,*locTxt,*heightTxt,*weightTxt;
@property (nonatomic, retain) IBOutlet UITextView *lookingfr;
@property (weak, nonatomic) IBOutlet UIImageView *usrImg;
@end
