//
//  tribesViewController.m
//  styler
//
//  Created by vishnu Mindbees on 13/03/17.
//  Copyright © 2017 Quickblox. All rights reserved.
//

#import "tribesViewController.h"
#import "KVNProgress.h"
#import "tribeCollectionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface tribesViewController ()
{
    tribeCollectionCell *tribeCell;
}
@end

@implementation tribesViewController

- (void)viewDidLoad {
    otherVal=@"NO";
    tribNmValAry = [NSMutableArray array];
    tribIdValAry = [NSMutableArray array];
    tribImgValAry = [NSMutableArray array];
    [super viewDidLoad];
    _othrView.hidden=YES;
    [_tribeColln setAllowsMultipleSelection:YES];
    _tribeVw.hidden=YES;
    [KVNProgress show];
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(fetchTribes) object:nil];
    [queue addOperation:operation];
    // Do any additional setup after loading the view.
}
-(void)fetchTribes{
    defaults = [NSUserDefaults standardUserDefaults];
    NSString *usrId= [defaults valueForKey:@"userId"];
    NSString *post=[NSString stringWithFormat:@"gender=m"];
    NSLog(@"xxxqq---%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSURL *theURL = [NSURL URLWithString:@"http://preview.proyectoweb.com/stylerapp/webservice/v1/getTribes"];
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
    
    tribeNameAry = [NSMutableArray array];
    tribeIdAry = [NSMutableArray array];
    tribeImgAry = [NSMutableArray array];
    
    
    //    thmImgAry = [NSMutableArray array];
    //    cntAry = [NSMutableArray array];
    //    chlngDescAry = [NSMutableArray array];
    for (id myArrayElement in productArray) {
        int j=0;
        NSDictionary* chlg = [productArray objectAtIndex:i];
        //qstn = chlg[@"question"];
        //qstn = chlg[@"question"];
        
        //NSString *ii =[NSString stringWithFormat:@"%d",i];
        [tribeNameAry addObject:chlg[@"tribe_title"]];
        [tribeIdAry addObject:chlg[@"tribe_id"]];
        [tribeImgAry addObject:chlg[@"tribe_img"]];

        
        i++;
    }
    
    [self performSelectorOnMainThread:@selector(loadTbl) withObject:nil waitUntilDone:NO];
}
-(void)loadTbl
{
    [_tribeColln reloadData];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tribeIdAry count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // NSLog(@"array--%@",musicTypeArry);
    static NSString *cellIdentifier=@"ethncyCell";
    ethnctyCell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    ethnctyCell.ethnicity.text=[tribeNameAry objectAtIndex:indexPath.row];
    
    
    
    
    return ethnctyCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _tribeVw.hidden=YES;
    
    
  
        _tribeName.text=[tribeNameAry objectAtIndex:indexPath.row];
        tribeIdval=[tribeIdAry objectAtIndex:indexPath.row];
    
}

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return [tribeIdAry count];
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    tribeCell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tick-selection.png"]];
    tribeCell = [collectionView
               dequeueReusableCellWithReuseIdentifier:@"tribCell"
               forIndexPath:indexPath];
    
    tribeCell.tribeName.text=[tribeNameAry objectAtIndex:indexPath.row];
    
    CALayer * ll = [tribeCell.tribeImg layer];
    [ll setMasksToBounds:YES];
    [ll setCornerRadius:2.0];
    CALayer * lv = [tribeCell.bgView layer];
    [lv setMasksToBounds:YES];
    [lv setCornerRadius:2.0];
    CALayer * ls = [tribeCell.cellBg layer];
    [ls setMasksToBounds:YES];
    [ls setCornerRadius:2.0];
    
    [tribeCell.tribeImg setImageWithURL:[NSURL URLWithString:[tribeImgAry objectAtIndex:indexPath.row]]placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    
//    tribeCell.tickImg.image = [UIImage imageNamed:@"deselected_image.png"];
//    tribeCell.tickImg.highlightedImage = [UIImage imageNamed:@"selected_image.png"];
    
    
    
    // NSURL *urli=[NSURL URLWithString:[catImageArry objectAtIndex:indexPath.row]];
    //  NSData *dat=[NSData dataWithContentsOfURL:urli];
    // catCell.catImg.image=[UIImage imageWithData:dat];
    
    
    
    
    
    
    
    return tribeCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"oho %li oho %li",(long)indexPath.section,indexPath.row);
    [tribeCell.tribeImg setImageWithURL:[NSURL URLWithString:[tribeImgAry objectAtIndex:indexPath.row]]placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    _tribeVw.hidden=NO;
    tribeNameVal=[tribeNameAry objectAtIndex:indexPath.row];
    tribeIdval=[tribeIdAry objectAtIndex:indexPath.row];
   
    NSLog(@"tribe : %@",tribeNameVal);
}
- (BOOL) collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //tribeCell.tickImg.image=[UIImage imageNamed:@"tick-selection.png"];
    tribeNameVal=[tribeNameAry objectAtIndex:indexPath.row];
    tribImgVal=[tribeImgAry objectAtIndex:indexPath.row];
    tribeIdval=[tribeIdAry objectAtIndex:indexPath.row];
    tribeCell.tickImg.hidden=NO;
    slctVal=indexPath;
    [_tribeBigImg setImageWithURL:[NSURL URLWithString:tribImgVal]placeholderImage:nil options:SDWebImageCacheMemoryOnly];
    NSLog(@"tribe Select : %@",tribeNameVal);
    if ([collectionView.indexPathsForSelectedItems containsObject: indexPath])
    {
        [collectionView deselectItemAtIndexPath: indexPath animated: YES];
        
        NSLog(@"ohoo--- %ld",(long)indexPath.row);
        return NO;
    }
    return YES;
}
- (BOOL) collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    tribeNameVal=[tribeNameAry objectAtIndex:indexPath.row];
    if ([tribNmValAry containsObject: tribeNameVal]) // YES
    {
        NSInteger Aindex = [tribNmValAry indexOfObject:tribeNameVal];
        NSLog(@"index - %ld",Aindex);
        [tribNmValAry removeObjectAtIndex: Aindex];
        [tribImgValAry removeObjectAtIndex: Aindex];
        [tribIdValAry removeObjectAtIndex: Aindex];
        
        // Do something
    }
    
    
    NSLog(@"tribe deselect : %@",tribIdValAry);
    if ([collectionView.indexPathsForSelectedItems containsObject: indexPath])
    {
        [collectionView deselectItemAtIndexPath: indexPath animated: YES];
        NSLog(@"Indexx--- %ld",(long)indexPath.row);
        return NO;
    }
    return YES;
}

