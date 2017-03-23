//
//  reg3.m
//  styler
//
//  Created by vishnu Mindbees on 20/03/17.
//  Copyright © 2017 Quickblox. All rights reserved.
//

#import "reg3.h"
#import "KVNProgress.h"
@interface reg3 ()
{
    UIBarButtonItem *flexibleSpace,*prevButton,*nextButton,*doneButton;
    UIToolbar *keyBar;
    UITextField *activeField;
}
@end

@implementation reg3

- (void)viewDidLoad {
    _brandAlrtVw.hidden=YES;
    _stlIcnAlrtVw.hidden=YES;
    _brdDislikeAlrtVw.hidden=YES;
    _mainScroll.contentSize = CGSizeMake(_mainScroll.frame.size.width,_mainScroll.frame.size.height + (_mainScroll.frame.size.height)*27/100);
    keyBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, 320, 40)];
    [keyBar setBarStyle:UIBarStyleBlackOpaque];
    
    UIImage *image = [UIImage imageNamed:@"blue-field.png"];
    [[UIToolbar appearance] setBackgroundImage:image forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    prevButton = [[UIBarButtonItem alloc]initWithTitle:@"Previous"  style:UIBarButtonItemStylePlain target:self action:@selector(previousPressed)];
    [prevButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIColor whiteColor],
                                        NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateNormal];
    nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextPressed)];
    [nextButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIColor whiteColor],
                                        NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateNormal];
    doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(donePressed)];
    [doneButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIColor whiteColor],
                                        NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateNormal];
    [keyBar setItems:[NSArray arrayWithObjects:prevButton, nextButton, flexibleSpace, doneButton, nil]];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
    textField.inputAccessoryView = keyBar;
    prevButton.enabled = YES;
    nextButton.enabled = YES;
    //if(textField==_ageTxt)
    // {
    
    // _ageTxt.text=@"";
    // [_mainScroll setContentOffset:CGPointMake(0, 230) animated:YES];
    //}
    if(textField==_brands)
    {
        _brands.borderStyle = UITextBorderStyleLine;
        [_brands setBackgroundColor:[UIColor whiteColor]];
        _brandAlrtVw.hidden=YES;
        [_mainScroll setContentOffset:CGPointMake(0, _brands.frame.origin.y-70.0) animated:YES];
    }
    else if(textField==_stylIcons)
    {
        _stylIcons.borderStyle = UITextBorderStyleLine;
        [_stylIcons setBackgroundColor:[UIColor whiteColor]];
        _stlIcnAlrtVw.hidden=YES;
        [_mainScroll setContentOffset:CGPointMake(0, _stylIcons.frame.origin.y-70.0) animated:YES];
    }
    else if(textField==_dntgoout)
    {
        _dntgoout.borderStyle = UITextBorderStyleLine;
        [_dntgoout setBackgroundColor:[UIColor whiteColor]];
        _brdDislikeAlrtVw.hidden=YES;
        [_mainScroll setContentOffset:CGPointMake(0, _dntgoout.frame.origin.y-70.0) animated:YES];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [_mainScroll setContentOffset:CGPointZero animated:YES];
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [_mainScroll setContentOffset:CGPointZero animated:YES];
    return YES;
}
-(void)nextPressed
{
    if (activeField==_brands) {
        NSLog(@"test@E$#4");
        [_mainScroll setContentOffset:CGPointMake(0, 100.0) animated:YES];
        [_stylIcons becomeFirstResponder];
    }
    else if (activeField==_stylIcons) {
        NSLog(@"test@E$#4");
        [_mainScroll setContentOffset:CGPointMake(0, 100.0) animated:YES];
        [_dntgoout becomeFirstResponder];
    }
}
-(void)previousPressed
{
    if (activeField==_dntgoout) {
        NSLog(@"test@E$#4");
        [_mainScroll setContentOffset:CGPointMake(0, 100.0) animated:YES];
        [_stylIcons becomeFirstResponder];
    }
    else if (activeField==_stylIcons) {
        NSLog(@"test@E$#4");
        [_mainScroll setContentOffset:CGPointMake(0, 100.0) animated:YES];
        [_brands becomeFirstResponder];
    }
}
-(void)donePressed
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)validateReg
{
    if ([_brands.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length!=0)
    {
        if ([_stylIcons.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length!=0)
        {
            if ([_dntgoout.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length!=0)
            {
                [KVNProgress show];
                NSOperationQueue *queue = [NSOperationQueue new];
                NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(regFinal) object:nil];
                [queue addOperation:operation];
            }
            else
            {
                _dntgoout.borderStyle = UITextBorderStyleNone;
                [_dntgoout setBackgroundColor:[UIColor clearColor]];
                _brdDislikeAlrtVw.hidden=NO;
               // [KVNProgress showErrorWithStatus:@"Please enter you would never go out with one wearing value !"];
            }
        }
        else
        {
            _stylIcons.borderStyle = UITextBorderStyleNone;
            [_stylIcons setBackgroundColor:[UIColor clearColor]];
            _stlIcnAlrtVw.hidden=NO;
            //[KVNProgress showErrorWithStatus:@"Please enter style icons !"];
        }
    }
    else
    {
        _brands.borderStyle = UITextBorderStyleNone;
        [_brands setBackgroundColor:[UIColor clearColor]];
        _brandAlrtVw.hidden=NO;
        //[KVNProgress showErrorWithStatus:@"Please enter brand !"];
    }
    
}
-(void)regFinal{
    
    
    defaults =[NSUserDefaults standardUserDefaults];
    NSString *check=[defaults objectForKey:@"reachability"];
    NSLog(@"De connection is - %@",check);
    if([check isEqualToString:@"online"])
    {
        
        
        NSString *post=[NSString stringWithFormat:@"user_id=%@&user_email=&new_password=&firstname=&lastname=&dob=&location=&latitude=&longitude=&gender=&height=&weight=&ethnicity_id=&looking_for=&preference=&userbrands=%@& usertribes=&other_tribe=&user_styles_icons=%@& user_unliked=%@",_userId,_brands.text,_stylIcons.text,_dntgoout.text];
        NSLog(@"url---%@",post);
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        NSURL *theURL = [NSURL URLWithString:@"http://preview.proyectoweb.com/stylerapp/webservice/v1/updateprofile"];
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
        NSLog(@"resp---%@",theResponseData);
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
        NSString *val =[dataDictionaryResponse valueForKeyPath:@"result.value"];
        if([val integerValue]==1)
        {
            defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:_userId forKey:@"userid"];
            [defaults synchronize];
            [self performSelectorOnMainThread:@selector(redrct) withObject:nil waitUntilDone:YES];
            
            
            NSLog(@"sucess");
            //[KVNProgress showSuccessWithStatus:@"Tribes selected successfully!"];
            //[self performSegueWithIdentifier:@"brandsPush" sender:self];
        }
        else
        {
            NSString *vals =[dataDictionaryResponse valueForKeyPath:@"result.message"];
            [KVNProgress showErrorWithStatus:vals];
            NSLog(@"try again");
        }
        
    }
    else
    {
        [KVNProgress showErrorWithStatus:@"Please check network connectivity !"];
    }
}
-(void)redrct
{
    [KVNProgress dismiss];
    [KVNProgress showSuccessWithStatus:@"Logged in successfully"];
    [self performSegueWithIdentifier:@"log" sender:self];
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
