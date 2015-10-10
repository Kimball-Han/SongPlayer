//
//  HomeViewController.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-18.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "HomeViewController.h"
#import "CExpandHeader.h"
#import "HttpRequest.h"
#import "RequestUrl.h"
#import "Headview.h"
#import "MenuView.h"
#import "MusicViewController.h"
#import "TableViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "SongModel.h"
#import "MusicCenterController.h"
#import "MessageCenter.h"
#import "SearchController.h"
#import "MySongListViewController.h"
#import "LocalViewController.h"
#import "FavoriteViewController.h"
#import "SongClass.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    __weak IBOutlet UITableView *_tableview;
    CExpandHeader *_header;
    Headview *_weatherView;
    NSMutableArray *_dataArr;
    
    
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customhead];
    [self getdata];
    
}
-(void)customhead
{
    MessageCenter *cet=[MessageCenter MessageManager];
    cet.searchInfo=^(id keyStr){
        SearchController *searc=[[SearchController alloc] init];
        searc.keyStr=keyStr;
        [self.navigationController pushViewController:searc animated:YES];
    };
    //代理的设置
    _tableview.dataSource=self;
    _tableview.delegate=self;
    _tableview.showsVerticalScrollIndicator=NO;
    //数组的初始化
    _dataArr=[[NSMutableArray alloc] init];
    //cell的注册
    [_tableview registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"GUCESS"];
    [_tableview reloadData];
    //可以下拉放大图片的定制
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 200)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, Screen_Width, 200)];
    [imageView setImage:[UIImage imageNamed:@"121.jpg"]];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _header = [CExpandHeader expandWithScrollView:_tableview expandView:customView];
    [customView addSubview:imageView];
    //天气模块的定制
      _weatherView=[[[NSBundle mainBundle] loadNibNamed:@"Headview" owner:self options:nil] lastObject];
    _weatherView.frame=CGRectMake(0, 0-_tableview.contentOffset.y-200, Screen_Width, 200);
    [_weatherView startloaction];
    [self.view addSubview:_weatherView];
    
 _tableview.showsVerticalScrollIndicator=NO;
    //本地音乐，收藏单曲，我的歌单，音乐库所在的view
    MenuView *view=[[[NSBundle mainBundle]loadNibNamed:@"MenuView" owner:self options:nil] lastObject];
    //view作为tableView的透视图
    _tableview.tableHeaderView=view;
    view.userInteractionEnabled=YES;
    [view.myLIst addTarget:self action:@selector(menuClick:) forControlEvents:UIControlEventTouchUpInside];
    [view.shoucang addTarget:self action:@selector(menuClick:) forControlEvents:UIControlEventTouchUpInside];
    [view.MusicList addTarget:self action:@selector(menuClick:) forControlEvents:UIControlEventTouchUpInside];
    [view.localButton addTarget:self action:@selector(menuClick:) forControlEvents:UIControlEventTouchUpInside];
    view.bounds=CGRectMake(0, 0, Screen_Width, 80);
    
    
}

-(void)menuClick:(UIButton *)b
{

    switch (b.tag) {
        case 10:
        {
            LocalViewController*localVc=[LocalViewController DownloadCenter];
            localVc.isPresent=NO;
            [self.navigationController pushViewController:localVc animated:YES];
        }
            break;
        case 11:
        {
            FavoriteViewController *favorVC=[[FavoriteViewController alloc] init];
            [self.navigationController pushViewController:favorVC animated:YES];
            
        }
            break;
        case 12:
        {
            MySongListViewController *myVc=[[MySongListViewController alloc] init];
            [self.navigationController pushViewController:myVc animated:YES ];
        }
            break;
        case 13:
        {
            MusicViewController *music=[[MusicViewController alloc] init];
            [self.navigationController pushViewController:music animated:YES];
        }
            break;
            
        default:
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
//猜你喜欢的数椐请求
-(void)getdata
{
    [[HttpRequest shareRequestManager] getLikeRecommdUrl:guessYourlikeUrl returnData:^(id response,NSError *error){
        //网络请求的数据
        [_dataArr addObjectsFromArray:response];
        //歌单刷新到UI
        [_tableview reloadData];
        
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        _weatherView.frame=CGRectMake(0, 0-_tableview.contentOffset.y-200, Screen_Width, 200);
    
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
    [cell.img setImageWithURL:[NSURL URLWithString:m.pic_small] placeholderImage:[UIImage imageNamed:@""]];
    cell.titleLB.text=m.titlestr;
    cell.author.text=m.author;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
    label.text=@"  猜你喜欢";
    label.backgroundColor=[UIColor whiteColor];
    label.font=[UIFont systemFontOfSize:18];
    return label;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicCenterController *center=[MusicCenterController CenterController];
    center.dataArr=_dataArr;
    center.curentIndex=indexPath.row;
    [center playsong];
    


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
