//
//  ArtistSongsController.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-20.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "ArtistSongsController.h"
#import "TableViewCell.h"
#import "RequestUrl.h"
#import "HttpRequest.h"
#import "SongModel.h"
#import <MJRefresh.h>
#import "ArtistModel.h"
#import <UIImageView+AFNetworking.h>
#import "Infoview.h"
#import "MusicCenterController.h"
#import "CExpandHeader.h"
#import "UMSocial.h"
@interface ArtistSongsController ()<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UILabel *nameLb;
    __weak IBOutlet UIButton *backBut;
    __weak IBOutlet UIView *topview;
 
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UIButton *backKey;
    NSMutableArray *_dataArr;
    Infoview *_view;
    CExpandHeader *_head;
    UIImageView *_headImg;
}

@end

@implementation ArtistSongsController

- (IBAction)pop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    table.delegate=self;
    table.dataSource=self;
    
   [table registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"GUCESS"];
    topview.alpha=0;
    _dataArr=[[NSMutableArray alloc] init];
   _view=[[[NSBundle mainBundle]loadNibNamed:@"Infoview" owner:self options:nil ] lastObject];
    _view.frame=CGRectMake(0, 0, Screen_Width, 200);
    __weak ArtistSongsController *weakself=self;
    _view.share=^(ArtistModel *m){
        [UMSocialSnsService presentSnsIconSheetView:weakself
                                             appKey:@"55555d7467e58e80b9000d96"
                                          shareText:m.intro
                                         shareImage:[UIImage imageNamed:@"35.jpg"]
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToWechatTimeline,nil]
                                           delegate:(id)weakself];
        
        
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:m.avatar_s500];
    };
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 200)];
   _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, Screen_Width, Screen_Width)];
    //[_headImg setImage:[UIImage imageNamed:@"bg.jpg"]];
    
    
    _headImg.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
    _headImg.clipsToBounds = YES;
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _head = [CExpandHeader expandWithScrollView:table expandView:customView];
    _view.frame=CGRectMake(0, 0-table.contentOffset.y-200, Screen_Width, 200);
    [self.view addSubview:_view];
    [customView addSubview:_headImg];
    [self.view bringSubviewToFront:backKey];
    [self addrefreshUI];
}
-(void)addrefreshUI
{
  
        self.offset=0;
        [self getinfo];
        [self getSongs];
    [table addLegendFooterWithRefreshingBlock:^{
        self.offset+=50;
        [self getSongs];
    }];
}
-(void)getinfo
{
    [[HttpRequest shareRequestManager] getArtistInfoUrl:[NSString stringWithFormat:ArtistInfoUrl,self.ting_uid] returnData:^(id res,NSError *error){
        ArtistModel *m=(ArtistModel *)res;
        [_headImg setImageWithURL:[NSURL URLWithString:m.avatar_s500]placeholderImage:[UIImage imageNamed:@"33.jpg"]];
        
        nameLb.text=m.name;
        _view.m=m;
    }];
}
-(void)getSongs
{
    [[HttpRequest shareRequestManager] getArtistSongListUrl:[NSString stringWithFormat:ArtistSongListUrl,self.ting_uid,(long)self.offset] returnData:^(id res,NSError *error){
        if (self.offset==0) {
            [_dataArr removeAllObjects];
            [_dataArr addObjectsFromArray:res];
            [table.header endRefreshing];
        }else{
             [_dataArr addObjectsFromArray:res];
            [table.footer endRefreshing];
        }
        [table reloadData];
}];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
      _view.frame=CGRectMake(0, 0-table.contentOffset.y-200, Screen_Width, 200);
    if (scrollView.contentOffset.y>-64) {
        topview.alpha=1;
    }else {
        topview.alpha=0;
    }
   
}



@end
