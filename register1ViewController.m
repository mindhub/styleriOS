//
//  register1ViewController.m
//  styler
//
//  Created by vishnu Mindbees on 07/03/17.
//  Copyright © 2017 Quickblox. All rights reserved.
//

#import "register1ViewController.h"
#import "KVNProgress.h"
#import <Reachability.h>

@interface register1ViewController ()
{
    UIBarButtonItem *flexibleSpace,*prevButton,*nextButton,*doneButton;
    UIToolbar *keyBar;
    UITextField *activeField;
    
}
@end

@implementation register1ViewController

- (void)viewDidLoad {
    gndrVal=@"none";
    iLikeVal=@"none";
    privVal=@"unchecked";
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(fetchEthnicity) object:nil];
    [queue addOperation:operation];
    _mainScroll.contentSize = CGSizeMake(_mainScroll.frame.size.width,_mainScroll.frame.size.height + (_mainScroll.frame.size.height)*25/100);
    _dateBackgroundview.hidden=YES;
    _getlocview.hidden=YES;
    _donembut.hidden=YES;
    _cancelmbut.hidden=YES;
    _ethctyView.hidden=YES;
    _emailAlrtVw.hidden=YES;
    _pwdAlrtVw.hidden=YES;
    _frstNmALrtVw.hidden=YES;
    _lstNmAlrtVw.hidden=YES;
    _locAlrtVw.hidden=YES;
    _usernmeAlrtVw.hidden=YES;
    if ([UIScreen mainScreen].bounds.size.height==736)
    {
        _mainScroll.contentSize = CGSizeMake(_mainScroll.frame.size.width,_mainScroll.frame.size.height + (_mainScroll.frame.size.height)*27/100);
    }
    if ([UIScreen mainScreen].bounds.size.height==667)
    {
        _mainScroll.contentSize = CGSizeMake(0,720);
    }
    if ([UIScreen mainScreen].bounds.size.height==568)
    {
        _mainScroll.contentSize = CGSizeMake(0,620);
    }
    if ([UIScreen mainScreen].bounds.size.height==480)
    {
        _mainScroll.contentSize = CGSizeMake(0,620);
        keyBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, 320, 40)];
    }
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
    
    UIView* dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _locTxt.inputView = dummyView;
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    _mpView.showsUserLocation = YES;
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
#endif
    [self.locationManager startUpdatingLocation];
    
    
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foundTap:)];
    
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 1;
    [self.mpView addGestureRecognizer:tapRecognizer];
    CLLocation *location = [self.locationManager location];
    CLLocationCoordinate2D tapPoint = [location coordinate];
    MKPointAnnotation *point1 = [[MKPointAnnotation alloc] init];
    point1.coordinate = tapPoint;
    [_mpView addAnnotation:point1];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    _mpView.showsUserLocation = YES;
    [self.locationManager startUpdatingLocation];
    CLLocation *location = [self.locationManager location];
    CLLocationCoordinate2D tapPoint = [location coordinate];
    MKPointAnnotation *point1 = [[MKPointAnnotation alloc] init];
    point1.coordinate = tapPoint;
    
    lat=[NSString stringWithFormat:@"%f",tapPoint.latitude];
    
    lng=[NSString stringWithFormat:@"%f",tapPoint.longitude];
    CLGeocoder *ceo = [[CLGeocoder alloc]init];
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:[lat floatValue] longitude:[lng floatValue]];
    
    
    MKCoordinateRegion region;
    region = MKCoordinateRegionMake(tapPoint, MKCoordinateSpanMake(0.5, 0.5));
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    MKCoordinateRegion adjustedRegion = [_mpView regionThatFits:region];
    [_mpView setRegion:adjustedRegion animated:YES];
    
    
    [ceo reverseGeocodeLocation: loc completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         // point1.title=@"SAVE LIFE";
         locStr=placemark.locality;
         
         
         if(locStr.length==0)
         {
             
             locStr=placemark.subLocality;
         }
         
         
     }];
}
- (void)setupMapForLocatoion:(CLLocation *)newLocation
{
    NSLog(@"OHOOOOOOOOOOOOOOOOOOO");
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude=[lat floatValue];
    location.longitude=[lng floatValue];
    
    //self.locationManager.distanceFilter = 10.0f;
    
    region.span = span;
    region.center = location;
    [self.mpView setRegion:region animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    [self.locationManager stopUpdatingLocation];
    
    // [self setupMapForLocatoion:newLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    [self.locationManager stopUpdatingLocation];
}
-(IBAction)foundTap:(UITapGestureRecognizer *)recognizer
{
    // NSLog(@"Tappi");
    CGPoint point = [recognizer locationInView:_mpView];
    
    CLLocationCoordinate2D tapPoint = [_mpView convertPoint:point toCoordinateFromView:self.view];
    
    MKPointAnnotation *point1 = [[MKPointAnnotation alloc] init];
    
    point1.coordinate = tapPoint;
    [_mpView removeAnnotations:_mpView.annotations];
    
    point1.subtitle = [NSString stringWithFormat:@"Lat: %f, Long: %f",tapPoint.latitude, tapPoint.longitude];
    [_mpView addAnnotation:point1];
    // NSLog(@"point lat long::%@",point1.subtitle);
    
    lat=[NSString stringWithFormat:@"%f",tapPoint.latitude];
    
    lng=[NSString stringWithFormat:@"%f",tapPoint.longitude];
    
    
    CLGeocoder *ceo = [[CLGeocoder alloc]init];
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:[lat floatValue] longitude:[lng floatValue]];
    
    [ceo reverseGeocodeLocation: loc completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         //point1.title=@"SAVE LIFE";
         locStr=placemark.locality;
         
         
         if(locStr.length==0)
         {
             
             locStr=placemark.subLocality;
         }
         
         
         
     }];
    
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
    if(textField==_frstNameTxt)
    {
        _frstNmALrtVw.hidden=YES;
        [_mainScroll setContentOffset:CGPointMake(0, _frstNameTxt.frame.origin.y-70.0) animated:YES];
    }
    else if(textField==_lstNamTxt)
    {
        _lstNmAlrtVw.hidden=YES;
        [_mainScroll setContentOffset:CGPointMake(0, _lstNamTxt.frame.origin.y-70.0) animated:YES];
    }
    else if(textField==_usrNameTxt)
    {
        _usernmeAlrtVw.hidden=YES;
        [_mainScroll setContentOffset:CGPointMake(0, _usrNameTxt.frame.origin.y-70.0) animated:YES];
    }
    else if(textField==_emailTxt)
    {
        _emailAlrtVw.hidden=YES;
        [_mainScroll setContentOffset:CGPointMake(0, _emailTxt.frame.origin.y-70.0) animated:YES];
    }
    else if(textField==_pwdTxt)
    {
        _pwdAlrtVw.hidden=YES;
        [_mainScroll setContentOffset:CGPointMake(0, _pwdTxt.frame.origin.y-70.0) animated:YES];
    }
    else if(textField==_heightTxt)
    {
        //_pwdAlrtVw.hidden=YES;
        [_mainScroll setContentOffset:CGPointMake(0, _heightTxt.frame.origin.y-70.0) animated:YES];
    }
    else if(textField==_weightTxt)
    {
        //_pwdAlrtVw.hidden=YES;
        [_mainScroll setContentOffset:CGPointMake(0, _weightTxt.frame.origin.y-70.0) animated:YES];
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
    if (activeField==_frstNameTxt) {
        NSLog(@"test@E$#4");
        [_mainScroll setContentOffset:CGPointMake(0, 100.0) animated:YES];
        [_lstNamTxt becomeFirstResponder];
    }
    else if (activeField==_lstNamTxt) {
        NSLog(@"test@E$#4");
        [_mainScroll setContentOffset:CGPointMake(0, 100.0) animated:YES];
        [_usrNameTxt becomeFirstResponder];
    }
    else if (activeField==_usrNameTxt) {
        NSLog(@"test@E$#4");
        [_mainScroll setContentOffset:CGPointMake(0, 100.0) animated:YES];
        [_emailTxt becomeFirstResponder];
    }
    else if (activeField==_emailTxt) {
        NSLog(@"test@E$#4");
        [_mainScroll setContentOffset:CGPointMake(0, 100.0) animated:YES];
        [_pwdTxt becomeFirstResponder];
    }
    else if (activeField==_pwdTxt) {
        [_dobTxt becomeFirstResponder];
        [self datLblClk];
        //[_usrEmailTxt becomeFirstResponder];
    }
    else if(activeField==_dobTxt)
    {
        //[_locTxt becomeFirstResponder];
        [self locatnButton];
        NSLog(@"aaaa");
        
    }
    else if (activeField==_heightTxt) {
        [_weightTxt becomeFirstResponder];
        
        //[_usrEmailTxt becomeFirstResponder];
    }
    else if(activeField==_weightTxt)
    {
        [self.view endEditing:YES];
        //[_locTxt becomeFirstResponder];
        [self clkEthnicity];
        NSLog(@"aaaa");
        
    }
}

