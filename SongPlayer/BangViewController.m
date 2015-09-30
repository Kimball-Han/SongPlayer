//
//  BangViewController.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-22.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "BangViewController.h"

#import "RequestUrl.h"
#import "HttpRequest.h"
#import "TableViewCell.h"
#import "SongModel.h"
#import <UIImageView+AFNetworking.h>
#import "CExpandHeader.h"
#import "MusicCenterController.h"
@interface BangViewController ()<UITableViewDataSource,UITableViewDelegate>
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

@implementation BangViewController
- (IBAction)popview:(id)sender {
    _tableView.contentOffset=CGPointMake(0, 0);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self customUI];
    [self getdata];
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
      
    }
    return self;
}



-(void)customUI
{
    
    [_tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"GUCESS"];
   _tableView.delegate=self;
    _tableView.dataSource=self;
     _dataArr=[[NSMutableArray alloc] init];
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 200)];
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, Screen_Width, Screen_Width)];
    //[_headImg setImage:[UIImage imageNamed:@"bg.jpg"]];
    
    
    _headImg.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
    _headImg.clipsToBounds = YES;
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _head = [CExpandHeader expandWithScrollView:_tableView expandView:customView];
    
    [customView addSubview:_headImg];
    [self.view bringSubviewToFront:backButton];
    

}
-(void)getdata
{
    [[HttpRequest shareRequestManager] getBangSongsUrl:[NSString stringWithFormat:getBangSongsListUrl ,[self.type integerValue]]returnData:^(id dic ,NSError *error){
        
        NSArray *arr=dic[@"song_list"];
        if (dic[@"song_list"] !=[NSNull null]) {
            for (NSDictionary *subdic in arr) {
                SongModel *m=[[SongModel alloc] init];
                m.titlestr=subdic[@"title"];
                [m setValuesForKeysWithDictionary:subdic];
                [_dataArr addObject:m];
            }
          
        }
        [_tableView reloadData];
        [_headImg setImageWithURL:[NSURL URLWithString:dic[@"billboard"][@"pic_s640"]]placeholderImage:[UIImage imageNamed:@"35.jpg"]];

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
    TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"GUCESS"];
    SongModel *m=_dataArr[indexPath.row];
    [cell.img setImageWithURL:[NSURL URLWithString:m.pic_small]];
    cell.titleLB.text=m.titlestr;
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
//    if (scrollView.contentOffset.y>-64) {
//        topview.alpha=1;
//    }else {
//        topview.alpha=0;
//    }
//    
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
