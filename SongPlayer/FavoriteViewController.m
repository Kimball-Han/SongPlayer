//
//  FavoriteViewController.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-5-5.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "FavoriteViewController.h"
#import "ListTCell.h"
#import "SongModel.h"
#import "SqliteCenter.h"
@interface FavoriteViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property(copy,nonatomic)NSMutableArray *dataArr;

@end

@implementation FavoriteViewController
- (IBAction)pop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.dataSource=self;
    self.myTableView.delegate=self;
    [self.myTableView registerNib:[UINib nibWithNibName:@"ListTCell" bundle:nil] forCellReuseIdentifier:@"CELLLIST"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataArr=[[SqliteCenter shareDataCenter] readLocalSongsFromSqlite];
    [_myTableView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MusicCenterController CenterController].dataArr=_dataArr;
    [MusicCenterController CenterController].curentIndex=indexPath.row;
    [[MusicCenterController CenterController] playsong];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
    
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
