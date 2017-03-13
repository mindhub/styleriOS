//
//  tribesViewController.m
//  styler
//
//  Created by vishnu Mindbees on 13/03/17.
//  Copyright © 2017 Quickblox. All rights reserved.
//

#import "tribesViewController.h"
#import "KVNProgress.h"
@interface tribesViewController ()

@end

@implementation tribesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
        
        i++;
    }
    
    [self performSelectorOnMainThread:@selector(loadTbl) withObject:nil waitUntilDone:NO];
}
-(void)loadTbl
{
    [_tribeTbl reloadData];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)clkTribes{
    
    _tribeVw.hidden=NO;
    
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
