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
//天气模块的数据请求和刷新
-(void)weatherrefresh
{
    [[HttpRequest shareRequestManager] getWeatherInfoUrl:[NSString stringWithFormat:WeatherUrl,@"郑州市"] returnData:^(id response,NSError *error){
        //从数据中提取日期
        NSString *date1=response[@"date"];
        //从日期中提取今天是几号
        NSString *date2=[date1 substringFromIndex:6];
        int dat=[date2 intValue];
        //安全判断
        NSString *da=nil;
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
