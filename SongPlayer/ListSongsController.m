//
//  ListSongsController.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-23.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "ListSongsController.h"
#import "RequestUrl.h"
#import "HttpRequest.h"
#import "ListTCell.h"
#import "SongModel.h"
#import <UIImageView+AFNetworking.h>
#import "CExpandHeader.h"
#import "MusicCenterController.h"
@interface ListSongsController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    __weak IBOutlet UIView *topview;
    __weak IBOutlet UIButton *backButton;
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UILabel *titleName;
    NSMutableArray *_dataArr;
    CExpandHeader *_head;
    UIImageView *_headImg;
}

@end

@implementation ListSongsController

- (IBAction)popview:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr=[[NSMutableArray alloc] init];
    [self customUI];
    [self getdata];
    
}



-(void)customUI
{
    
    [_tableView registerNib:[UINib nibWithNibName:@"ListTCell" bundle:nil] forCellReuseIdentifier:@"CELLLIST"];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 200)];
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, Screen_Width, Screen_Width)];
    [_headImg setImage:[UIImage imageNamed:@"bg.jpg"]];
    
    
    _headImg.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
    _headImg.clipsToBounds = YES;
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _head = [CExpandHeader expandWithScrollView:_tableView expandView:customView];
    
    [customView addSubview:_headImg];
    [self.view bringSubviewToFront:backButton];
    
    
}
-(void)getdata
{
    [[HttpRequest shareRequestManager] getListSongsongUrl:[NSString stringWithFormat:getListSongsUrl,self.list]returnData:^(id dic ,NSError *error){
        
        NSArray *arr=dic[@"content"];
        if (dic[@"content"] !=[NSNull null]) {
            for (NSDictionary *subdic in arr) {
                SongModel *m=[[SongModel alloc] init];
                m.titlestr=subdic[@"title"];
                [m setValuesForKeysWithDictionary:subdic];
                [_dataArr addObject:m];
            }
            
        }
        [_tableView reloadData];
        titleName.text=dic[@"title"];
        [_headImg setImageWithURL:[NSURL URLWithString:dic[@"pic_500"]]placeholderImage:[UIImage imageNamed:@"35.jpg"]];
        
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CELLLIST"];
    SongModel *m=_dataArr[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
       cell.songLb.textColor=[UIColor blackColor];
    cell.songLb.text=m.titlestr;
    cell.author.text=m.author;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MusicCenterController *center=[MusicCenterController CenterController];
    center.dataArr=_dataArr;
    center.curentIndex=indexPath.row;
    [center playsong];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//   
//    if ( _tableView.contentOffset.y>-64) {
//        topview.hidden=NO;
//    }else {
//        topview.hidden=YES;
//    }
//    
//}
//- (void)dealloc{
//  
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