-(IBAction)tribSlct
{
    
     [tribIdValAry addObject:tribeIdval];
     [tribNmValAry addObject:tribeNameVal];
    [tribImgValAry addObject:tribImgVal];
    NSLog(@"tribnameAr-%@",tribNmValAry);
    _tribeVw.hidden=YES;
}
-(IBAction)tribClose
{
    [_tribeColln deselectItemAtIndexPath:slctVal animated:NO];
    _tribeVw.hidden=YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)clkTribes{
    
    _tribeVw.hidden=NO;
    
}
-(IBAction)clkOther
{
    
    _othrView.hidden=NO;
}
-(IBAction)closeOther
{
    
    _othrView.hidden=YES;
    [self.view endEditing:YES];
}
-(IBAction)othrSubmit
{
    NSLog(@"tribouuuut--%@",tribOut);
    
    otherVal=_othrTxt.text;
    _othrView.hidden=YES;
     [self.view endEditing:YES];
    NSLog(@"OtherTRibOUt--%@",tribOut);
    
}
-(IBAction)submit
{
    NSLog(@"suu");
    defaults = [NSUserDefaults standardUserDefaults];
    
    
        if(([tribIdValAry count]==0)&& [otherVal isEqualToString:@"NO"])
        {
             [KVNProgress showErrorWithStatus:@"Please select one tribe !"];
            
 
        }
        else
        {
            
            [KVNProgress show];
            NSOperationQueue *queue = [NSOperationQueue new];
            NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(sbmtTribe) object:nil];
            [queue addOperation:operation];
        }
    
    
    
}
-(void)sbmtTribe{
    
    
    defaults =[NSUserDefaults standardUserDefaults];
    NSString *check=[defaults objectForKey:@"reachability"];
    NSLog(@"De connection is - %@",check);
    if([check isEqualToString:@"online"])
    {
        tribOut = [tribIdValAry componentsJoinedByString:@","];
    if([otherVal isEqualToString:@"NO"])
    {
        otherVal=@"";
    }
    tribOut= [NSString stringWithFormat:@"%@,0",tribOut];
    
    NSString *post=[NSString stringWithFormat:@"user_id=1&user_email=&new_password=&full_name=&dob=&location=&latitude=&longitude=&gender=&height=&weight=&ethnicity_id=&looking_for=&preference=&userbrands=& usertribes=%@&other_tribe=%@&user_styles_icons=& user_unliked=",tribOut,otherVal];
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
        
        NSLog(@"sucess");
        [KVNProgress showSuccessWithStatus:@"Tribes selected successfully!"];
        //  [self performSegueWithIdentifier:@"regpush" sender:self];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
