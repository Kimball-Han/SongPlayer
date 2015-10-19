//
//  Headview.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-18.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "Headview.h"
#import "HttpRequest.h"
#import "RequestUrl.h"
#import "SongClass.h"
#import "MessageCenter.h"

@implementation Headview
{
    
    __weak IBOutlet UILabel *dayLb;
    
    __weak IBOutlet UILabel *cityLb;
    __weak IBOutlet UILabel *dulb;
    __weak IBOutlet UITextField *searchtext;
    __weak IBOutlet UIButton *cancalButton;
}
- (IBAction)search:(id)sender {
    [searchtext resignFirstResponder];
    MessageCenter *ce=[MessageCenter MessageManager];
    if (ce.searchInfo) {
        ce.searchInfo(searchtext.text);
    }
}

-(void)startloaction{
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] > 8)
    {
        /** 请求用户权限：分为：只在前台开启定位  /在后台也可定位， */
        
        /** 只在前台开启定位 */
        //        [self.locationManager requestWhenInUseAuthorization];
        
        /** 后台也可以定位 */
        [self.locationManager requestAlwaysAuthorization];
    }
    
    /** iOS9新特性：将允许出现这种场景：同一app中多个location manager：一些只能在前台定位，另一些可在后台定位（并可随时禁止其后台定位）。 */
    //[self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
    /** 开始定位 */
    [self.locationManager startUpdatingLocation];
    
}

#pragma mark -  定位代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *loc = [locations objectAtIndex:0];
    
    // NSLog(@"经纬度  %f  %f ",loc.coordinate.latitude,loc.coordinate.longitude);
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    // 经纬度对象
    
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
        // 回调中返回当前位置的地理位置信息
        // 描述地名的类
        CLPlacemark * placemark = placemarks[0];
        // NSLog(@">>%@ ,%@",placemark.name,placemark.subLocality);
     
            [self weatherrefresh:placemark.subLocality];
       
        
        
    }];
    
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self weatherrefresh:@"上海市"];
}
//天气模块的数据请求和刷新
-(void)weatherrefresh:(NSString *)city
{
    [[HttpRequest shareRequestManager] getWeatherInfoUrl:[NSString stringWithFormat:WeatherUrl,city] returnData:^(id response,NSError *error){
        //从数据中提取日期
        NSString *date1=response[@"date"];
        //从日期中提取今天是几号
        NSString *date2=[date1 substringFromIndex:6];
        int dat=[date2 intValue];
        //安全判断
        NSString *da=nil;
        cityLb.text=city;
        if (date1!=nil) {
            //对获得的日期解析为星期字符串
            da=[SongClass GetTime:date1];
        }//今天是几号显示到UI
        dayLb.text=[NSString stringWithFormat:@"%d",dat];
        //天气描述从数据中提取并显示到UI
        NSString *desstr=[NSString stringWithFormat:@"%@   %@℃  %@",response[@"weather"],response[@"temp"],da];
        dulb.text=desstr;
        
        
    }];
}
-(void)awakeFromNib
{
    searchtext.delegate=self;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    MessageCenter *ce=[MessageCenter MessageManager];
    if (ce.searchInfo) {
        ce.searchInfo(searchtext.text);
    }
    [searchtext resignFirstResponder];
    return YES;
}




@end
