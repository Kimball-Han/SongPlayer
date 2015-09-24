//
//  MySongListViewController.m
//  SongPlayer
//
//  Created by qianfeng01 on 15-5-5.
//  Copyright (c) 2015年 qianfeng01. All rights reserved.
//

#import "MySongListViewController.h"
#import "ListTCell.h"
#import "playeSongMoel.h"
#import "SqliteCenter.h"
@interface MySongListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mytableView;
@property(nonatomic,copy)NSMutableArray *dataArr;

@end

@implementation MySongListViewController
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
    
    self.mytableView.dataSource=self;
    self.mytableView.delegate=self;
    [self.mytableView registerNib:[UINib nibWithNibName:@"ListTCell" bundle:nil] forCellReuseIdentifier:@"CELLLIST"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CELLLIST"];
 playeSongMoel *m=_dataArr[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
   
    cell.songLb.textColor=[UIColor blackColor];
    cell.songLb.text=m.name;
    cell.author.text=m.author;
    return cell;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataArr=[[SqliteCenter shareDataCenter] readFaSongsFromSqlite];
    [_mytableView reloadData];
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
