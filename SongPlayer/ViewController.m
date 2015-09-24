//
//  ViewController.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-23.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "ViewController.h"
#import "RequestUrl.h"
#import "HttpRequest.h"
#import "SongModel.h"
#import "TableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArr;
    __weak IBOutlet UILabel *titlename;
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UIView *topview;
    NSMutableDictionary *_infoDic;
    UIImageView *_imageView;
    
}

@end

@implementation ViewController
- (IBAction)buttontouch:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    _dataArr=[[NSMutableArray alloc] init];
    _infoDic=[[NSMutableDictionary alloc] init];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=NO;
    _imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    _tableView.tableHeaderView=_imageView;
    [_tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"GUCESS"];
    [self getData];
    
}
-(void)getData
{
    [[HttpRequest shareRequestManager] getAlubumSongsByurl:[NSString stringWithFormat:getAlblumSongsURL,_ablum_id] returnData:^(id dic,NSError *error){
        if (dic[@"songlist"]!=[NSNull null]) {
            for (NSDictionary *subDic in dic[@"songlist"]) {
                SongModel *m=[[SongModel alloc] init];
                m.titlestr=subDic[@"title"];
                [m setValuesForKeysWithDictionary:subDic];
                [_dataArr addObject:m];
            }
            [_infoDic addEntriesFromDictionary:dic[@"albumInfo"]];
            [_imageView setImageWithURL:[NSURL URLWithString:_infoDic[@"pic_s500"]]];
            titlename.text=_infoDic[@"title"];
            [_tableView reloadData];
        }
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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
 
//    if (scrollView.contentOffset.y>64) {
//        topview.alpha=1;
//    }else {
//        topview.alpha=0;
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
