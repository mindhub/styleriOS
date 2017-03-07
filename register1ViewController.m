//
//  register1ViewController.m
//  styler
//
//  Created by vishnu Mindbees on 07/03/17.
//  Copyright © 2017 Quickblox. All rights reserved.
//

#import "register1ViewController.h"
#import "KVNProgress.h"
@interface register1ViewController ()

@end

@implementation register1ViewController

- (void)viewDidLoad {
    _mainScroll.contentSize = CGSizeMake(_mainScroll.frame.size.width,_mainScroll.frame.size.height + (_mainScroll.frame.size.height)*32/100);
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)maleClk
{
    [_maleBtn setBackgroundImage:[UIImage imageNamed:@"agree.png"] forState:UIControlStateNormal];
     [_femaleBtn setBackgroundImage:[UIImage imageNamed:@"dont-agree.png"] forState:UIControlStateNormal];
}
-(IBAction)femaleClk
{
    [_maleBtn setBackgroundImage:[UIImage imageNamed:@"dont-agree.png"] forState:UIControlStateNormal];
    [_femaleBtn setBackgroundImage:[UIImage imageNamed:@"agree.png"] forState:UIControlStateNormal];
}
- (IBAction)editImage
{
    profileSheet = [[UIActionSheet alloc]initWithTitle:@"Upload Image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: @"Take Picture", @"Upload From Library", nil];
    [profileSheet showFromTabBar:self.tabBarController.tabBar];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet==profileSheet)
    {
        if (buttonIndex==0)
        {
            
            
            imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self presentViewController:self->imagePicker animated:YES completion:nil];
                
            });
            
            
        }
        if (buttonIndex==1)
        {
            
            imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:self->imagePicker animated:YES completion:nil];
                
            });
            
            
        }
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [KVNProgress show];
    });
    imageData= UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerEditedImage], 0.5);
    
    // NSLog(@"%@",imageData);
    
    if (imageData!=nil)
    {
        CALayer * ll = [_usrImg layer];
        [ll setMasksToBounds:YES];
        
        [ll setCornerRadius:_usrImg.frame.size.width/2];
        _usrImg.image = [UIImage imageWithData:imageData];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        if (self->imageData!=nil)
        {
            [KVNProgress dismiss];
           // [self uploadPhoto];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
