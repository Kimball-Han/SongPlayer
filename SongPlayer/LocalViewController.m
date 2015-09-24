//
//  LocalViewController.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-5-5.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "LocalViewController.h"
#import "DownloadCell.h"
#import "LocalViewController.h"
@interface LocalViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *seg;
@end

@implementation LocalViewController
- (IBAction)pop:(id)sender {
    if (self.isPresent) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
    [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)segselsect:(id)sender {
    [_myTableView reloadData];
}
+(LocalViewController *)DownloadCenter
{
    static dispatch_once_t onceToken;
    static LocalViewController *downCenter=nil;
    dispatch_once(&onceToken, ^{
        downCenter=[[LocalViewController alloc] init];
    });
    return downCenter;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArr=[[NSMutableArray alloc] init];
        _DownLoadArr=[[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.dataSource=self;
    self.myTableView.delegate=self;
    [self.myTableView registerNib:[UINib nibWithNibName:@"DownloadCell" bundle:nil] forCellReuseIdentifier:@"Down"];
}
-(void)onclick
{
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.seg.selectedSegmentIndex==0) {
         return _dataArr.count;
    }else{
        return _DownLoadArr.count;
    }
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DownloadCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Down"];
    
    cell.Finish=^(SongDownloadCenter *model){
        [_DownLoadArr addObject:model];
        [_dataArr removeObject:model];
        [_myTableView reloadData];
    };
    if (self.seg.selectedSegmentIndex==0) {
        cell.hideProLabel=NO;
        cell.m=_dataArr[indexPath.row];
    }else{
        cell.hideProLabel=YES;
        cell.m=_DownLoadArr[indexPath.row];
    }
    return cell;
}
-(void)dataZhuanhuan
{
    for (SongDownloadCenter *m in _DownLoadArr) {
        SongModel *model=m.m;
        model.isLocal=YES;
        [_arr addObject:model];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.seg.selectedSegmentIndex==1) {
        [MusicCenterController CenterController].dataArr=_dataArr;
        [MusicCenterController CenterController].curentIndex=indexPath.row;
        [[MusicCenterController CenterController] playsong];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [_myTableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
    
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
