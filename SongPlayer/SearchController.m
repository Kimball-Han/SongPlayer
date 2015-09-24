//
//  SearchController.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-4-27.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "SearchController.h"
#import "TableViewCell.h"
#import "ListTCell.h"
#import "SongModel.h"
#import "ArtistModel.h"
#import "SongerCell.h"
#import "AlbumModel.h"
#import "ArtistSongsController.h"
#import "ViewController.h"
@interface SearchController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    __weak IBOutlet UISearchBar *searchBa;
    __weak IBOutlet UITableView *_tableView;
    NSMutableDictionary *_dataDic;
    __weak IBOutlet UISegmentedControl *segcon;
}

@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self getSearchData];
   
}
//搜索函数
-(void)getSearchData
{
    //如果搜索关键字为空不进行搜索操作
    if ([self.keyStr isEqualToString:@""]) {
        return;
    }
    //时间戳
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    //搜索请求
    [[HttpRequest shareRequestManager] searchWorksByUrl:[NSString stringWithFormat:SEARCH_URL,self.keyStr,timeSp] returnData:^(id dic,NSError *error){
        //数据
        [_dataDic addEntriesFromDictionary:dic];
        //页面刷新
        [_tableView reloadData];
    }];
}
-(void)createUI
{
    searchBa.showsCancelButton=YES;
    //代理的设置
    searchBa.delegate=self;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=NO;
    //cell的注册
    [_tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"GUCESS"];
     [_tableView registerNib:[UINib nibWithNibName:@"ListTCell" bundle:nil] forCellReuseIdentifier:@"CELLLIST"];
    [_tableView registerNib:[UINib nibWithNibName:@"SongerCell" bundle:nil] forCellReuseIdentifier:@"SOCELL"];
    _dataDic=[[NSMutableDictionary alloc] init];
    segcon.selectedSegmentIndex=0;
    //UISegmentedControl控件添加事件处理
    [segcon addTarget:self action:@selector(segButtonClick) forControlEvents:UIControlEventValueChanged];
}
-(void)segButtonClick
{
    [_tableView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (segcon.selectedSegmentIndex) {
        case 0:
        {
            return [_dataDic[@"songs"] count];
        }
            break;
        case 1:
        {
            return [_dataDic[@"artist"] count];
        }
            break;
        case 2:
        {
            return [_dataDic[@"album"] count];
        }
            break;
            
        default:
        {
            return 0;
        }
            break;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (segcon.selectedSegmentIndex) {
        case 0:
        {
         NSArray*   _dataArr=_dataDic[@"songs"];
            ListTCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CELLLIST"];
            SongModel *m=_dataArr[indexPath.row];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
            cell.songLb.textColor=[UIColor blackColor];
            cell.songLb.text=m.titlestr;
            cell.author.text=m.author;
            return cell;
        }
            break;
        case 1:
        {
             NSArray*   _dataArr=_dataDic[@"artist"];
            SongerCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SOCELL"];
            ArtistModel *m=_dataArr[indexPath.row];
            [cell.img setImageWithURL:[NSURL URLWithString:m.avatar_s500]];
            cell.nameLb.text=m.name;
            return cell;
        }
            break;
        case 2:
        {
            NSArray*   _dataArr=_dataDic[@"album"];
            SongerCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SOCELL"];
           AlbumModel *m=_dataArr[indexPath.row];
            [cell.img setImageWithURL:[NSURL URLWithString:m.pic_big]];
            cell.nameLb.text=m.titlestr;
            return cell;

        }
            break;
            
        default:
        {
            UITableViewCell *cell=[[UITableViewCell alloc] init];
            return cell;
        }
            break;
    }

   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (segcon.selectedSegmentIndex) {
        case 0:
        {
            NSArray*   _dataArr=_dataDic[@"songs"];
            MusicCenterController *center=[MusicCenterController CenterController];
            center.dataArr=_dataArr;
            center.curentIndex=indexPath.row;
            [center playsong];
            


        }
            break;
        case 1:
        {
            ArtistSongsController *svc=[[ArtistSongsController alloc] init];
            NSArray*   _dataArr=_dataDic[@"artist"];
            ArtistModel *m=_dataArr[indexPath.row];
            svc.ting_uid=m.ting_uid;
            [self.navigationController pushViewController:svc animated:YES ];

        }
            break;
        case 2:
        {
            NSArray*   _dataArr=_dataDic[@"album"];
            AlbumModel *m=_dataArr[indexPath.row];
            ViewController*vc=[[ViewController alloc] init];
            vc.ablum_id=m.album_id;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
        {
            
        }
            break;
    }

}



- (IBAction)pop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.keyStr=searchBar.text;
    [self getSearchData];
    searchBar.text=@"";
    [searchBar resignFirstResponder];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text=@"";
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (segcon.selectedSegmentIndex==0) {
        return 44;
    }else{
        return 55;
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