-(void)previousPressed
{
//    if (activeField==_cmpnyCodeTxt) {
//        [_cnfrmPasswdTxt becomeFirstResponder];
//    }
//    else if (activeField==_cnfrmPasswdTxt) {
//        [_psswdTxt becomeFirstResponder];
//    }
//    else if (activeField==_psswdTxt) {
//        [_usrEmailTxt becomeFirstResponder];
//    }
//    else if (activeField==_usrEmailTxt)
//    {
//        
//        [_usrAgeTxt becomeFirstResponder];
//    }
//    else if (activeField==_usrAgeTxt) {
//        [_usernameTxt becomeFirstResponder];
//    }
}

-(void)donePressed
{
    [self.view endEditing:YES];
}
-(IBAction)datLblClk
{
     [_mainScroll setContentOffset:CGPointMake(0, _dobTxt.frame.origin.y-70.0) animated:YES];
    _dateBackgroundview.hidden=NO;
    // _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 34, 0, 60)];
    [_dobTxt resignFirstResponder];
    
    //_datePicker.backgroundColor = [UIColor whiteColor];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _dobTxt.inputView=_datePicker;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps1 = [[NSDateComponents alloc] init];
    [comps1 setYear:-18];
    NSDate *minDate = [gregorian dateByAddingComponents:comps1 toDate:currentDate  options:0];
    [comps1 setYear:-150];
    NSDate *maxDate = [gregorian dateByAddingComponents:comps1 toDate:currentDate  options:0];
    _datePicker.minimumDate = minDate;
    _datePicker.maximumDate = maxDate;
    _datePicker.hidden = NO;
    [_datePicker addTarget:self action:@selector(pickDateLabel)forControlEvents:UIControlEventValueChanged];
    NSDateComponents* comps = [_datePicker.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay)
                                                      fromDate:_datePicker.date];
    NSInteger myDay = [comps day];
    NSInteger myMonth = [comps month];
    NSInteger myYear = [comps year];
    dateString =[NSString stringWithFormat:@"%ld-%ld-%ld",(long)myYear,(long)myMonth,(long)myDay];
    _dobTxt.text=dateString;
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    //pickerToolbar.tintColor = [UIColor redColor];
    [pickerToolbar sizeToFit];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"DONE" style:UIBarButtonItemStylePlain target:self action:@selector(setDatepickerVal)];
    
    [doneBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIColor grayColor],
                                     NSForegroundColorAttributeName,
                                     nil] forState:UIControlStateNormal];
    
    NSArray *itemArray = [[NSArray alloc] initWithObjects:  flexSpace, doneBtn, nil];
    
    [pickerToolbar setItems:itemArray animated:YES];
    
    
    
    
    //[_dateBackgroundview setBackgroundColor:[UIColor greenColor]];
   // [self.view addSubview:pickerToolbar];
    [_dateBackgroundview addSubview:pickerToolbar];
    [_dateBackgroundview addSubview:_datePicker];
    
    [self.view addSubview:_dateBackgroundview];
}
-(void)pickDateLabel
{
    NSDateComponents* comps = [_datePicker.calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay)
                                                      fromDate:_datePicker.date];
    NSInteger myDay = [comps day];
    NSInteger myMonth = [comps month];
    NSInteger myYear = [comps year];
    dateString =[NSString stringWithFormat:@"%ld-%ld-%ld",(long)myYear,(long)myMonth,(long)myDay];
    NSDateFormatter* fmt = [NSDateFormatter new];
    [fmt setDateFormat:@"mm/dd/yyyy"];
    _dobTxt.text=dateString;
    
}
-(void)setDatepickerVal
{
    //[self locatnButton];
    NSLog(@"Hide date");
    _dateBackgroundview.hidden=YES;
    // [_mainScroll setContentOffset:CGPointZero animated:YES];
}
-(IBAction)maleClk
{
    gndrVal=@"m";
    [_maleBtn setBackgroundImage:[UIImage imageNamed:@"agree.png"] forState:UIControlStateNormal];
     [_femaleBtn setBackgroundImage:[UIImage imageNamed:@"dont-agree.png"] forState:UIControlStateNormal];
    [_maleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_femaleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
-(IBAction)femaleClk
{
    gndrVal=@"f";
    [_maleBtn setBackgroundImage:[UIImage imageNamed:@"dont-agree.png"] forState:UIControlStateNormal];
    [_femaleBtn setBackgroundImage:[UIImage imageNamed:@"agree.png"] forState:UIControlStateNormal];
    [_femaleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_maleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
-(IBAction)maleRadioClk
{
    iLikeVal=@"m";
    
        [_maleRdio setBackgroundImage:[UIImage imageNamed:@"agree.png"] forState:UIControlStateNormal];
        [_femRdio setBackgroundImage:[UIImage imageNamed:@"dont-agree.png"] forState:UIControlStateNormal];
        [_bothRdio setBackgroundImage:[UIImage imageNamed:@"dont-agree.png"] forState:UIControlStateNormal];
    
    [_maleRdio setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_femRdio setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_bothRdio setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
-(IBAction)femaleRadioClk
{
    iLikeVal=@"f";
    [_femRdio setBackgroundImage:[UIImage imageNamed:@"agree.png"] forState:UIControlStateNormal];
    [_maleRdio setBackgroundImage:[UIImage imageNamed:@"dont-agree.png"] forState:UIControlStateNormal];
    [_bothRdio setBackgroundImage:[UIImage imageNamed:@"dont-agree.png"] forState:UIControlStateNormal];
    
    [_femRdio setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_maleRdio setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_bothRdio setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
-(IBAction)bothRadioClk
{
    iLikeVal=@"mf";
    [_bothRdio setBackgroundImage:[UIImage imageNamed:@"agree.png"] forState:UIControlStateNormal];
    [_maleRdio setBackgroundImage:[UIImage imageNamed:@"dont-agree.png"] forState:UIControlStateNormal];
    [_femRdio setBackgroundImage:[UIImage imageNamed:@"dont-agree.png"] forState:UIControlStateNormal];
    
    [_bothRdio setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_maleRdio setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_femRdio setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
- (IBAction)locatnButton
{
    _locAlrtVw.hidden=YES;
    [self.view endEditing:YES];
    _mpView.hidden=NO;
    _getlocview.hidden=NO;
    _donembut.hidden=NO;
    _cancelmbut.hidden=NO;
    _locTxt.text=locStr;
    //[_descTxt resignFirstResponder];
    //[_gamenameTxt resignFirstResponder];
}
- (IBAction)doneMap
{
    _mpView.hidden=YES;
    [_locTxt resignFirstResponder];
    //
    _getlocview.hidden=YES;
    _donembut.hidden=YES;
    _cancelmbut.hidden=YES;
    _locTxt.text=locStr;
}


- (IBAction)cancelMap
{
    _mpView.hidden=YES;
    [_locTxt resignFirstResponder];
    
    _getlocview.hidden=YES;
    _donembut.hidden=YES;
    _cancelmbut.hidden=YES;
    _locTxt.text=@"";
}
-(void)fetchEthnicity{
    defaults = [NSUserDefaults standardUserDefaults];
    NSString *usrId= [defaults valueForKey:@"userId"];
    NSString *post=[NSString stringWithFormat:@""];
    NSLog(@"xxxqq---%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSURL *theURL = [NSURL URLWithString:@"http://preview.proyectoweb.com/stylerapp/webservice/v1/getEthinicity"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
    
    //Specify method of request(Get or Post)
    [theRequest setHTTPMethod:@"GET"];
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
    NSLog(@"result --%@",theResponseData);
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
    
    
    //totalStr=[dataDictionaryResponse valueForKey:@"challenges"];
    NSArray *productArray=[dataDictionaryResponse objectForKey:@"result"];
    NSLog(@"Hummmm---%@",productArray);
    int i = 0;
    
    ethntyNameAry = [NSMutableArray array];
    ethntyIdAry = [NSMutableArray array];
   
    
    //    thmImgAry = [NSMutableArray array];
    //    cntAry = [NSMutableArray array];
    //    chlngDescAry = [NSMutableArray array];
    for (id myArrayElement in productArray) {
        int j=0;
        NSDictionary* chlg = [productArray objectAtIndex:i];
        //qstn = chlg[@"question"];
        //qstn = chlg[@"question"];
        
        //NSString *ii =[NSString stringWithFormat:@"%d",i];
        [ethntyNameAry addObject:chlg[@"ethnicity_title"]];
        [ethntyIdAry addObject:chlg[@"ethnicity_id"]];
        
        i++;
    }
    [ethntyNameAry addObject:@"Other"];
    [ethntyIdAry addObject:@"0"];
    NSLog(@"array--%@",ethntyNameAry);
    [self performSelectorOnMainThread:@selector(loadTbl) withObject:nil waitUntilDone:NO];
}
-(void)loadTbl
{
    [_ethnctyTbl reloadData];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ethntyIdAry count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"array--%@",musicTypeArry);
    static NSString *cellIdentifier=@"ethncyCell";
    ethnctyCell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    ethnctyCell.ethnicity.text=[ethntyNameAry objectAtIndex:indexPath.row];
    
   
    
    
    return ethnctyCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _ethctyView.hidden=YES;
    
    
    if([[ethntyNameAry objectAtIndex:indexPath.row] isEqualToString:@"Other"])
    {
        [_ethnicityTxt becomeFirstResponder];
        _ethnicityTxt.text=@"";
        ethctyIdval=[ethntyIdAry objectAtIndex:indexPath.row];
    }
    else
    {
        _ethnicityTxt.text=[ethntyNameAry objectAtIndex:indexPath.row];
        ethctyIdval=[ethntyIdAry objectAtIndex:indexPath.row];
    }
}
-(IBAction)clkEthnicity
{
    [_mainScroll setContentOffset:CGPointMake(0, _ethnicityTxt.frame.origin.y-70.0) animated:YES];
    _ethctyView.hidden=NO;
    [self donePressed];
}
-(IBAction)validateRegister
{
    defaults = [NSUserDefaults standardUserDefaults];
    NSString *check=[defaults objectForKey:@"reachability"];
    NSLog(@"De connection is - %@",check);
    if([check isEqualToString:@"online"])
    {
        if ([_frstNameTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length!=0)
        {
            if ([_lstNamTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length!=0)
            {
                if ([_usrNameTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length!=0)
                {
                if ([_emailTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length!=0)
                {
                    if ([_pwdTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length!=0)
                    {
                        if ([_locTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length!=0)
                        {
                            if([gndrVal isEqualToString:@"none"])
                                {
                                    [KVNProgress showErrorWithStatus:@"Please select your gender"];
                                }
                                else
                                {
                                    if([iLikeVal isEqualToString:@"none"])
                                    {
                                        [KVNProgress showErrorWithStatus:@"Please select you like male, female or both"];
                                    }
                                    else
                                    {
                                        if([privVal isEqualToString:@"checked"])
                                        {
                                            [KVNProgress show];
                                            NSOperationQueue *queue = [NSOperationQueue new];
                                            NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doregister) object:nil];
                                            [queue addOperation:operation];
                                        }
                                        else if([privVal isEqualToString:@"unchecked"])
                                        {
                                            [KVNProgress showErrorWithStatus:@"Please accept the privacy policy"];
                                        }
                                    }
                                }
                        }
                        else
                        {
                            _locAlrtVw.hidden=NO;
                        }
                    }
                    else
                    {
                        _pwdAlrtVw.hidden=NO;
                    }
            
                }
                else
                {
                    _emailAlrtVw.hidden=NO;
                }
                
                }
                else
                {
                    _usernmeAlrtVw.hidden=NO;
                }
            }
            else
            {
                _lstNmAlrtVw.hidden=NO;
            }
        }
        else
        {
            _frstNmALrtVw.hidden=NO;
        }
    }
    else
    {
        [KVNProgress showWithStatus:@"Please check network connectivity !"];
    }
}
-(IBAction)clkPrivacy
{
    if([privVal isEqualToString:@"unchecked"])
    {
        privVal=@"checked";
        [_privcyBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
    }
    else
    {
        privVal=@"unchecked";
        [_privcyBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-nil.png"] forState:UIControlStateNormal];
    }
}
-(void)doregister{
    
   
    defaults =[NSUserDefaults standardUserDefaults];
    NSString *post=[NSString stringWithFormat:@"full_name=%@&user_email=%@&user_password=%@&dob=%@&location=%@&latitude=%@&longitude=%@&gender=%@&height=%@&weight=%@&ethnicity_id=%@&preference=%@&username=%@",_frstNameTxt.text,_emailTxt.text,_pwdTxt.text,_dobTxt.text,_locTxt.text,lat,lng,gndrVal,_heightTxt.text,_weightTxt.text,ethctyIdval,iLikeVal,_frstNameTxt.text];
    NSLog(@"url---%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSURL *theURL = [NSURL URLWithString:@"http://preview.proyectoweb.com/stylerapp/webservice/v1/register"];
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
    userId =[dataDictionaryResponse valueForKeyPath:@"result.value"];
    if([userId integerValue]==1)
    {
        
        NSLog(@"sucess");
        
        [self uploadPhoto];
        [KVNProgress dismiss];
        //  [self performSegueWithIdentifier:@"regpush" sender:self];
    }
    else
    {
        NSString *vals =[dataDictionaryResponse valueForKeyPath:@"result.message"];
        [KVNProgress showErrorWithStatus:vals];
        NSLog(@"try again");
    }
    
    
}
- (void)uploadPhoto
{
    //  NSLog(@"upload");
    defaults = [NSUserDefaults standardUserDefaults];
    NSString *urlString = [NSString stringWithFormat:@"http://preview.proyectoweb.com/stylerapp/upload_photo.php?user_id=%@",userId];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    /*
     now lets create the body of the post
     */
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"29.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    //now lets make the connection to the web
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"uploaded url: %@",returnString);
    //ProfImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://developments.mindmockups.com/iphone_test/%@.jpg",sharedMySingleton.userId]]]];
    
    imageData = nil;
    
    
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
