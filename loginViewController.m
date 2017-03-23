//
//  loginViewController.m
//  styler
//
//  Created by vishnu Mindbees on 21/03/17.
//  Copyright © 2017 Quickblox. All rights reserved.
//

#import "loginViewController.h"
#import "KVNProgress.h"
@interface loginViewController ()

@end

@implementation loginViewController

- (void)viewDidLoad {
    [_usrNmeTxt setValue:[UIColor darkGrayColor]
                forKeyPath:@"_placeholderLabel.textColor"];
    [_pwdTxt setValue:[UIColor darkGrayColor]
              forKeyPath:@"_placeholderLabel.textColor"];
    _usrnmAlrtVw.hidden=YES;
    _pwdAlrtVw.hidden=YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
//    textField.inputAccessoryView = keyBar;
//    prevButton.enabled = YES;
//    nextButton.enabled = YES;
    //if(textField==_ageTxt)
    // {
    
    // _ageTxt.text=@"";
    // [_mainScroll setContentOffset:CGPointMake(0, 230) animated:YES];
    //}
    if(textField==_usrNmeTxt)
    {
        _usrnmAlrtVw.hidden=YES;
        //[_mainScroll setContentOffset:CGPointMake(0, _frstNameTxt.frame.origin.y-70.0) animated:YES];
    }
    else if(textField==_pwdTxt)
    {
        _pwdAlrtVw.hidden=YES;
        //[_mainScroll setContentOffset:CGPointMake(0, _frstNameTxt.frame.origin.y-70.0) animated:YES];
    }
}

-(IBAction)login
{
    defaults = [NSUserDefaults standardUserDefaults];
    NSString *check=[defaults objectForKey:@"reachability"];
    NSLog(@"De connection is - %@",check);
    if([check isEqualToString:@"online"])
    {
        if ([_usrNmeTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length!=0)
        {
            if ([_pwdTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length!=0)
            {
    [KVNProgress show];
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doLogin) object:nil];
    [queue addOperation:operation];
            }
            else
            {
                _pwdAlrtVw.hidden=NO;
            }
        }
        else
        {
            _usrnmAlrtVw.hidden=NO;
        }
    }
    else
    {
        [KVNProgress showErrorWithStatus:@"No internet connection !"];
    }
}
-(void)doLogin
{
    defaults=[NSUserDefaults standardUserDefaults];
    NSString *post=[NSString stringWithFormat:@"username=%@&password=%@",_usrNmeTxt.text,_pwdTxt.text];
    NSLog(@"ambada--%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSURL *theURL = [NSURL URLWithString:@"http://preview.proyectoweb.com/stylerapp/webservice/v1/login"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
    
    //Specify method of request(Get or Post)
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    // Pass some default parameter(like content-type etc.)
    // [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    // [theRequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    //Now pass your own parameter
    
    [theRequest setValue:@"stylapp@XYZ" forHTTPHeaderField:@"Oakey"];
    //  [theRequest setValue:@"fb" forHTTPHeaderField:@"Methoda"];
    [theRequest setHTTPBody:postData];
    
    NSURLResponse *theResponse = NULL;
    NSError *theError = NULL;
    NSData *theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
    NSLog(@"login--%@",theResponseData);
    // NSDictionary *dataDictionaryResponse;
    if (theResponseData == nil)
    {
        NSLog(@"no data grid");
    }
    else
    {
        dataDictionaryResponse = [NSJSONSerialization JSONObjectWithData:theResponseData options:0 error:&theError];
        NSLog(@"url to send request= %@",dataDictionaryResponse);
    }
    
    
    
    defaults = [NSUserDefaults standardUserDefaults];
    NSArray *vals=[dataDictionaryResponse valueForKeyPath:@"result.user_status"];
    NSArray *userIds=[dataDictionaryResponse valueForKeyPath:@"result.user_id"];
    NSArray *mesg=[dataDictionaryResponse valueForKeyPath:@"result.message"];
    
    
    
    //
    NSLog(@"xxx--%@",vals);
    // NSString *s=[NSString stringWithFormat:@"%@",UsrSts[0]];
    if([vals[0] integerValue]==1)
    {
        NSLog(@"akathu");
        //        NSArray *usrName=[dataDictionaryResponse valueForKeyPath:@"result.full_name"];
        //        NSArray *usrGndr=[dataDictionaryResponse valueForKeyPath:@"result.gender"];
        //        NSArray *UsrAge=[dataDictionaryResponse valueForKeyPath:@"result.user_age"];
        //        NSArray *UserEmail=[dataDictionaryResponse valueForKeyPath:@"result.user_email"];
        //        NSArray *UsrId=[dataDictionaryResponse valueForKeyPath:@"result.user_id"];
        //        // NSArray *UsrPsswd=[dataDictionaryResponse valueForKeyPath:@"result.user_password"];
        //        defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:userIds[0] forKey:@"userid"];
        //        [defaults setObject:usrGndr[0] forKey:@"userGender"];
        //        [defaults setObject:UsrAge[0] forKey:@"userAge"];
        //        [defaults setObject:UserEmail[0] forKey:@"userEmail"];
        //        [defaults setObject:UsrId[0] forKey:@"userId"];
        //        [defaults setObject:@"fb" forKey:@"usertype"];
        //        //[defaults setObject:UsrPsswd[0] forKey:@"userPasswd"];
        //        [defaults setObject:UsrSts[0] forKey:@"userStatus"];
        [defaults synchronize];
        [self performSelectorOnMainThread:@selector(redrctlogin) withObject:nil waitUntilDone:YES];
    }
    else
    {
        [KVNProgress showErrorWithStatus:mesg[0]];
       // [self performSelectorOnMainThread:@selector(fbregstr) withObject:nil waitUntilDone:YES];
        
    }
}
-(void)redrctlogin
{
    NSLog(@"REDRCT");
    [KVNProgress showSuccessWithStatus:@"Logged in successfully"];
    [self performSegueWithIdentifier:@"emailLoginPush" sender:self];
}
-(IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
